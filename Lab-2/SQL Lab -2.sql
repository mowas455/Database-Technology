/* 
Lab 2 report: Salvador Marti Roman (salma742) and Mowniesh Asokan (mowas455)
*/

/* 
Source scripts 
*/

-- SOURCE company_schema.sql;
-- SOURCE company_data.sql;

#DROP TABLE IF EXISTS jbnewitem CASCADE;
#DROP VIEW IF EXISTS  itemview CASCADE; 
#DROP VIEW IF EXISTS  totalcost_debit CASCADE;
#DROP VIEW IF EXISTS  w_tcdebit CASCADE;

use lab_2;

/* 
1. List all employees, i.e. all tuples in the jbemployee relation 
*/

SELECT * 
FROM jbemployee;
/*
+------+--------------------+--------+---------+-----------+-----------+
| id   | name               | salary | manager | birthyear | startyear |
+------+--------------------+--------+---------+-----------+-----------+
|   10 | Ross, Stanley      |  15908 |     199 |      1927 |      1945 |
|   11 | Ross, Stuart       |  12067 |    NULL |      1931 |      1932 |
|   13 | Edwards, Peter     |   9000 |     199 |      1928 |      1958 |
|   26 | Thompson, Bob      |  13000 |     199 |      1930 |      1970 |
|   32 | Smythe, Carol      |   9050 |     199 |      1929 |      1967 |
|   33 | Hayes, Evelyn      |  10100 |     199 |      1931 |      1963 |
|   35 | Evans, Michael     |   5000 |      32 |      1952 |      1974 |
|   37 | Raveen, Lemont     |  11985 |      26 |      1950 |      1974 |
|   55 | James, Mary        |  12000 |     199 |      1920 |      1969 |
|   98 | Williams, Judy     |   9000 |     199 |      1935 |      1969 |
|  129 | Thomas, Tom        |  10000 |     199 |      1941 |      1962 |
|  157 | Jones, Tim         |  12000 |     199 |      1940 |      1960 |
|  199 | Bullock, J.D.      |  27000 |    NULL |      1920 |      1920 |
|  215 | Collins, Joanne    |   7000 |      10 |      1950 |      1971 |
|  430 | Brunet, Paul C.    |  17674 |     129 |      1938 |      1959 |
|  843 | Schmidt, Herman    |  11204 |      26 |      1936 |      1956 |
|  994 | Iwano, Masahiro    |  15641 |     129 |      1944 |      1970 |
| 1110 | Smith, Paul        |   6000 |      33 |      1952 |      1973 |
| 1330 | Onstad, Richard    |   8779 |      13 |      1952 |      1971 |
| 1523 | Zugnoni, Arthur A. |  19868 |     129 |      1928 |      1949 |
| 1639 | Choy, Wanda        |  11160 |      55 |      1947 |      1970 |
| 2398 | Wallace, Maggie J. |   7880 |      26 |      1940 |      1959 |
| 4901 | Bailey, Chas M.    |   8377 |      32 |      1956 |      1975 |
| 5119 | Bono, Sonny        |  13621 |      55 |      1939 |      1963 |
| 5219 | Schwarz, Jason B.  |  13374 |      33 |      1944 |      1959 |
+------+--------------------+--------+---------+-----------+-----------+
*/

/*
2.List the name of all departments in alphabetical order. Note: by “name”
we mean the name attribute in the jbdept relation.
*/

SELECT name FROM jbdept
ORDER BY name;

/*
+------------------+
| name             |
+------------------+
| Bargain          |
| Book             |
| Candy            |
| Children's       |
| Children's       |
| Furniture        |
| Giftwrap         |
| Jewelry          |
| Junior Miss      |
| Junior's         |
| Linens           |
| Major Appliances |
| Men's            |
| Sportswear       |
| Stationary       |
| Toys             |
| Women's          |
| Women's          |
| Women's          |
+------------------+
*/

/*
3. What parts are not in store? Note that such parts have the value 0 (zero)
for the qoh attribute (qoh = quantity on hand)
*/

