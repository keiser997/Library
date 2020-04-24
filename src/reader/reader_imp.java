
package reader;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

public class reader_imp  {
	private static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	private static String DB_URL = "jdbc:mysql://localhost:3306/spm_library_system?serverTimezone=GMT%2B8&useSSL=false";
	private static String USER = "root";
	private static String PASS = "1234";
	public static boolean appointment(String book,String re_account)  {//预约函数，用于预约书
		Connection conn = null;
		PreparedStatement stmt = null;
		Statement st = null;
		ResultSet rs = null;
        String SQL =new String("insert into appointment value(?,?,?,?);");
        Random rm= new Random(47);
        System.out.println("fdsff");
        String id = new String();
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			stmt = conn.prepareCall(SQL);
			st = conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		id=Integer.toString(rm.nextInt(100))+Integer.toString(
				(int)(System.currentTimeMillis()%10000));
		long time=(int)(System.currentTimeMillis()/1000-1576800000);
		//扫描数据库，删除多余数据
		SQL = "delete from appointment where ap_start <="+String.valueOf(time-7200);
		try {
			st.executeUpdate(SQL);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		//查看是否该书已经被预定
		SQL = "select * from appointment where book_id = '"+book+"'";
		try {
			rs = st.executeQuery(SQL);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			if(!rs.next()) {
				stmt.setString(1, re_account);
				stmt.setString(2,book);
				stmt.setLong(3, time);
				stmt.setString(4, id);
				stmt.executeUpdate();
				System.out.println("预约成功");
				return true;
			}
			else {
				System.out.println("预约失败");
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("预约失败");
			return false;
		}
	}
	public static String logIn(String account, String pwd) { //登录
		String info = null;
		try {
			Class.forName(JDBC_DRIVER);
			Connection con = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement st1 = con.createStatement();
			ResultSet rs = st1.executeQuery("select * from reader where re_account='" + account + "'");
			if(rs.next()) { //判断是否查询到输入的账号
				if(rs.getInt(5) == 1){ //判断re_available是否为1
					if(rs.getInt(4) == 0 ) { // 判断re_login是否为0
						if(rs.getString(2).equals(pwd)) { // 判断对应账号的密码是否与输入一致
							info = "LOGIN SUCCESSFULLY"; //成功登录，接下来在数据库中修改登录状态re_login为1
							Statement st2 = con.createStatement();
							st2.executeUpdate("update reader set re_login=1 where re_account='" + account + "'");
							st2.close();
						} else {
							info = "WRONG PASSWORD"; //密码错误
						}
					} else {
						info = "ALREADY ONLINE"; //读者已登录
					}
				} else {
					info = "BLOCKED ACCOUNT"; //账号被冻结
				}
			} else {
				info = "WRONG ACCOUNT"; //账号不存在
			}
			rs.close();
			st1.close();
			con.close();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
    	} catch(SQLException e) {
			e.printStackTrace();
    	}
		System.out.println(info);
		return info;
	}
	public static void logOut(String account) { //登出，在数据库中修改读者的登录状态
		try {
			Class.forName(JDBC_DRIVER);
			Connection con = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement st = con.createStatement();
			//登出，修改对应账号的re_login为0
			st.executeUpdate("update reader set re_login=0 where re_account='" + account + "'");
			st.close();
			con.close();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
    	} catch(SQLException e) {
			e.printStackTrace();
    	}
	}
	public static boolean changePwd(String account,String oldPwd, String newPwd) { //修改对应账户的密码
		boolean flag = false;
		try {
			Class.forName(JDBC_DRIVER);
			Connection con = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement st1 = con.createStatement();
			ResultSet rs = st1.executeQuery("select * from reader where re_account='" + account + "'");
			if(rs.next()) {
				// 判断输入的旧密码是否与数据库里的密码一致
				if(rs.getString(2).equals(oldPwd)) {
					//修改账户的旧密码为新密码
					Statement st2 = con.createStatement();
					st2.executeUpdate("update reader set re_password='" + 
							newPwd + "' where re_account='"+ account + "'");
					flag = true;
					st2.close();
				}
			}
			rs.close();
			st1.close();
			con.close();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
    	} catch(SQLException e) {
			e.printStackTrace();
    	}
		return flag;
	}
	//此为用于查询图书的后端功能
	//s1为待查询关键字，t为类型，全类型则为0
	public static Book[] searchBook(String s1,int t) throws ClassNotFoundException
	{
		Book result[]=new Book[1000];//用于存放查询结果的Book数组
		int i=0;
		String s;
		System.out.println(s1);
		if(t==0)
			s="select * from book where auther like '%"+
					s1+"%' or book_name like '%"+s1+"%'";
		else
			s="select * from book where (auther like '%"+
					s1+"%' or book_name like '%"+s1+"%')"+
					"and book_type="+t;
		Connection con=null;
		try {
			Class.forName(JDBC_DRIVER);
			con=DriverManager.getConnection(DB_URL,USER,PASS);
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery(s);
			while(rs.next())
			{
				result[i]=new Book();
				result[i].id=rs.getString("book_id");
				result[i].bookType=rs.getInt("book_type");
				result[i].author=rs.getString("auther");
				result[i].borw=rs.getInt("borw");
				result[i].bookAva=rs.getInt("book_avalible");
				result[i].price=rs.getDouble("book_price");
				result[i].borwNum=rs.getInt("borw_num");
				result[i].name=rs.getString("book_name");
				result[i].floor=rs.getInt("floor");
				result[i].area=rs.getInt("area");
				result[i].bookShelf=rs.getInt("shelf");
				i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		int j=0;
		if(result[0]==null) {
			System.out.println("未找到该书！");
			return null;
		}
		System.out.println("id\t类型\t作者\t借出状态\t在籍状态\t价格\t借出次数\t"
				+"书名\t\t层号\t区号\t书架号\t");
		while(result[j]!=null)
		{
			System.out.println(result[j].id+"\t"+result[j].bookType+"\t"+result[j].author+"\t"+
					result[j].borw+"\t"+result[j].bookAva+"\t"+result[j].price+"\t"+result[j].borwNum+"\t"+result[j].name+"\t"+
					result[j].floor+"\t"+result[j].area+"\t"+result[j].bookShelf);
			j++;
		}
		return result;
	}
	public static double query_fine(String re_account)  {  // 这里输入的是读者的账户
        double total_fine = 0; // total_fine为最后总共的罚金
        try
        {
            ArrayList<String> books = Getbooksfromreader(re_account); // 获取读者的借阅情况
            for(String book : books) {
                total_fine += Getfines(book, re_account);
            }
        }
        catch(Exception e)
        {
            System.out.println(e.getMessage());
        }
        return total_fine;
    }
	static ArrayList<String> Getbooksfromreader(String re_account) throws ClassNotFoundException, SQLException {
        Class.forName(JDBC_DRIVER);
        Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
        String sql = "select book_id from LendReturn where fine_date is null and re_account = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(sql);
        preparedStatement.setString(1,re_account);
        ArrayList<String>books = new ArrayList<>();
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            String book_id = rs.getString("book_id");
            books.add(book_id);
        }

        return books;
    }

	static double Getfines(String book,String re_account) throws SQLException, ClassNotFoundException {
        Class.forName(JDBC_DRIVER);
        Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
        String sql = "select fine_amount from LendReturn where book_id = ? and re_account = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(sql);
        preparedStatement.setString(1,book);
        preparedStatement.setString(2,re_account);
        ResultSet rs = preparedStatement.executeQuery();
        double total = 0;
        while(rs.next()) {
            total += rs.getDouble("fine_amount");
        }

        return total;
    }
	
	public static BorrowedBook[] Searchforborrow(String re_account)  {
        Connection conn = null;

        BorrowedBook[] borrowedBooks = new BorrowedBook[1000];
        try
        {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        }
        catch (Exception e)
        {
            System.out.println("database error");
        }
        String SQL = "select book.book_id,book_name,deadline,fine_amount from lendreturn\n" +
                "join book on lendreturn.book_id=book.book_id\n" +
                " where return_date is null and re_account = ?";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setString(1,re_account);
            ResultSet resultSet = preparedStatement.executeQuery();
            int i = 0;
            while (resultSet.next())
            {

                System.out.println(resultSet.getString("book_id") + "\t" + resultSet.getString("book_name")
                + "\t"+ resultSet.getInt("deadline") + "\t" + resultSet.getDouble("fine_amount"));
                String book_id = resultSet.getString("book_id");
                String book_name = resultSet.getString("book_name");
                int deadline = resultSet.getInt("deadline");
                double fine_amount = resultSet.getDouble("fine_amount");
                BorrowedBook borrowedBook = new BorrowedBook();
                borrowedBook.book_id = book_id;
                borrowedBook.book_name = book_name;
                borrowedBook.deadline = deadline;
                borrowedBook.fine_amount = fine_amount;
                borrowedBooks[i] = borrowedBook;
                i++;
            }
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

        try
        {
            conn.close();
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
        return borrowedBooks;
	}

	public static BorrowedBook[] queryReturnedBook(String re_account) {
        BorrowedBook []borrowedBooks = new BorrowedBook[1000];
	    try
        {
            //database connect
            Class.forName(JDBC_DRIVER);
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
            Statement statement = conn.createStatement();
            String sql = "select book.book_id,book_name,deadline,fine_amount,fine_date from lendreturn\n" +
                    "join book on lendreturn.book_id=book.book_id\n" +
                    "where return_date is not null and re_account = ?";
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1,re_account);
            ResultSet resultSet = preparedStatement.executeQuery();
            int i = 0;
            while (resultSet.next())
            {

                System.out.print(resultSet.getString("book_id") +
                        "\t" + resultSet.getString("book_name") +
                        "\t" + resultSet.getInt("deadline") +
                        "\t" + resultSet.getDouble("fine_amount"));
                Date date = resultSet.getDate("fine_date");
                if(date == null)
                {
                    System.out.println("\t not complete");
                }
                else
                {
                    System.out.println("\t completed");
                }
                String book_id = resultSet.getString("book_id");
                String book_name = resultSet.getString("book_name");
                int deadline = resultSet.getInt("deadline");
                double fine_amount = resultSet.getDouble("fine_amount");
                BorrowedBook borrowedBook = new BorrowedBook();
                borrowedBook.book_id = book_id;
                borrowedBook.book_name = book_name;
                borrowedBook.deadline = deadline;
                borrowedBook.fine_amount = fine_amount;
                borrowedBook.date = date;
                borrowedBooks[i] = borrowedBook;
                i++;
            }
            resultSet.close();
            statement.close();
            conn.close();
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
        return borrowedBooks;

    }

	static Book getBookInfo(String book_id) throws SQLException {
        Connection conn = null;
        try
        {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        }
        catch (Exception e)
        {
            System.out.println("database error");
            return null;
        }
        Statement statement = conn.createStatement();
        String sql = "select * from book where book_id = " + book_id;
        ResultSet rs = statement.executeQuery(sql);
        Book book = new Book();
        rs.next();
        int book_type = rs.getInt("book_type");
        String auther = rs.getString("auther");
        int borw = rs.getInt("borw");
        int book_available = rs.getInt("book_avalible");
        double book_price = rs.getDouble("book_price");
        int borw_num = rs.getInt("borw_num");
        String book_name = rs.getString("book_name");
        int floor = rs.getInt("floor");
        int area = rs.getInt("area");
        int shelf = rs.getInt("shelf");

        book.id = book_id;
        book.author = auther;
        book.bookType = book_type;
        book.borw = borw;
        book.bookAva = book_available;
        book.price = book_price;
        book.borwNum = borw_num;
        book.name = book_name;
        book.floor = floor;
        book.area = area;
        book.bookShelf = shelf;

        rs.close();
        statement.close();
        conn.close();
        return book;

    }
	public  static String booktype(int i) {
		if(i == 1)
			return "novel";
		else if(i == 2)
			return "magazine";
		else if(i == 3)
			return "autobiography";
		else
			return null;
		}
}
