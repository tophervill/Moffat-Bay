package databaseBean;

public class Database implements java.io.Serializable{
	
	java.sql.Connection connection;
	java.sql.Statement statement;
	
	private static final long serialVersionUID = 1223334444L;
	
	// ======= CONSTRUCTOR =========
	
	public Database() {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/moffat_bay?";
			connection = java.sql.DriverManager.getConnection(url + "user=moffat_app&password=MoffatBay2026!");
			statement = connection.createStatement();
		}
		catch(ClassNotFoundException cnfe) {
			System.out.print("There was an SQL Exception: " + cnfe);
			cnfe.printStackTrace();
		}
		catch(java.sql.SQLException sqle) {
			System.out.print("There was an SQL Exception: " + sqle);
			sqle.printStackTrace();
		}
		
	}
	
	// ==== CHECK AVAILABILITY =====
	
	public boolean checkAvailability(String arrivalDate, String departureDate, double vesselLength) {
		
		
		
		java.sql.ResultSet resultSet = null;
		java.sql.PreparedStatement preparedStatement = null;
		
		String sqlQuery =
				"SELECT s.slip_id " +
		        "FROM Slip s " +
		        "JOIN SlipSize ss " +
		        "ON s.slip_size_id = ss.slip_size_id " +
		        "WHERE s.is_active = TRUE " +
		        "AND ss.size_ft >= ? " +
		        "AND NOT EXISTS (" +
		            "SELECT 1 " +
		            "FROM Reservation r " +
		            "WHERE r.slip_id = s.slip_id " +
		            "AND r.status = 'confirmed' " +
		            "AND r.check_in_date < ? " +
		            "AND r.check_out_date > ? " +
		        ") " +
		        "LIMIT 1";
		
		try {
			
			preparedStatement = connection.prepareStatement(sqlQuery);
			
			preparedStatement.setDouble(1, vesselLength);
			preparedStatement.setString(2, departureDate);
			preparedStatement.setString(3, arrivalDate);
			
			resultSet = preparedStatement.executeQuery();
			
			if (vesselLength <= 0 || vesselLength > 50) {
			    return false;
			}
			
			if (resultSet.next()) {

	            System.out.println("AVAILABLE SLIP FOUND");
	            return true;
	        }

	        System.out.println("NO AVAILABLE SLIPS FOUND");
	        return false;
		}
		catch(java.sql.SQLException sqle) {
			
			System.out.println("SQL ERROR: Checking availability " + sqle.getMessage());
			
			return false;
		
		}
		
		
	}
	
	
	
	// ======= CLOSE CONNECTION =========
	
 	public void closeConnection(){
    	
    	try {
    		
    		statement.close();
    		connection.close();
    	}
    	catch(java.sql.SQLException sqle){
    		
    		System.out.print("SQL Exception" + sqle);    		
    	}    	
    }
	
}