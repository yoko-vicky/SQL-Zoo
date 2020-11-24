-- SELECT basics
-- 1
SELECT population FROM world
  WHERE name = 'Germany'
-- 2
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
-- 3
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000
-- SELECT from WORLD Tutorial
-- 1
SELECT name, continent, population FROM world
-- 2
SELECT name FROM world
  WHERE population >  200000000
-- 3
SELECT name, gdp/population FROM world
  WHERE population >  200000000
-- 4
SELECT name, population/1000000 FROM world
  WHERE continent = 'South America'
-- 5
SELECT name, population FROM world
  WHERE name IN ('France', 'Germany', 'Italy')
-- 6
SELECT name FROM world WHERE name LIKE '%United%'
-- 7
SELECT name, population, area FROM world
WHERE area > 3000000 OR population > 250000000
-- 8
SELECT name, population, area FROM world
WHERE area > 3000000 XOR population > 250000000
-- 9
SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2) FROM world
WHERE continent = 'South America'
-- 10
SELECT name, ROUND(gdp/population,-3)
FROM world WHERE gdp > 1000000000000
-- 11
SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital)
-- 12
SELECT name, capital FROM world
WHERE LEFT(name,1) = LEFT(capital,1) AND name <>capital
-- 13
SELECT name FROM world
WHERE name NOT LIKE '% %' AND name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%'
-- SELECT from Nobel Tutorial
-- 1
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950
-- 2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
-- 3
SELECT yr, subject FROM nobel
WHERE winner = 'Albert Einstein'
-- 4
SELECT winner FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000
-- 5
SELECT * FROM nobel
WHERE subject = 'Literature'
AND yr BETWEEN 1980 AND 1989
-- 6
SELECT * FROM nobel
WHERE winner IN('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')
-- 7
SELECT winner FROM nobel
WHERE winner LIKE 'John%'
-- 8
SELECT yr, subject, winner FROM nobel
WHERE (subject = 'Physics' AND yr =1980) OR (subject = 'Chemistry' AND yr =1984)
-- 9
SELECT yr, subject, winner FROM nobel
WHERE yr =1980 AND subject NOT IN ('Chemistry', 'Medicine')
-- 10
SELECT yr, subject, winner FROM nobel
WHERE subject ='Literature' AND yr >= 2004
OR subject = 'Medicine' AND yr < 1910
-- 11
SELECT * FROM nobel
WHERE winner LIKE 'PETER GRÜNBERG'
-- 12
SELECT * FROM nobel
WHERE winner LIKE 'EUGENE O''NEILL'
-- 13
SELECT winner, yr, subject FROM nobel
WHERE winner LIKE 'Sir%'
-- 14
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject, winner
-- SELECT within SELECT Tutorial
-- 1
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
-- 2
SELECT name FROM world
WHERE continent = 'Europe'
AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom')
-- 3
SELECT name, continent FROM world
WHERE continent IN(SELECT continent FROM world WHERE name IN('Argentina', 'Australia')) ORDER BY name
-- 4
SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
AND population < (SELECT population FROM world WHERE name = 'Poland')
-- 5
SELECT name, CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany')) , '%')
FROM world
WHERE continent = 'Europe'
-- 6
SELECT name FROM world
WHERE gdp > (SELECT gdp FROM world WHERE continent ='Europe' AND gdp IS NOT NULL ORDER BY gdp DESC LIMIT 1)
-- 7
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area > 0)
-- 8
