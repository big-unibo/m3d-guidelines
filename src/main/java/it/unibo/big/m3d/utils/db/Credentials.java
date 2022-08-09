package it.unibo.big.m3d.utils.db;

public class Credentials {

    private String ip;
    private String port;
    private String username;
    private String password;
    private String agensInstance;
    private String graphName;
    private String dbName;

    public Credentials (String[] credentials){
        this.ip = credentials[0];
        this.port = credentials[1];
        this.username = credentials[2];
        this.password = credentials[3];
        this.agensInstance = credentials[4];
        this.graphName = credentials[5];
        this.dbName = credentials[6];
    }

    public String getIp() {
        return ip;
    }

    public String getPort() {
        return port;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getAgensInstance() {
        return agensInstance;
    }

    public String getGraphName() {
        return graphName;
    }

    public String getDbName() {
        return dbName;
    }
}