SELECT id, name, color, weight 
FROM jbparts WHERE qoh = 0;

/*
+----+-------------------+-------+--------+
| id | name              | color | weight |
+----+-------------------+-------+--------+
| 11 | card reader       | gray  |    327 |
| 12 | card punch        | gray  |    427 |
| 13 | paper tape reader | black |    107 |
| 14 | paper tape punch  | black |    147 |
+----+-------------------+-------+--------+
*/

/*
4. List all employees who have a salary between 9000 (included) and
10000 (included)?
*/

SELECT name FROM jbemployee 
where salary BETWEEN 9000 AND 10000;

/*
+----------------+
| name           |
+----------------+
| Edwards, Peter |
| Smythe, Carol  |
| Williams, Judy |
| Thomas, Tom    |
+----------------+
*/

/*
5.List all employees together with the age they had when they started
working? Hint: use the startyear attribute and calculate the age in the
SELECT clause.
*/

SELECT id, name , startyear - birthyear AS start_age
FROM jbemployee;
/*
+------+--------------------+-----------+
| id   | name               | start_age |
+------+--------------------+-----------+
|   10 | Ross, Stanley      |        18 |
|   11 | Ross, Stuart       |         1 |
|   13 | Edwards, Peter     |        30 |
|   26 | Thompson, Bob      |        40 |
|   32 | Smythe, Carol      |        38 |
|   33 | Hayes, Evelyn      |        32 |
|   35 | Evans, Michael     |        22 |
|   37 | Raveen, Lemont     |        24 |
|   55 | James, Mary        |        49 |
|   98 | Williams, Judy     |        34 |
|  129 | Thomas, Tom        |        21 |
|  157 | Jones, Tim         |        20 |
|  199 | Bullock, J.D.      |         0 |
|  215 | Collins, Joanne    |        21 |
|  430 | Brunet, Paul C.    |        21 |
|  843 | Schmidt, Herman    |        20 |
|  994 | Iwano, Masahiro    |        26 |
| 1110 | Smith, Paul        |        21 |
| 1330 | Onstad, Richard    |        19 |
| 1523 | Zugnoni, Arthur A. |        21 |
| 1639 | Choy, Wanda        |        23 |
| 2398 | Wallace, Maggie J. |        19 |
| 4901 | Bailey, Chas M.    |        19 |
| 5119 | Bono, Sonny        |        24 |
| 5219 | Schwarz, Jason B.  |        15 |
+------+--------------------+-----------+
*/

/*
6.List all employees who have a last name ending with “son”.
*/

SELECT name FROM jbemployee 
WHERE name LIKE "%son,%";

/*
+---------------+
| name          |
+---------------+
| Thompson, Bob |
+---------------+
*/

/*
7.Which items (note items, not parts) have been delivered by a supplier
called Fisher-Price? Formulate this query by using a subquery in the
WHERE clause
*/

SELECT name FROM jbitem 
WHERE supplier = (SELECT id FROM jbsupplier WHERE name = 'Fisher-Price');
/*
+-----------------+
| name            |
+-----------------+
| Maze            |
| The 'Feel' Book |
| Squeeze Ball    |
+-----------------+
*/

/*
8. Formulate the same query as above, but without a subquery. *
*/

SELECT jbitem.name
FROM jbitem INNER JOIN
    jbsupplier ON jbitem.supplier = jbsupplier.id
WHERE
    jbsupplier.name = 'Fisher-Price';

/*
+-----------------+
| name            |
+-----------------+
| Maze            |
| The 'Feel' Book |
| Squeeze Ball    |
+-----------------+
*/

