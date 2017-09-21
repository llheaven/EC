import java.util.PrimitiveIterator.OfDouble;

import gnu.getopt.Getopt;

public class main {

	public static void main(String[] args) {
		String IP = "localhost";
		String PASSWORD = "";
		if(args.length!=0)
		{
			Getopt testOpt  = new Getopt(args[0], args, "h:p:");  
			int res;  
	        while( (res = testOpt.getopt()) != -1 ) {  
	          switch(res) {  
	            case 'h':  
	            	IP =  testOpt.getOptarg();  
	              break;  
	            case 'p':  
	            	PASSWORD = testOpt.getOptarg();  
	              break;  
	            default:  
	              System.out.println("input ip and password!");  
	          }  
	        }  
		}
		// TODO Auto-generated method stub
		int threadNum = 200;
		int TPPTHREAD = 10000;
		long runSqlTotalTime = 0;
		RunSQL[] thread_sql=new RunSQL[threadNum];
		long startTime =System.currentTimeMillis(); 
		System.out.println("Start......");

		for(int i=0;i<threadNum;i++)
    	{
    		RunSQL rs = new RunSQL(TPPTHREAD,i,IP,PASSWORD);
    		thread_sql[i] = rs;
    		rs.start();
    	}
		try
    	{
    		for(int i=0;i<threadNum;i++)
        	{
    			thread_sql[i].join();
        	}
    		
    	} catch
    	(InterruptedException e) {
    	e.printStackTrace();
    	}
		long endTime =System.currentTimeMillis();
		runSqlTotalTime = endTime - startTime;
		System.out.println("Total TP: "+(threadNum*TPPTHREAD));
		System.out.println("TPS: " + ((float)(threadNum*TPPTHREAD)/(runSqlTotalTime))*1000+"/s" );
	}
}
