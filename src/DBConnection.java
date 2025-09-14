import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/gaming_platform?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "java_user1";       // or "root" if you are using root
    private static final String PASSWORD = "JavaPass123"; // replace with your MySQL password

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
