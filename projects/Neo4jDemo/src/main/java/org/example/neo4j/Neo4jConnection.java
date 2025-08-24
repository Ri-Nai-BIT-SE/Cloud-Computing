package org.example.neo4j;

import org.neo4j.driver.*;

public class Neo4jConnection {
    private static Driver driver;

    public static void connect(String uri, String user, String password) {
        driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));
    }

    public static Session getSession() {
        return driver.session();
    }

    public static void close() {
        if (driver != null) {
            driver.close();
        }
    }
}