# Unicorn Companies Analysis


<img alt="GitHub" src="https://img.shields.io/github/license/bopith/UnicornCompanies?style=for-the-badge"> 

[![LinkedIn][https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555]][https://linkedin.com/in/bopithbun]


This repository contains SQL queries, PowerPoint presentation for the analytical project on 1060 unicorn companies in 46 countries around the world. This project aims to explore the answers to the following questions:
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

Query outputs and the summary of analytical results are presented in `uc_analytical_results.pptx`. 


## License

Distributed under the MIT License. See `LICENSE.txt` for more information.


## Acknowledgments

I thank [Maven Analytics](https://www.mavenanalytics.io/) for making the dataset on unicorn companies publicly avaiable.