/*
9.List all cities that have suppliers located in them. Formulate this query
using a subquery in the WHERE clause.
*/

 SELECT * FROM jbcity
 WHERE id IN (SELECT DISTINCT city FROM jbsupplier);
 /*
 +-----+----------------+-------+
| id  | name           | state |
+-----+----------------+-------+
|  10 | Amherst        | Mass  |
|  21 | Boston         | Mass  |
| 100 | New York       | NY    |
| 106 | White Plains   | Neb   |
| 118 | Hickville      | Okla  |
| 303 | Atlanta        | Ga    |
| 537 | Madison        | Wisc  |
| 609 | Paxton         | Ill   |
| 752 | Dallas         | Tex   |
| 802 | Denver         | Colo  |
| 841 | Salt Lake City | Utah  |
| 921 | San Diego      | Calif |
| 941 | San Francisco  | Calif |
| 981 | Seattle        | Wash  |
+-----+----------------+-------+
 */
 
 /*
 10.What is the name and the color of the parts that are heavier than a card
reader? Formulate this query using a subquery in the WHERE clause.
(The query must not contain the weight of the card reader as a constant;
instead, the weight has to be retrieved within the query.)
*/

SELECT name,color FROM jbparts where 
weight >(SELECT weight FROM jbparts where name = 'card reader');
 /*
 +--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
 */
 
 /*
 11.Formulate the same query as above, but without a subquery. Again, the
query must not contain the weight of the card reader as a constant. 
 */
 
SELECT p.name,p.color,p.weight
FROM jbparts AS p ,jbparts AS pc
 WHERE pc.name = 'card reader'
 AND p.weight > pc.weight; 
 /*
 +--------------+--------+--------+
| name         | color  | weight |
+--------------+--------+--------+
| disk drive   | black  |    685 |
| tape drive   | black  |    450 |
| line printer | yellow |    578 |
| card punch   | gray   |    427 |
+--------------+--------+--------+
*/

 /*
 12.What is the average weight of all black parts?
 */
 
 SELECT avg(weight)
 FROM jbparts where color = "black";
/*
+-------------+
| avg(weight) |
+-------------+
|    347.2500 |
+-------------+
*/	

 /*
 13.For every supplier in Massachusetts (“Mass”), retrieve the name and the
total weight of all parts that the supplier has delivered? Do not forget to
take the quantity of delivered parts into account. Note that one row
should be returned for each supplier. 
 */
 
 SELECT jbsupplier.name,
 sum(jbsupply.quan * jbparts.weight) AS total_weight,
 jbsupplier.city
 FROM jbsupply
 INNER JOIN jbparts
 ON jbsupply.part = jbparts.id
 INNER JOIN jbsupplier 
 ON jbsupplier.id = jbsupply.supplier
 GROUP BY jbsupply.supplier
 HAVING jbsupplier.city in (SELECT id 
                         FROM jbcity
                           where state = "Mass");
/*
+--------------+--------------+------+
| name         | total_weight | city |
+--------------+--------------+------+
| Fisher-Price |      1135000 |   21 |
| DEC          |         3120 |   10 |
+--------------+--------------+------+
*/

/*  
14.Create a new relation with the same attributes as the jbitems relation by
using the CREATE TABLE command where you define every attribute
explicitly (i.e., not as a copy of another table). Then, populate this new
relation with all items that cost less than the average price for all items.
Remember to define the primary key and foreign keys in your table!
*/

CREATE TABLE jbnewitem (
    id INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    dept INT NOT NULL,
    price INT NOT NULL,
    qoh INT NOT NULL,
    supplier INT NOT NULL,
    CONSTRAINT item_avg PRIMARY KEY (id),
    CONSTRAINT item_dept FOREIGN KEY (dept)
        REFERENCES jbdept (id),
    CONSTRAINT item_supplier FOREIGN KEY (supplier)
        REFERENCES jbsupplier (id)
);

 INSERT INTO jbnewitem (SELECT * FROM jbitem 
 where price < (SELECT avg(price) 
 FROM jbitem));

select * from jbnewitem;
/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
*/

/*
15.Create a view that contains the items that cost less than the average
price for items
*/
CREATE VIEW itemview AS 
SELECT * FROM jbitem 
 where price < (SELECT avg(price) 
 FROM jbitem);
 
SELECT * FROM itemview;
/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
*/

