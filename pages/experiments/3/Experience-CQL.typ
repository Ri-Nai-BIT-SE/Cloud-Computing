#import "/book.typ": book-page
#show: book-page.with(title: "体验 CQL 语句")

#import "/util.typ": *

= 体验 CQL 语句

== 创建学生和课程节点

```Cypher
// 创建学生节点
CREATE (s1:Student {id: 1, name: "张三", age: 20})
CREATE (s2:Student {id: 2, name: "李四", age: 22})
CREATE (s3:Student {id: 3, name: "王五", age: 21})

// 创建课程节点
CREATE (c1:Course {id: 101, title: "数学", credits: 3})
CREATE (c2:Course {id: 102, title: "计算机科学导论", credits: 4})
CREATE (c3:Course {id: 103, title: "英语", credits: 3});
```

#figure(
  image("imgs/QQ_1747126687818.png"),
  caption: "创建节点",
)


== 建立选课关系（ENROLLS_IN）

```Cypher
// 张三选修数学
MATCH (s1:Student {name: "张三"}), (c1:Course {title: "数学"})
CREATE (s1)-[:ENROLLS_IN {grade: "A"}]->(c1)

// 张三选修计算机科学导论
MATCH (s1:Student {name: "张三"}), (c2:Course {title: "计算机科学导论"})
CREATE (s1)-[:ENROLLS_IN {grade: "B"}]->(c2)

// 李四选修计算机科学导论
MATCH (s2:Student {name: "李四"}), (c2:Course {title: "计算机科学导论"})
CREATE (s2)-[:ENROLLS_IN {grade: "C"}]->(c2)

// 王五选修英语
MATCH (s3:Student {name: "王五"}), (c3:Course {title: "英语"})
CREATE (s3)-[:ENROLLS_IN {grade: "A"}]->(c3);
```

#figure(
  image("imgs/QQ_1747127842104.png"),
  caption: "建立选课关系",
)

== 查询数据（MATCH + RETURN）

#double-table(
  columns: (1fr, 4fr),
  [查询所有学生],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student) RETURN s.name, s.age;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747127996627.png"),
        caption: "查询所有学生",
      )
    ],
  ),
  [查询所有课程],
  horizontal-table(
    [
      ```Cypher
      MATCH (c:Course) RETURN c.title, c.credits;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747128037329.png"),
        caption: "查询所有课程",
      )
    ],
  ),
  [查询所有选课记录],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student)-[r:ENROLLS_IN]->(c:Course) RETURN s.name AS student, c.title AS course, r.grade AS grade;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747128063180.png"),
        caption: "查询所有选课记录",
      )
    ],
  ),
  [点击左侧按钮],
  horizontal-table(
    [
      打开左侧数据库栏，点击任意一个 `Label` 都可以直接执行查询指令，并且有图示。
    ],
    [
      以 `Course` 为例
      #figure(
        image("imgs/QQ_1747128171438.png"),
        caption: "点击左侧按钮",
      )
    ],
  ),
)

== 使用 WHERE 进行过滤

#double-table(
  columns: (1fr, 4fr),
  [查询年龄大于20的学生],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student)
      WHERE s.age > 20
      RETURN s.name, s.age;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747128403874.png"),
        caption: "查询年龄大于20的学生",
      )
    ],
  ),
  [查询选修了“计算机科学导论”的学生],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student)-[:ENROLLS_IN]->(c:Course {title: "计算机科学导论"})
      RETURN s.name;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747128527819.png"),
        caption: "查询选修了“计算机科学导论”的学生",
      )
    ],
  ),
  [查询成绩为"A"的学生和课程],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student)-[r:ENROLLS_IN]->(c:Course)
      WHERE r.grade = "A"
      RETURN s.name, c.title;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747128549110.png"),
        caption: "查询成绩为\"A\"的学生和课程",
      )
    ],
  ),
)

== 更新属性值（SET）

#double-table(
  columns: (1fr, 4fr),
  [修改张三的年龄],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student {name: "张三"})
      SET s.age = 21
      RETURN s;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747128876186.png"),
        caption: "修改张三的年龄",
      )
      可以看到张三的年龄已经从20变成了21。
    ],
  ),
  [添加课程描述字段],
  horizontal-table(
    [
      ```Cypher
      MATCH (c:Course {title: "数学"})
      SET c.description = "基础数学理论"
      RETURN c;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747128947846.png"),
        caption: "添加课程描述字段",
      )
      可以看到数学课程的描述字段已经从空变成了“基础数学理论”。
    ],
  ),
)

