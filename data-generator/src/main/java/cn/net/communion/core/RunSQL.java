package src.main.java.cn.net.communion.core;

import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import src.main.java.cn.net.communion.entity.JobInfo;
import src.main.java.cn.net.communion.entity.KeyValue;
import src.main.java.cn.net.communion.helper.FileHelper;

public class RunSQL extends Thread {
	private List<KeyValue> detail = new ArrayList<KeyValue>(); ;
	private Map<String, String> tempMap = new HashMap<String, String>();
	private Generator generator = new Generator();
	private JobInfo job ;
	private int jobnum;
	private FileWriter writer;
	private int start =0;
	private int end =0;
	List<String> sqlList = null;
	//
	private static final String URL="jdbc:mysql://localhost:3306/ec?";
    private static final String NAME="root";
    private static final String PASSWORD="";
    private Connection conn = null; 
    private Statement  stmt = null;
    
	public RunSQL(List<KeyValue> detail,JobInfo job,int jobnum,FileWriter writer,int start,int end,List<String> sqlList){
		for(int i=0;i<detail.size();i++)
		{
			this.detail.add(detail.get(i));
		}
		this.job = job;
		this.jobnum = jobnum;
		this.writer = writer;
		this.start = start;
		this.end = end;
		this.sqlList = sqlList;
        try {  
            Class.forName("com.mysql.jdbc.Driver");  
        } catch (ClassNotFoundException e) {  
            e.printStackTrace();  
        }  
        try {  
            conn = DriverManager.getConnection(URL, NAME, PASSWORD);  
            stmt = conn.createStatement(); 
        } catch (SQLException e) {  
            System.out.println("获取数据库连接失败！");  
            e.printStackTrace();  
        }  
	}

	 public void run() {
		 for (int i = start; i < end; i++) {
			 try {
					 stmt.executeUpdate(sqlList.get(i));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
             tempMap.clear();
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
	 }

}
