select location, date, total_cases, total_deaths, (CONVERT(DECIMAL(18,2), total_deaths) / CONVERT(DECIMAL(18,2), total_cases) )*100 as DeathPercent
from Portfolioproject..CovidDeaths
WHERE Location like '%canada%'
order by 1,2

--Showing what percentage of total deaths was because of Influenza

Select [Start Week], Location, [Total Deaths], [Influenza Deaths],([Influenza Deaths]/NULLIF([Total Deaths],0))*100 InfluenzaTotalDeathPERCENT
From [Provisional.Death.Counts]
Where [Total Deaths] is not null

--Showing what percentage of total deaths per total population in state
Select [Start Week],location,[Total Deaths],(NULLIF([Total Deaths],0)/338289856)*100 Deathpercentage
From [Provisional.Death.Counts] 
 
 --Looking at states with highest Death rate
 SELECT [Location], max([Total Deaths]) as HighestDeathsCount, MAX (NULLIF([Total Deaths],0)/338289856)*100 As DeathCount
 From [Provisional.Death.Counts]
 Group By [Location]
 Order By DeathCount

 --Showing the locations with highest Pneumonia Deaths

 Select [Location], max([Pneumonia Deaths]) as HighestPneumoniaCount
 From [Provisional.Death.Counts]
 Group By [Location]
 Order by HighestPneumoniaCount desc

 


SELECT POPULATION, location FROM COVIDDEATHS WHERE LOCATION LIKE'%STATES%'

SELECT *
FROM [Provisional.Death.Counts]

--Total Influenza Deaths
 SELECT SUM([Influenza Deaths])
 From [Provisional.Death.Counts]
 --Group By [Location],[Influenza Deaths]

Select 
  From [Provisional.Death.Counts] Provisional
  JOIN [Total.death] Total
  ON Select [Start Week], Location, [Total Deaths], [Influenza Deaths],([Influenza Deaths]/NULLIF([Total Deaths],0))*100 InfluenzaTotalDeathPERCENT
From [Provisional.Death.Counts]
Where [Total Deaths] is not null

--Showing what percentage of total deaths per total population in state
Select [Start Week],location,[Total Deaths],(NULLIF([Total Deaths],0)/338289856)*100 Deathpercentage
From [Provisional.Death.Counts] 
 
 --Looking at states with highest Death rate
 SELECT [Location], max([Total Deaths]) as HighestDeathsCount, MAX (NULLIF([Total Deaths],0)/338289856)*100 As DeathCount
 From [Provisional.Death.Counts]
 Group By [Location]
 Order By DeathCount

 --Showing the locations with highest Pneumonia Deaths

 Select [Location], max([Pneumonia Deaths]) as HighestPneumoniaCount
 From [Provisional.Death.Counts]
 Group By [Location]
 Order by HighestPneumoniaCount desc

 


SELECT POPULATION, location FROM COVIDDEATHS WHERE LOCATION LIKE'%STATES%'

SELECT *
FROM [Provisional.Death.Counts]

--Total Influenza Deaths
 SELECT SUM([Influenza Deaths])
 From [Provisional.Death.Counts]
 
 --Group By [Location],[Influenza Deaths]

Select Provisional.[Location],Total.[Total Deaths],
SUM(Total.[Total Deaths]) Over (Partition by Provisional.[Location] order by Provisional.[Location]) AS TotalDeath
  From [Provisional.Death.Counts] Provisional
  JOIN [total.death] Total
  ON Provisional.[Start Week]= Total.[Start Week]
  Where Provisional.[Location] is not null
  
  --USE CTE
 With CTE ([Location],[Total Deaths],TotalDeath)
  as(
  Select Provisional.[Location],Total.[Total Deaths],
SUM(Total.[Total Deaths]) Over (Partition by Provisional.[Location] order by Provisional.[Location]) as TotalDeath
  From [Provisional.Death.Counts] as Provisional
  JOIN [total.death] as Total
  ON Provisional.[Start Week]= Total.[Start Week]
  Where Provisional.[Location] is not null
  )
Select *,(TotalDeath/338289856) as death
From CTE

--Temp Table
Drop Table if exists #mortalityrate
Create Table #mortalityrate
(location nvarchar(255),
Total Deaths (float,null),
TotalDeath numeric)

Insert into #mortalityrate
Select Provisional.[Location],Total.[Total Deaths],
SUM(Total.[Total Deaths]) Over (Partition by Provisional.[Location] order by Provisional.[Location]) as TotalDeath
  From [Provisional.Death.Counts] as Provisional
  JOIN [total.death] as Total
  ON Provisional.[Start Week]= Total.[Start Week]
 -- Where Provisional.[Location] is not null

  Select *,(TotalDeath/338289856)*100 as death
From TotalDeath

Create View moralityrate as
Select Provisional.[Location],Total.[Total Deaths],
SUM(Total.[Total Deaths]) Over (Partition by Provisional.[Location] order by Provisional.[Location]) as TotalDeath
  From [Provisional.Death.Counts] as Provisional
  JOIN [total.death] as Total
  ON Provisional.[Start Week]= Total.[Start Week]
  Where Provisional.[Location] is not null

  
