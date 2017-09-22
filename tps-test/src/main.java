import java.util.PrimitiveIterator.OfDouble;

import gnu.getopt.Getopt;

public class main {

	public static void main(String[] args) {
		String IP = "localhost";
		String PASSWORD = "";
		int THREADNUM = 200;
		if(args.length!=0)
		{
			Getopt testOpt  = new Getopt(args[0], args, "h:p:c:");  
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
	            default:  
	              System.out.println("input ip and password!");  
	          }  
	        }  
		}
		// TODO Auto-generated method stub
		int threadNum = THREADNUM;
		int TPPTHREAD = 10000;
		System.out.println("==========================================================");
		System.out.println("Work thread num:"+threadNum+"--default 200");
		System.out.println("Select per thread is:"+TPPTHREAD);
		System.out.println("Total Select ops:"+TPPTHREAD*threadNum);
		System.out.println("Running......");
		System.out.println("==========================================================");
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
		System.out.println("TPS: " + ((float)(threadNum*TPPTHREAD)/(runSqlTotalTime))*1000+"/s" );
	}
}
