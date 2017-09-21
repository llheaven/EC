

import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;



public class RunSQL extends Thread {

	private String IP = "localhost";
	//
	private   String URL= "";
    private   String NAME="root";
    private   String PASSWORD="";
    private static final String sql1 = "select * from r_ec_userinfo where nUserID=?;";
    private static final String sql2 = "select * from r_ec_shoppingcart where nUserID =?;";
    private static final String sql3 = "select * from r_ec_cartsku ct join r_ec_sku sku on ct.nProductID = sku.nSKUID where ct.nUserID=?";
    private static final String sql4 = "update r_ec_cartsku set nQuantity=123 where nUserID=?;";
    private static final String sql5 = "delete from r_ec_cartsku where nProductID=?;";
    private static final String sql6="replace into r_ec_cartsku(nUserID,nProductID,nQuantity) values(?,?,?);";
    private Connection conn = null; 
    private Statement  stmt = null;
    private ResultSet rs = null;
    private int thread_no = 0;
    private PreparedStatement pstmt1 = null;
    private PreparedStatement pstmt2 = null;
    private PreparedStatement pstmt3 = null;
    private PreparedStatement pstmt4 = null;
    private PreparedStatement pstmt5 = null;
    private PreparedStatement pstmt6 = null;
    private int TPS_NUM = 100000;
    
    public int getRandomInteger(int start,int end)
    {
    	Random random = new Random();
		return random.nextInt(end)%(end-start+1) + start;
    }
	public RunSQL(int TPS_NUM,int thread_no,String IP,String PASSWORD){
		this.TPS_NUM = TPS_NUM;
		this.IP = IP;
		this.PASSWORD = PASSWORD;
		URL = "jdbc:mysql://"+IP+":3306/ec?";
        try {  
            Class.forName("com.mysql.jdbc.Driver");  
        } catch (ClassNotFoundException e) {  
            e.printStackTrace();  
        }  
        try {  
            conn = DriverManager.getConnection(URL, NAME, PASSWORD);  
            pstmt1 =  conn.prepareStatement(sql1);
            pstmt2 = conn.prepareStatement(sql2);
            pstmt3 = conn.prepareStatement(sql3);
            pstmt4 = conn.prepareStatement(sql4);
            pstmt5 = conn.prepareStatement(sql5);
            pstmt6 = conn.prepareStatement(sql6);
            stmt = conn.createStatement(); 
            conn.setAutoCommit(false); 
        } catch (SQLException e) {  
            System.out.println("获取数据库连接失败！");  
            e.printStackTrace();  
        }  
        
        
	}

	 public void run() {
		 for (int i = 0; i < TPS_NUM; i++) {
			 int nUserID = getRandomInteger(1, 400000);
			 int nProductID = getRandomInteger(1111, 9999);
			 int nQuantity = getRandomInteger(1, 9999);
			 try {
				 stmt.executeQuery("start transaction");
				 pstmt1.setInt(1, nUserID);
				 pstmt2.setInt(1, nUserID);
				 pstmt3.setInt(1, nUserID);
				 pstmt4.setInt(1, nUserID);
				 pstmt5.setInt(1,nProductID);
				 pstmt6.setInt(1,nUserID);
				 pstmt6.setInt(2,nProductID);
				 pstmt6.setInt(3,nQuantity);
				 //
				 rs = pstmt1.executeQuery();
				 //rs = pstmt2.executeQuery();
				 //rs = pstmt3.executeQuery();
				 //pstmt4.executeUpdate();
				// pstmt5.executeUpdate();
				//pstmt6.executeUpdate();
				 stmt.executeQuery("commit");
			} catch (SQLException e) {
				// TODO Auto-generated catch block 
				//e.printStackTrace();
			}
         }
        if(conn!=null)  
        {  
            try {  
                conn.close();  
            } catch (SQLException e) {  
                e.printStackTrace();  
                conn=null;  
            }  
        }  
        //System.out.println("thread "+thread_no+" job done!");
	 }

}