/* 
16.What is the difference between a table and a view? One is static and the
other is dynamic. Which is which and what do we mean by static
respectively dynamic?
*/

# Static tables are the master tables that are populated with some canned data at the time of creation of the database
# in a typical system setup. Rather they have a pre defined set of data populated in them that hardly changes.
# it occupies space on the system
#Views are treated as a virtual/logical table used to view or manipulate parts of the table. It is a database
#object that contains rows and columns the same as real tables. It depends on the table,
#therefore we cannot create a view without using table

/*
17.Create a view that calculates the total cost of each debit, by considering
price and quantity of each bought item. (To be used for charging
customer accounts). The view should contain the sale identifier (debit)
and the total cost. In the query that defines the view, capture the join
condition in the WHERE clause (i.e., do not capture the join in the
FROM clause by using keywords inner join, right join or left join).
*/

CREATE VIEW totalcost_debit AS
SELECT jbsale.debit,sum(jbsale.quantity*jbitem.price) AS totalcost
FROM jbsale,jbitem
where jbitem.id = jbsale.item
GROUP BY debit;

SELECT * FROM totalcost_debit;

/*
+--------+-----------+
| debit  | totalcost |
+--------+-----------+
| 100581 |      2050 |
| 100586 |     13446 |
| 100592 |       650 |
| 100593 |       430 |
| 100594 |      3295 |
+--------+-----------+
*/

/*
18.Do the same as in the previous point, but now capture the join conditions
in the FROM clause by using only left, right or inner joins. Hence, the
WHERE clause must not contain any join condition in this case. Motivate
why you use type of join you do (left, right or inner), and why this is the
correct one (in contrast to the other types of joins).
*/

CREATE VIEW W_tcdebit AS
SELECT jbsale.debit,sum(jbitem.price * jbsale.quantity) AS tc 
FROM jbsale INNER JOIN jbitem ON jbitem.id = jbsale.item
GROUP BY jbsale.debit;

SELECT * FROM w_tcdebit ;

/*
we use inner join to join the item id and sale of item and debit is a foreign key attribute from the jbdebit.
This is justified because the item attribute in jbdebit table is a foreign key 
that references the id attribute in jbitem table. Hence, there can be no debited item that is 
not present in the item master table.
*/

/*
+--------+-------+
| debit  | tc    |
+--------+-------+
| 100581 |  2050 |
| 100586 | 13446 |
| 100592 |   650 |
| 100593 |   430 |
| 100594 |  3295 |
+--------+-------+
*/

/*
19.A.Remove all suppliers in Los Angeles from the jbsupplier table. This
will not work right away. Instead, you will receive an error with error
code 23000 which you will have to solve by deleting some other related tuples.
 However, do not delete more tuples from other tables
than necessary, and do not change the structure of the tables (i.e.,
do not remove foreign keys). Also, you are only allowed to use “Los
Angeles” as a constant in your queries, not “199” or “900”.
*/



## Delete tuple from jbsale
DELETE FROM jbsale 
WHERE
    item IN (SELECT 
        jbitem.id
    FROM
        jbitem
            INNER JOIN
        jbsupplier ON jbsupplier.id = jbitem.supplier
            INNER JOIN
        jbcity ON jbcity.id = jbsupplier.city
    
    WHERE
        jbcity.name = 'Los Angeles');
        
## Delete tuple from the jbitem        
DELETE FROM jbitem 
WHERE
    supplier IN (SELECT 
        jbsupplier.id
    FROM
        jbsupplier
            INNER JOIN
        jbcity ON jbcity.id = jbsupplier.city
    
    WHERE
        jbcity.name = 'Los Angeles');
        
## Delete tuple from jbsupply

DELETE FROM jbsupply 
WHERE
    supplier IN (SELECT 
        jbsupplier.id
    FROM
        jbsupplier
            INNER JOIN
        jbcity ON jbcity.id = jbsupplier.city
    
    WHERE
        jbcity.name = 'Los Angeles');
        
