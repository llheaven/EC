
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Transaction2   implements Transaction{
	 private static final String sql1 = "select * from r_ec_userinfo where nUserID=?;";
     private PreparedStatement pstmt1 = null;

     private Connection conn = null; 
     private Statement  stmt = null;
	 public Transaction2(Connection conn) throws SQLException
	 {
		 this.conn = conn;
		 pstmt1 =  conn.prepareStatement(sql1);

		 stmt = conn.createStatement(); 
	 }
	 public void execute() throws SQLException
	 {
		 int nUserID = Randomdata.getRandomInteger(1, 1000000);
		 pstmt1.setInt(1, nUserID);

		 
		 stmt.executeQuery("start transaction");
		 pstmt1.executeQuery();

		 stmt.executeQuery("commit");
	 }
	 public void printSQL()
	 {
		 System.out.println("Transaction SQL");
		 System.out.println(sql1);
		 System.out.println("----------------------------------------------------------------------");
	 }
}
