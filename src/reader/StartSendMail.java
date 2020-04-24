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

class SendMail implements Runnable {//�˴������÷��ʼ��ĸ�������
	private static String from = "2942014051@qq.com";
    private static String user = "Mandarin Online Library System";
    private static String password = "oovblnxdeidhdceb"; //smtpЭ����˻���Ȩ��
    private static String mailHost = "smtp.qq.com";
    
    private static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	private static String DB_URL = "jdbc:mysql://localhost:3306/SPM_library_system";
	private static String USER = "root";
	private static String PASS = "1234";
    //run()��ѭ����ʱ����systemPrompt(), ʹ��while(true), ÿ��һ�����һ��
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
  	//��ѯLendReturn����δ�黹�鱾��������޵��ں��죬�����Ӧ�û�������ʾ�ʼ�
  	
  	
    public void systemPrompt() {
    	// ����������ڲ�ת��Ϊ���ݿ����������޶�Ӧ��ʽ
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
				// �ж��Ƿ����ʼ�������Ϊ�鱾δ�黹���������Ϊ����
				if(rs.getInt(8) == 0 && dl == rs.getInt(7)) {
					String account = rs.getString(2);
					String email = queryMail(account);
					if(!email.equals(null)) {
						// ����book_id��ѯ��Ӧbookname
						String bookname = queryBookName(rs.getString(5));
						DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
						String deadline = date.format(formatter1);
						String text = "Hello! The book \"" + bookname + 
								"\" you borrowed will be due on " + deadline + ", please return it in time.";
						String title = "Reminder to return books";
						// �����ʼ�
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
  	// �����˻���ѯ��Ӧ����
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
  	// ����book_id��ѯ��Ӧ��bookname
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
    // �����ʼ��ĺ���������Ϊ�Է�����to������text������title������ֵΪboolean���ͣ����ɹ������򷵻�true��
  	// �����쳣�򷵻�false��ʹ��MimeMessage�����ʼ�����
    public boolean sendMail(String to, String text, String title) {
    	Properties props = new Properties();
    	// ���÷����ʼ����ʼ�������������
    	props.put("mail.smtp.host", mailHost);
    	// У���û��������룬�ù���Ȩ
    	props.put("mail.smtp.auth", "true");
    	// �øո����úõ�props���󹹽�һ��session
    	Session session = Session.getDefaultInstance(props);
    	// �����������ڷ����ʼ��Ĺ�������console����ʾ������Ϣ��������ʹ��
    	// session.setDebug(true);
    	// ��sessionΪ����������Ϣ����
    	MimeMessage message = new MimeMessage(session);
    	try {
    		// ���ط����˵�ַ
        	message.setFrom(new InternetAddress(user + " <" + from + ">"));
        	// �����ռ��˵�ַ
        	message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        	// ���ر���
        	message.setSubject(title);
        	// ��multipart����������ʼ��ĸ����������ݣ������ı����ݺ͸���
        	Multipart multipart = new MimeMultipart();
        	// �����ʼ����ı�����
        	BodyPart contentPart = new MimeBodyPart();
        	contentPart.setContent(text, "text/html;charset=utf-8");
        	multipart.addBodyPart(contentPart);
        	message.setContent(multipart);
        	message.saveChanges(); // ����仯
        	// ���ӷ�����������
        	Transport transport = session.getTransport("smtp");
        	// ���ʼ����ͳ�ȥ
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
