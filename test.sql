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
WHERE population > (SELECT population FROM world WHERE name='Russia')
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
WHERE area >= ALL (SELECT area FROM world y WHERE y.continent = x.continent AND area > 0)
-- 8
SELECT continent, name
FROM world x
WHERE x.name <= ALL(SELECT y.name FROM world y WHERE x.continent=y.continent)
ORDER BY continent
-- 9
SELECT name,continent, population FROM world x
WHERE NOT EXISTS(
SELECT * FROM world y
WHERE x.continent = y.continent
AND y.population > 25000000
)
-- 10
SELECT name, continent FROM world x
WHERE population > ALL(SELECT population * 3 FROM world y
WHERE x.continent = y.continent AND x.name <> y.name)
-- SUM and COUNT
-- 1
SELECT SUM(population) FROM world
-- 2
SELECT DISTINCT continent FROM world
-- 3
SELECT SUM(gdp) FROM world
WHERE continent = 'Africa'
-- 4
SELECT COUNT(name) FROM world
WHERE area >= 1000000
-- 5
SELECT SUM(population) FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
-- 6
SELECT continent, COUNT(name) FROM world
GROUP BY continent
-- 7
SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent
-- 8
SELECT continent FROM world x
WHERE 100000000 <= (SELECT SUM(population) FROM world y WHERE x.continent = y.continent)
GROUP BY continent
-- The JOIN operation
-- 1
SELECT matchid, player FROM goal
WHERE teamid = 'GER'
-- 2
SELECT id,stadium,team1,team2 FROM game
WHERE id = 1012
-- 3
SELECT player, teamid, stadium, mdate FROM game
JOIN goal
ON id = matchid
WHERE teamid = 'GER'
-- 4
SELECT team1, team2, player FROM game
JOIN goal
ON game.id = goal.matchid
WHERE player LIKE 'Mario%'
-- 5
SELECT player, teamid, coach, gtime  FROM goal
JOIN eteam ON goal.teamid = eteam.id
WHERE gtime<=10
-- 6
SELECT mdate, teamname FROM game
JOIN eteam ON eteam.id = game.team1
WHERE coach = 'Fernando Santos'
-- 7
SELECT player FROM goal
JOIN game ON goal.matchid = game.id
WHERE stadium = 'National Stadium, Warsaw'
-- 8
SELECT DISTINCT player FROM game
JOIN goal ON goal.matchid =game.id
WHERE (team1='GER' OR team2='GER')
AND teamid <>'GER'
-- 9
SELECT teamname, COUNT(player) FROM eteam
JOIN goal ON id=teamid
GROUP BY teamname
-- 10
SELECT stadium, COUNT(player) FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY stadium
-- 11
SELECT matchid, mdate, COUNT(*)
FROM game JOIN goal ON game.id = goal.matchid
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate
-- 12
SELECT matchid, mdate, COUNT(*) FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate
-- 13
SELECT mdate,
team1,
SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) score1,
team2,
SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) score2
FROM game
JOIN goal ON goal.matchid = game.id
GROUP BY game.mdate, goal.matchid, game.team1, game.team2
-- More JOIN operations
-- 1
SELECT id, title FROM movie
WHERE yr = 1962
-- 2
SELECT yr FROM movie
WHERE title = 'Citizen Kane'
-- 3
SELECT id, title, yr FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr
-- 4
SELECT id FROM actor
WHERE name = 'Glenn Close'
-- 5
SELECT id FROM movie
WHERE title = 'Casablanca'
-- 6
SELECT name FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE casting.movieid=11768
-- 7
SELECT name FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE movie.title = 'Alien'
-- 8
SELECT title FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford'
-- 9
SELECT title FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford' AND ord <> 1
-- 10
SELECT title, name FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE casting.ord = 1 AND  movie.yr = 1962
-- 11
SELECT yr, COUNT(title) FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
ORDER BY COUNT(title) DESC
-- 12
SELECT title,name FROM movie
JOIN casting ON movie.id = casting.movieid AND casting.ord = 1
JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN(
  SELECT movieid FROM casting WHERE actorid IN
  (SELECT id FROM actor WHERE name='Julie Andrews')
  )
-- 13
SELECT name FROM movie
JOIN casting ON movie.id = casting.movieid AND casting.ord = 1
JOIN actor ON casting.actorid = actor.id
GROUP BY name
HAVING COUNT(ord) >= 15
ORDER BY name
-- 14
SELECT title, count(actorid) FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE yr=1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title
-- 15
SELECT name FROM actor
JOIN casting ON actor.id = actorid
JOIN movie ON movie.id = movieid
WHERE movieid IN (SELECT movieid FROM casting WHERE actorid IN(SELECT id FROM actor WHERE name = 'Art Garfunkel')) AND actor.name <> 'Art Garfunkel'
-- Using Null
-- 1
SELECT NAME FROM teacher
WHERE dept IS NULL
-- 2
SELECT teacher.name, dept.name FROM teacher
JOIN dept ON teacher.dept = dept.id
-- 3
SELECT teacher.name, dept.name FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id
-- 4
SELECT teacher.name, dept.name FROM teacher
RIGHT JOIN dept ON teacher.dept = dept.id
-- 5
SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher
-- 6
SELECT teacher.name, COALESCE(dept.name,'None') FROM teacher
LEFT JOIN dept ON dept.id = teacher.dept
-- 7
SELECT COUNT(name), COUNT(mobile) FROM teacher
-- 8
SELECT dept.name, COUNT(teacher.name)
FROM teacher
RIGHT JOIN dept ON dept.id = teacher.dept
GROUP BY dept.name
-- 9
SELECT teacher.name,
CASE
WHEN teacher.dept =1 OR teacher.dept = 2 THEN 'Sci'
ELSE 'Art'
END
FROM teacher
LEFT JOIN dept ON dept.id = teacher.dept
-- 10
SELECT teacher.name,
CASE
WHEN teacher.dept = 1 OR teacher.dept = 2 THEN 'Sci'
WHEN teacher.dept = 3  THEN 'Art'
ELSE 'None'
END
FROM teacher
LEFT JOIN dept ON dept.id = teacher.dept
-- Self join
-- 1
SELECT COUNT(id) FROM stops
-- 2
SELECT id FROM stops
WHERE name = 'Craiglockhart'
-- 3
SELECT id, name FROM stops
JOIN route ON route.stop = stops.id
WHERE company = 'LRT' AND num = 4
ORDER BY pos
-- 4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING num = 4 OR num = 45
-- 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop =149
-- 6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'
-- 7
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop =137
-- 8
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross'
-- 9
SELECT DISTINCT stopb.name, b.company, b.num
FROM route a
JOIN route b ON (a.num = b.num AND a.company = b.company)
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart'
-- 10
