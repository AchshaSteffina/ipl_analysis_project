-- USE ipl_analysis;
-- DROP TABLE IF EXISTS deliveries;
-- DROP TABLE IF EXISTS matches;

-- CREATE TABLE matches (
--     id INT PRIMARY KEY,
--     season INT,
--     city VARCHAR(100),
--     date DATE,
--     match_type VARCHAR(50),
--     player_of_match VARCHAR(100),
--     venue VARCHAR(255),
--     team1 VARCHAR(100),
--     team2 VARCHAR(100),
--     toss_winner VARCHAR(100),
--     toss_decision VARCHAR(20),
--     winner VARCHAR(100),
--     result VARCHAR(50),
--     result_margin INT,
--     target_runs INT,
--     target_overs INT,
--     super_over VARCHAR(10),
--     umpire1 VARCHAR(100),
--     umpire2 VARCHAR(100)
-- );

-- DESC matches;
-- SELECT COUNT(*) FROM MATCHES;

-- CREATE TABLE deliveries (
--     match_id INT,
--     inning INT,
--     batting_team VARCHAR(100),
--     bowling_team VARCHAR(100),
--     `over` INT,
--     ball INT,
--     batter VARCHAR(100),
--     bowler VARCHAR(100),
--     non_striker VARCHAR(100),
--     batsman_runs INT,
--     extra_runs INT,
--     total_runs INT,
--     extras_type VARCHAR(50),
--     is_wicket INT,
--     player_dismissed VARCHAR(100),
--     dismissal_kind VARCHAR(100),
--     fielder VARCHAR(100)
-- );

-- DESC deliveries;

-- ALTER TABLE deliveries
-- ADD CONSTRAINT fk_match
-- FOREIGN KEY (match_id)
-- REFERENCES matches(id);

-- 1---Team Wins

-- SELECT
--     winner,
--     COUNT(*) AS wins
-- FROM matches
-- GROUP BY winner
-- ORDER BY wins DESC;

-- 2----Matches Per Season 

-- SELECT
--     season,
--     COUNT(*) AS matches_played
-- FROM matches
-- GROUP BY season
-- ORDER BY season;

-- 3---. Top Run Scorers
-- SELECT batter, SUM(batsman_runs) AS total_runs
-- FROM deliveries
-- GROUP BY batter
-- ORDER BY total_runs DESC
-- LIMIT 10;


-- 4. Top Wicket Takers

-- SELECT bowler, COUNT(*) AS wickets
-- FROM deliveries
-- WHERE is_wicket = 1
-- AND dismissal_kind NOT IN ('run out','retired hurt')
-- GROUP BY bowler
-- ORDER BY wickets DESC
-- LIMIT 10;

-- 5. Toss Winner vs Match Winner

-- SELECT COUNT(*) AS toss_and_match_won
-- FROM matches
-- WHERE toss_winner = winner;

-- 6. Toss Advantage Percentage

-- SELECT
-- ROUND(
-- COUNT(CASE WHEN toss_winner = winner THEN 1 END)
-- *100.0/COUNT(*),2
-- ) AS toss_advantage_percentage
-- FROM matches;

-- 7. Top Venues

-- SELECT venue, COUNT(*) AS matches
-- FROM matches
-- GROUP BY venue
-- ORDER BY matches DESC
-- LIMIT 10;

-- 8. Matches Hosted by City

-- SELECT city, COUNT(*) AS matches
-- FROM matches
-- GROUP BY city
-- ORDER BY matches DESC;

-- 9. Top Player of the Match Winners

-- SELECT player_of_match,
-- COUNT(*) AS awards
-- FROM matches
-- GROUP BY player_of_match
-- ORDER BY awards DESC
-- LIMIT 10;

-- 10. Runs Scored Per Season

-- SELECT
-- m.season,
-- SUM(d.total_runs) AS runs
-- FROM matches m
-- JOIN deliveries d
-- ON m.id = d.match_id
-- GROUP BY m.season
-- ORDER BY m.season;

-- 11. Top Batter in IPL

-- SELECT
-- d.batter,
-- SUM(d.batsman_runs) AS runs
-- FROM deliveries d
-- JOIN matches m
-- ON d.match_id = m.id
-- GROUP BY d.batter
-- ORDER BY runs DESC
-- LIMIT 1;

-- 12. Top Bowler in IPL

-- SELECT
-- d.bowler,
-- COUNT(*) AS wickets
-- FROM deliveries d
-- JOIN matches m
-- ON d.match_id = m.id
-- WHERE d.is_wicket = 1
-- GROUP BY d.bowler
-- ORDER BY wickets DESC
-- LIMIT 1;

-- 13. Highest Team Score

-- SELECT
-- batting_team,
-- match_id,
-- SUM(total_runs) AS team_score
-- FROM deliveries
-- GROUP BY match_id, batting_team
-- ORDER BY team_score DESC
-- LIMIT 10;

-- 14. Average Runs Per Match

-- SELECT
-- ROUND(AVG(team_score),2) AS avg_score
-- FROM
-- (
-- SELECT
-- match_id,
-- batting_team,
-- SUM(total_runs) AS team_score
-- FROM deliveries
-- GROUP BY match_id, batting_team
-- ) t;

-- 15. Most Successful Venue for Toss Winners

-- SELECT
-- venue,
-- COUNT(*) AS toss_match_wins
-- FROM matches
-- WHERE toss_winner = winner
-- GROUP BY venue
-- ORDER BY toss_match_wins DESC;

