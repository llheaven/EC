package src.main.java.cn.net.communion.main;

import java.io.IOException;
import java.util.List;

import gnu.getopt.Getopt;
import src.main.java.cn.net.communion.core.Generator;
import src.main.java.cn.net.communion.entity.JobInfo;
import src.main.java.cn.net.communion.xml.Root;



public class App {
	public static String IP = "localhost";
	public static String PASSWORD = "";
	public static String PORT = "3306";
	public static int THREADNUM = 200;
	public static String DB = "ec";
    public static void main(String[] args) {

    	if(args.length!=0)
		{
			Getopt testOpt  = new Getopt(args[0], args, "h:p:c:P:D");  
			int res;  
	        while( (res = testOpt.getopt()) != -1 ) {  
	          switch(res) {  
	            case 'h':  
	            	IP =  testOpt.getOptarg();  
	              break;  
	            case 'p':  
	            	PASSWORD = testOpt.getOptarg();  
	              break; 
	            case 'c':  
	            	THREADNUM = Integer.parseInt(testOpt.getOptarg());  
	              break; 
	            case 'P':  
	            	PORT = testOpt.getOptarg();  
	              break; 
	            case 'D':  
	            	DB = testOpt.getOptarg();  
	              break; 
	            default:  
	              System.out.println("input ip and password!");  
	          }  
	        }  
		}
        Root root = Root.getInstance().loadXml("jobs.xml");
        List<JobInfo> ll=root.getJobList();
        if (root != null) {

            try {
                new Generator().start(root.getJobList());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
    }

}