# Delete tuple from jbsupplier
DELETE FROM jbsupplier 
WHERE
    city = (SELECT 
        id
    FROM
        jbcity
    
    WHERE
        name = 'Los Angeles');
select* from jbsupplier;

/*
+-----+--------------+------+
| id  | name         | city |
+-----+--------------+------+
|   5 | Amdahl       |  921 |
|  15 | White Stag   |  106 |
|  20 | Wormley      |  118 |
|  33 | Levi-Strauss |  941 |
|  42 | Whitman's    |  802 |
|  62 | Data General |  303 |
|  67 | Edger        |  841 |
|  89 | Fisher-Price |   21 |
| 122 | White Paper  |  981 |
| 125 | Playskool    |  752 |
| 213 | Cannon       |  303 |
| 241 | IBM          |  100 |
| 440 | Spooley      |  609 |
| 475 | DEC          |   10 |
| 999 | A E Neumann  |  537 |
+-----+--------------+------+
*/
/*
19.B. For natural calamity like earthquake, the supplier in Los Angeles lost his whole business.So, to remove the supplier from the whole 
database. we need to delete data that are influence by the suppliers, item and sale connected to the city.
By removing the particular tuple in the jbsale,jbitem,jbsupply will leads to remove the supplier from Los Angeles.
*/
/*
20.Now, the employee also wants to include the suppliers that have
delivered some items, although for whom no items have been sold so
far. In other words, he wants to list all suppliers that have supplied any
item, as well as the number of these items that have been sold. Help
him! Drop and redefine the jbsale_supply view to also consider suppliers
that have delivered items that have never been sold.
*/
 
 CREATE VIEW jbsale_supply (supplier , item , q_supplied , q_sold) AS
    SELECT 
        jbsupplier.name, jbitem.name, jbitem.qoh, jbsale.quantity
    FROM
        jbsupplier
            INNER JOIN
        jbitem ON jbsupplier.id = jbitem.supplier
            LEFT OUTER JOIN
        jbsale ON jbsale.item = jbitem.id;

SELECT * FROM jbsale_supply;
/*
+--------------+-----------------+------------+--------+
| supplier     | item            | q_supplied | q_sold |
+--------------+-----------------+------------+--------+
| Cannon       | Wash Cloth      |        575 |   NULL |
| Levi-Strauss | Bellbottoms     |        600 |   NULL |
| Playskool    | ABC Blocks      |        405 |   NULL |
| Whitman's    | 1 lb Box        |        100 |      2 |
| Whitman's    | 2 lb Box, Mix   |         75 |   NULL |
| Fisher-Price | Maze            |        200 |   NULL |
| White Stag   | Jacket          |        300 |      1 |
| White Stag   | Slacks          |        325 |   NULL |
| Playskool    | Clock Book      |        150 |      2 |
| Fisher-Price | The 'Feel' Book |        225 |   NULL |
| Cannon       | Towels, Bath    |       1000 |      5 |
| Fisher-Price | Squeeze Ball    |        400 |   NULL |
| Cannon       | Twin Sheet      |        750 |      1 |
| Cannon       | Queen Sheet     |        600 |   NULL |
| White Stag   | Ski Jumpsuit    |        125 |      3 |
| Levi-Strauss | Jean            |        500 |   NULL |
| Levi-Strauss | Shirt           |       1200 |      1 |
| Levi-Strauss | Boy's Jean Suit |        500 |   NULL |
+--------------+-----------------+------------+------
*/

SELECT 
    supplier,
    SUM(q_supplied) AS total_supplied,
    SUM(q_sold) AS total_sold
FROM
    jbsale_supply
GROUP BY jbsale_supply.supplier;

/*
+--------------+----------------+------------+
| supplier     | total_supplied | total_sold |
+--------------+----------------+------------+
| Cannon       |           2925 |          6 |
| Levi-Strauss |           2800 |          1 |
| Playskool    |            555 |          2 |
| Whitman's    |            175 |          2 |
| Fisher-Price |            825 |       NULL |
| White Stag   |            750 |          4 |
+--------------+----------------+------------+
*/