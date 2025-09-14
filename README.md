# 🎮 Gaming-Platform-JDBC

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/Monika-Bhardwaj/Gaming-Platform-JDBC)](https://github.com/Monika-Bhardwaj/Gaming-Platform-JDBC/issues)
[![GitHub forks](https://img.shields.io/github/forks/Monika-Bhardwaj/Gaming-Platform-JDBC)](https://github.com/Monika-Bhardwaj/Gaming-Platform-JDBC/network)
[![GitHub stars](https://img.shields.io/github/stars/Monika-Bhardwaj/Gaming-Platform-JDBC)](https://github.com/Monika-Bhardwaj/Gaming-Platform-JDBC/stargazers)
[![GitHub last commit](https://img.shields.io/github/last-commit/Monika-Bhardwaj/Gaming-Platform-JDBC)](https://github.com/Monika-Bhardwaj/Gaming-Platform-JDBC/commits/master)

---

## 📖 Overview

Gaming-Platform-JDBC is a Java-based project that demonstrates a simple gaming platform system with database connectivity using JDBC (Java Database Connectivity).  
It offers basic CRUD (Create, Read, Update, Delete) operations on users and games, showcasing user registration, authentication, and game management functionalities backed by a relational database.

This project serves as a foundational template for learning JDBC integration with Java applications and designing modular, database-driven systems.

---

## 🚀 Features

- User Registration: Create new users with unique credentials.
- User Authentication: Secure login functionality.
- Game Management: Add, update, delete, and list games.
- Database Integration: Uses JDBC to connect and interact with a MySQL (or compatible) database.
- Modular Design: Separation of concerns with DAO (Data Access Object) pattern for database operations.
- Exception Handling: Basic error handling for database connectivity and operations.
- Configuration Management: Externalized database configuration for ease of maintenance.

---

## 🛠️ Getting Started

### Prerequisites

- **Java Development Kit (JDK) 8 or higher**  
  Ensure you have Java installed. You can check by running `java -version` in your terminal.
- **Maven**  
  Used for project build and dependency management.
- **MySQL or compatible relational database**  
  The project uses MySQL by default but can be configured for other RDBMS with appropriate JDBC drivers.
- **JDBC Driver**  
  MySQL Connector/J or corresponding JDBC driver for your database.

  ---

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Monika-Bhardwaj/Gaming-Platform-JDBC.git
   cd Gaming-Platform-JDBC
   ```
2. **Configure the database:**
   Create a database schema (e.g., gaming_platform).
   Run the SQL script in /database/schema.sql (if provided) to create necessary tables (users, games).
   Update the config.properties file with your database credentials:
   db.url=jdbc:mysql://localhost:3306/gaming_platform
   db.username=your_db_username
   db.password=your_db_password

3. **Build the project:**
   mvn clean install

4. **Run the application:**
   Replace com.yourpackage.MainClass with the actual main class path in your project.
   mvn exec:java -Dexec.mainClass="com.yourpackage.MainClass"

  ---
  
###🗂️ Project Structure
Gaming-Platform-JDBC/
├── .idea/                      # IDE configuration files
├── artifacts/                  # Build artifacts (optional)
├── resources/                  # Configuration files
│   └── config.properties       # Database config (add manually if missing)
├── schema.sql                 # SQL script to create database schema
├── src/                       # Source folder (if used)
├── META-INF/                  # Manifest files
├── MANIFEST.MF                # JAR manifest file
├── DBConnection.java          # Handles JDBC connection
├── GamingPlatformDAO.java     # Data Access Object for DB operations
├── Main.java                  # Main class, entry point of the application
├── README.md                  # This README file
├── Gaming platform.iml        # IDE module file
├── .gitignore                 # Git ignore file
└── misc.xml, modules.xml, vcs.xml  # IDE-related files

---

💡 Usage Example

Sample flow to interact with the system programmatically or via the Main class:

DBConnection dbConn = new DBConnection();
GamingPlatformDAO dao = new GamingPlatformDAO(dbConn.getConnection());

// Register a user
dao.registerUser("player1", "password123", "player1@example.com");

// Authenticate user
boolean authenticated = dao.authenticateUser("player1", "password123");

// Add a new game
dao.addGame("Pac-Man", "Arcade");

// List all games
List<Game> games = dao.getAllGames();
games.forEach(game -> System.out.println(game.getName()));

---

📝 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

📞 Contact

For questions or contributions:

Monika Bhardwaj
GitHub: https://github.com/Monika-Bhardwaj

Email: doctormonika5@gmail.com

---

⚠️ Troubleshooting

Ensure your database is running and accessible with the credentials in config.properties.

Make sure the JDBC driver is on your classpath when running the app.

Check that the schema.sql script has been executed successfully and tables are created.

---

Thanks for using Gaming-Platform-JDBC! Happy gaming and coding! 🎮


