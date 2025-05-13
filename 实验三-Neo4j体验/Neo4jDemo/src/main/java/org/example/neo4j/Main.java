package org.example.neo4j;

import org.neo4j.driver.Session;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class Main {
    public static void main(String[] args) {
        Properties prop = new Properties();

        try (FileInputStream input = new FileInputStream("config.properties")) {
            prop.load(input);

            String uri = prop.getProperty("uri");
            String username = prop.getProperty("username");
            String password = prop.getProperty("password");

            // 调用你的 Neo4j 连接方法
            Neo4jConnection.connect(uri, username, password);

        } catch (IOException e) {
            System.err.println("读取配置文件出错: " + e.getMessage());
            e.printStackTrace();
        }
        Session session = Neo4jConnection.getSession();
        MovieKGService service = new MovieKGService(session);

        try {
            // 清空数据库
            service.clearDatabase();

            // 创建人物
            service.createPerson("Tom Hanks", 1956);
            service.createPerson("Leonardo DiCaprio", 1974);
            service.createPerson("Christopher Nolan", 1970);

            // 创建电影
            service.createMovie("Forrest Gump", 1994);
            service.createMovie("Inception", 2010);
            service.createMovie("Interstellar", 2014);

            // 创建关系
            service.createActedIn("Tom Hanks", "Forrest Gump");
            service.createActedIn("Leonardo DiCaprio", "Inception");
            service.createDirected("Christopher Nolan", "Inception");
            service.createDirected("Christopher Nolan", "Interstellar");

            // 显示结果
            System.out.println("\n当前知识图谱内容：");
            service.showAllGraph();

        } finally {
            Neo4jConnection.close();
        }
    }
}
