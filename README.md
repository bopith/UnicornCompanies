# Unicorn Companies Analysis


[![LinkedIn](https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555)](https://www.linkedin.com/in/bopithbun/) [![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=Tableau&logoColor=white&colorB=555)](https://public.tableau.com/app/profile/bopith.bun) [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white&colorB=555)](https://github.com/bopith) <img alt="GitHub" src="https://img.shields.io/github/license/bopith/UnicornCompanies?style=for-the-badge"> 




This repository contains SQL queries and the slide presentation for the analytical project on 1060 unicorn companies in 46 countries worldwide. This project aims at exploring the answers to the following questions:
1. Which unicorn companies have had the biggest return on investment?
2. How long does it usually take for a company to become a unicorn?
3. Which industries have the most unicorns? 
4. Which countries have the most unicorns? 
5. Which investors have funded the most unicorns?


## Data

The dataset used in this analysis contains records of 1060 unicorn companies obtained from [data playground](https://www.mavenanalytics.io/data-playground) of Maven Analytics. <br />
Information on the dataset include:
- `Company` : Company name
- `Valuation` : Company valuation in billions of dollars
- `Date Joined` : The date in which the company reached $1 billion in valuation
- `Industry` : Company industry
- `City` : City the company was founded in
- `Country` : Country the company was founded in
- `Continent` : Continent the company was founded in
- `Year Founded` : Year the company was founded
- `Funding` : Total amount raised across all funding rounds in billions (B) or millions (M) of dollars
- `Select Investors` : Top 4 investing firms or individual investors (some have less than 4)


## SQL Queries

- `data_cleaning.sql`: a query for data cleaning
- `data_exploration.sql`: a query for data exploration
- `query_data_visualization.sql`: a query for data visualization in Tableau


## Analytical Results

Brief findings of this project are:
1. Zapier has the biggest return on investment.
2. It usually takes about 6 years to become a unicorn.
3. Fintech industry has the most unicorns.
4. The United States has the most unicorns.
5. Accel has funded the most unicorns.

Please check `uc_analytical_results.pdf` for more details and meaningful discussion on query outputs and analytical results.

Tableau Dashboard:
![Dashboard](/img/dashboard.png?raw=true)


## Acknowledgments

I thank [Maven Analytics](https://www.mavenanalytics.io/) for making the dataset on unicorn companies publicly avaiable.
