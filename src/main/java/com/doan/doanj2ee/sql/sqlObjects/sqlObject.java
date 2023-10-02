package com.doan.doanj2ee.sql.sqlObjects;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class sqlObject {
    static final String dbURL = "jdbc:mysql://localhost:3306/mxh_01";
    static final String dbUser = "mxhAdmin";
    static final String dbPassword = "Abc12345";
    sqlObject get(String userID){
        sqlObject obj = null;
        try{
            Connection connection = DriverManager.getConnection(dbURL,dbUser,dbPassword);

            Statement statement = connection.createStatement();
            ResultSet rs =statement.executeQuery("SELECT * FROM account");
            


            connection.close();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        return obj;
    }
}