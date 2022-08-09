package it.unibo.big.m3d.utils.db;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Utils {

    /**
     * Get credentials from resources/credentials.txt.
     *
     * File must contain:
     * IP\n
     * PORT\n
     * USERNAME\n
     * PASSWORD\n
     * DB\n
     * GRAPHDB\n
     * @return array with credentials
     */
    public static Credentials credentialsFromFile() {
        try (
                BufferedReader b = new BufferedReader(new InputStreamReader(new Utils().getClass().getClassLoader().getResourceAsStream("credentials.txt")))
        ) {
            String readLine = "";
            final String[] credentials = new String[7];
            int i = 0;
            while ((readLine = b.readLine()) != null) {
                credentials[i++] = readLine;
            }
            b.close();

            Credentials cred = new Credentials(credentials);
            return cred;
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Get credentials from resources/credentialsSsh.txt.
     *
     * File must contain:
     * IP\n
     * PORT\n
     * USERNAME\n
     * PASSWORD\n
     * @return array with credentials
     */
    public static Credentials credentialsSshFromFile() {
        try (
                BufferedReader b = new BufferedReader(new InputStreamReader(new Utils().getClass().getClassLoader().getResourceAsStream("credentialsSsh.txt")))
        ) {
            String readLine = "";
            final String[] credentials = new String[7];
            int i = 0;
            while ((readLine = b.readLine()) != null) {
                credentials[i++] = readLine;
            }
            b.close();

            Credentials cred = new Credentials(credentials);
            return cred;
        } catch (Exception e) {
            return null;
        }
    }
}