== 删除操作（DELETE）

#double-table(
  columns: (1fr, 4fr),
  [删除某门课程的关系],
  horizontal-table(
    [
      ```Cypher
      MATCH (:Student {name: "张三"})-[rel:ENROLLS_IN]->(:Course {title: "数学"})
      DELETE rel;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747128980204.png"),
        caption: "删除某门课程的关系",
      )
      可以看到张三与数学课程的关系已经被删除。
    ],
  ),
  [删除学生的age属性],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student {name: "李四"})
      REMOVE s.age
      RETURN s;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747129021031.png"),
        caption: "删除学生的age属性",
      )
      可以看到李四的年龄属性已经被删除。
    ],
  ),
  [删除学生的Student标签],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student {name: "李四"})
      REMOVE s:Student
      RETURN s;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747129050254.png"),
        caption: "删除学生的Student标签",
      )
      可以看到李四的`Student`标签已经被删除。
    ],
  ),
)

== 排序与分页（ORDER BY + LIMIT/SKIP）

#double-table(
  columns: (1fr, 4fr),
  [按年龄升序排列学生],
  horizontal-table(
    [
      由于之前的数据量较少，我们再插入一些数据。
      ```Cypher
      CREATE (s1:Student {id: 4, name: "赵六", age: 23})
      CREATE (s2:Student {id: 5, name: "孙七", age: 22})
      CREATE (s3:Student {id: 6, name: "周八", age: 19})
      ```
    ],
    [
      ```Cypher
      MATCH (s:Student)
      RETURN s.name, s.age
      ORDER BY s.age ASC;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747129153824.png"),
        caption: "按年龄升序排列学生",
      )
    ],
  ),
  [分页查询],
  double-table(
    columns: (1fr, 4fr),
    [第一页，每页2个学生],
    horizontal-table(
      [
        ```Cypher
        MATCH (s:Student)
        RETURN s.name, s.age
        SKIP 0 LIMIT 2;
        ```
      ],
      [
        #figure(
          image("imgs/QQ_1747129171202.png"),
          caption: "分页查询：第一页，每页2个学生",
        )
      ],
    ),
    [第二页，每页2个学生],
    horizontal-table(
      [
        ```Cypher
        MATCH (s:Student)
        RETURN s.name, s.age
        SKIP 2 LIMIT 2;
        ```
      ],
      [
        #figure(
          image("imgs/QQ_1747129286923.png"),
          caption: "分页查询：第二页，每页2个学生",
        )
      ],
    ),
  ),
)

== 合并插入（MERGE）

#double-table(
  columns: (1fr, 4fr),
  [如果不存在就插入新学生],
  horizontal-table(
    [
      ```Cypher
      MERGE (s:Student {id: 7, name: "吴九", age: 20})
      RETURN s;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747129350392.png"),
        caption: "如果不存在就插入新学生",
      )
    ],
  ),
  [如果存在则不插入],
  horizontal-table(
    [
      ```Cypher
      MERGE (s:Student {id: 1, name: "张三"})
      RETURN s;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747129364406.png"),
        caption: "如果存在则不插入",
      )
      查看当前的节点
      #figure(
        image("imgs/QQ_1747129381991.png"),
        caption: "查看当前的节点",
      )

      没有多余的*张三*，并且插入了*吴九*。
    ],
  ),
)


== 集合筛选（IN）

#double-table(
  columns: (1fr, 4fr),
  [查询ID在指定列表中的学生],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student)
      WHERE s.id IN [1, 7]
      RETURN s.name, s.age;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747129460503.png"),
        caption: "查询ID在指定列表中的学生",
      )
    ],
  ),
)

== 结果合并（UNION）

#double-table(
  columns: (1fr, 4fr),
  [合并两个查询结果],
  horizontal-table(
    [
      ```Cypher
      MATCH (s:Student)
      RETURN s.name AS name, 'Student' AS type
      UNION
      MATCH (c:Course)
      RETURN c.title AS name, 'Course' AS type;
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747129502652.png"),
        caption: "合并两个查询结果",
      )  
    ],
  ),
)
