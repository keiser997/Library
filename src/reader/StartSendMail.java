package reader;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
public class StartSendMail extends HttpServlet {
	Thread th;
	public void init() throws ServletException{
    	SendMail sm = new SendMail();
    	th = new Thread(sm);
    	th.start();
    	System.out.println("System Prompt started successfully");
    }
	public void destroy(){
		th.stop();
		
		
    	System.out.println("System Prompt stoped successfully");
	}
}

class SendMail implements Runnable {//此处可配置发邮件的各种属性
	private static String from = "2942014051@qq.com";
    private static String user = "Mandarin Online Library System";
    private static String password = "oovblnxdeidhdceb"; //smtp协议的账户授权码
    private static String mailHost = "smtp.qq.com";
    
    private static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	private static String DB_URL = "jdbc:mysql://localhost:3306/SPM_library_system";
	private static String USER = "root";
	private static String PASS = "1234";
    //run()里循环定时调用systemPrompt(), 使用while(true), 每隔一天调用一次
  	public void run() {
  		try {
  			while(true) {
  	  			systemPrompt();
  	  			TimeUnit.HOURS.sleep(24);
  	  		}
  	  	}catch(InterruptedException e) {
			e.printStackTrace();
		}
  	}
  	//查询LendReturn表，若未归还书本的最后期限等于后天，则对相应用户发送提示邮件
  	
  	
    public void systemPrompt() {
    	// 计算后天日期并转化为数据库表中最后期限对应格式
    	LocalDate now = LocalDate.now();
    	LocalDate date = now.plusDays(2);
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    	int dl = Integer.parseInt(date.format(formatter));
    	try {
			Class.forName(JDBC_DRIVER);
			Connection con = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from lendreturn");
			while(rs.next()) {
				// 判断是否发送邮件，条件为书本未归还且最后期限为后天
				if(rs.getInt(8) == 0 && dl == rs.getInt(7)) {
					String account = rs.getString(2);
					String email = queryMail(account);
					if(!email.equals(null)) {
						// 根据book_id查询对应bookname
						String bookname = queryBookName(rs.getString(5));
						DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
						String deadline = date.format(formatter1);
						String text = "Hello! The book \"" + bookname + 
								"\" you borrowed will be due on " + deadline + ", please return it in time.";
						String title = "Reminder to return books";
						// 发送邮件
						sendMail(email, text, title);
					}
				}
			}
			rs.close();
			st.close();
			con.close();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
    	} catch(SQLException e) {
			e.printStackTrace();
    	}
    }
  	// 根据账户查询对应邮箱
  	public String queryMail(String account) {
  		String email = "";
  		try {
			Class.forName(JDBC_DRIVER);
			Connection con = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from reader where re_account='" + account + "'");
			if(rs.next()) {
				email = rs.getString(3);
			}
			rs.close();
			st.close();
			con.close();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
    	} catch(SQLException e) {
			e.printStackTrace();
    	}
  		return email;
  	}
  	// 根据book_id查询对应的bookname
  	public String queryBookName(String book_id) {
  		String bookname = "";
  		try {
			Class.forName(JDBC_DRIVER);
			Connection con = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from book where book_id='" + book_id + "'");
			if(rs.next()) {
				bookname = rs.getString(8);
			}
			rs.close();
			st.close();
			con.close();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
    	} catch(SQLException e) {
			e.printStackTrace();
    	}
  		return bookname;
  	}
    // 发送邮件的函数，参数为对方邮箱to，正文text，标题title，返回值为boolean类型，若成功发送则返回true，
  	// 出现异常则返回false。使用MimeMessage进行邮件发送
    public boolean sendMail(String to, String text, String title) {
    	Properties props = new Properties();
    	// 设置发送邮件的邮件服务器的属性
    	props.put("mail.smtp.host", mailHost);
    	// 校验用户名和密码，用过授权
    	props.put("mail.smtp.auth", "true");
    	// 用刚刚设置好的props对象构建一个session
    	Session session = Session.getDefaultInstance(props);
    	// 下面这句可以在发送邮件的过程中在console处显示过程信息，供调试使用
    	// session.setDebug(true);
    	// 用session为参数定义消息对象
    	MimeMessage message = new MimeMessage(session);
    	try {
    		// 加载发件人地址
        	message.setFrom(new InternetAddress(user + " <" + from + ">"));
        	// 加载收件人地址
        	message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        	// 加载标题
        	message.setSubject(title);
        	// 向multipart对象中添加邮件的各个部分内容，包括文本内容和附件
        	Multipart multipart = new MimeMultipart();
        	// 设置邮件的文本内容
        	BodyPart contentPart = new MimeBodyPart();
        	contentPart.setContent(text, "text/html;charset=utf-8");
        	multipart.addBodyPart(contentPart);
        	message.setContent(multipart);
        	message.saveChanges(); // 保存变化
        	// 连接服务器的邮箱
        	Transport transport = session.getTransport("smtp");
        	// 把邮件发送出去
        	transport.connect(mailHost, from, password);
        	transport.sendMessage(message, message.getAllRecipients());
        	transport.close();
    	} catch (MessagingException e) {
    	    e.printStackTrace();
    	    return false;
    	}
    	return true;
    }
}
