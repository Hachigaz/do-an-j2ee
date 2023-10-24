package com.doan.model.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class sqlConnect {
    public static final String dbURL = "jdbc:mysql://localhost:3306/mxh_01";
    public static final String dbUser = "mxhAdmin";
    public static final String dbPassword = "Abc12345";

    public static Connection connectToDB() throws SQLException, ClassNotFoundException{
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            return DriverManager.getConnection(sqlConnect.dbURL,sqlConnect.dbUser,sqlConnect.dbPassword);
    }
}