package org.example.neo4j;

import org.neo4j.driver.Session;
import org.neo4j.driver.Value;
import org.neo4j.driver.Values;

public class MovieKGService {

    private final Session session;

    public MovieKGService(Session session) {
        this.session = session;
    }

    // 创建人物节点
    public void createPerson(String name, int born) {
        session.executeWrite(tx -> {
            var result = tx.run("CREATE (:Person {name: $name, born: $born})",
                    Values.parameters("name", name, "born", born));
            result.consume();
            return null;
        });
    }

    // 创建电影节点
    public void createMovie(String title, int released) {
        session.executeWrite(tx -> {
            var result = tx.run("CREATE (:Movie {title: $title, released: $released})",
                    Values.parameters("title", title, "released", released));
            result.consume();
            return null;
        });
    }

    // 创建导演关系
    public void createDirected(String personName, String movieTitle) {
        session.executeWrite(tx -> {
            var result = tx.run(
                    "MATCH (p:Person {name: $person}) MATCH (m:Movie {title: $movie}) CREATE (p)-[:DIRECTED]->(m)",
                    Values.parameters("person", personName, "movie", movieTitle));
            result.consume();
            return null;
        });
    }

    // 创建出演关系
    public void createActedIn(String personName, String movieTitle) {
        session.executeWrite(tx -> {
            var result = tx.run(
                    "MATCH (p:Person {name: $person}) MATCH (m:Movie {title: $movie}) CREATE (p)-[:ACTED_IN]->(m)",
                    Values.parameters("person", personName, "movie", movieTitle));
            result.consume();
            return null;
        });
    }

    // 查询并打印所有数据
    public void showAllGraph() {
        session.executeRead(tx -> {
            var result = tx.run("MATCH (n) RETURN n LIMIT 20");

            while (result.hasNext()) {
                var record = result.next();
                var node = record.get(0).asNode();

                System.out.println(node.labels() + " - " + node.asMap());
            }

            return null;
        });
    }

    // 清空数据库
    public void clearDatabase() {
        session.executeWrite(tx -> {
            var result = tx.run("MATCH (n) DETACH DELETE n");
            // 消费结果
            result.consume();
            return null;
        });
    }
}
