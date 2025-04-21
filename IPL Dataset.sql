Create table IPL_Match(
id int,
season int,
city varchar(100),
date date,
match_type varchar(50),
player_of_match varchar(500),
venue varchar(500),
team1 varchar(100),
team2 varchar(100),
toss_winner varchar(100),
toss_decision varchar(100),
winner varchar(100),
result varchar(100),
result_margin Real,
target_runs int,
target_overs real,
super_over varchar(10),
method varchar(50),
umpire1 varchar(200),
umpire2 varchar(200)

)
--Most Successfull Teams(by Wins)
select winner,count(*) as total_wins
from IPL_Match
group by winner
order by total_wins desc

--Toss Impact:Does Winning the toss help?
select 
toss_winner = winner as toss_helped,
count(*) as match_count
from IPL_Match
group by toss_helped

--Top Cities with most matches
select city, count(*) as match_count
from IPL_Match
group by city
order by match_count desc

--Most Player of the match awards
select player_of_match, count(*) as awards
from IPL_Match
group by player_of_match
order by awards
limit 10

--Most common final components(Final Match Insights)
select team1, team2, count(*) as final_clashes
from IPL_Match
where match_type = 'Fil'
group by team1, team2
order by final_clashes desc

--Super Over Matches
select * from IPL_Match
where super_over = 'Y'

--Average Winning Margin by Runs VS Wickets
select result, avg(result_margin) as average_margin
from IPL_Match
group by result

--Matches per season
select season, count(*) as matches_played
from IPL_Match
group by season
order by season

--5Cities with least matches
select city, count(*) as match_played
from IPL_Match
group by city
order by match_played
Limit 5

--Toss Decision Analysis: Field or Bat
select toss_winner , count(*) as total_matches
from IPL_Match
group by toss_winner

--10Most used stadiums
select venue, count(*) as match_count
from IPL_Match
group by venue
order by match_count desc
limit 10

--5Most Frequent Umpire Pair
select umpire1, umpire2, count(*) as matches_together
from IPL_Match
group by umpire1, umpire2
order by matches_together desc
limit 5

--First and Last match of each season
select season, MIN(date) as season_start, MAX(date) as season_end
from IPL_Match
group by season



--Matches where toss loser still win
select * from IPL_Match
where toss_winner!=winner

--Total matches per team(as team1 or team2)
select team, count(*) as total_matches
from
(select team1 as team from IPL_Match
union all
select team2 as team from IPL_Match
) as all_teams
group by team
order by total_matches

--Teams with most toss wins
select toss_winner, count(*) as toss_wins
from IPL_Match
group by toss_winner
order by toss_wins desc

--Count of tied matches
select count(*) as tied_matches
from IPL_Match
where result = 'tie'

--Largest Victory Margins(By Runs or Wickets)
--By Runs
select winner, result_margin
from IPL_Match
where result = 'runs'
order by result_margin desc
limit 1
--By Wickets
select winner, result_margin
from IPL_Match
where result = 'wickets'
order by result_margin desc
limit 1


