package it.unibo.big.m3d.utils.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static com.jcraft.jsch.JSch.setConfig;

public class DbUtils {

    public static Connection getConnection(){
        Credentials cred = Utils.credentialsFromFile();

        try {
            Class.forName("net.bitnine.agensgraph.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }

        String dbname = cred.getDbName();

        String ip = cred.getIp();

        String connectionString = "jdbc:agensgraph://"+ip+":"+cred.getPort()+"/"+dbname;
        String username = cred.getUsername();
        String password = cred.getPassword();

        try {
            Connection conn = DriverManager.getConnection(connectionString, username, password);
            return conn;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

}
