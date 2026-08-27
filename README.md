# COVID-19 Exploratory Data Analysis

A SQL portfolio project that analyses reported COVID-19 cases, deaths, and vaccinations using MySQL, with findings presented in Tableau Public.

## Project overview

This project explores the global impact of COVID-19 across countries and continents. It uses SQL to examine reported cases and deaths over time, compare infection and death burden relative to population, and calculate rolling vaccination totals by location.

The Tableau dashboard is powered by exported query results rather than a live MySQL connection, making the visualisation easy to share publicly.

## Skills demonstrated

- SQL
- Exploratory data analysis
- Data filtering and aggregation
- Joins
- Common table expressions (CTEs)
- Temporary tables and views
- Window functions for rolling vaccination totals
- Tableau data preparation and visualisation
  
## Business question

How did reported COVID-19 cases and deaths vary over time and across countries and continents, and which locations experienced the greatest infection burden relative to population?

## 📊 Explore the interactive Tableau dashboard

> Explore global case and death totals, deaths by continent, country infection rates, and infection trends over time.

[**Open the interactive Tableau dashboard →**](https://public.tableau.com/shared/R2X565H5M?:display_count=n&:origin=viz_share_link)

## Key insights

- The dataset covers 24 February 2020 to 30 April 2021.

- By the end of the period, the dashboard reports 150,574,977 cases and 3,180,206 deaths globally: reported deaths were 2.11% of reported cases.

- Europe recorded the largest reported continental death total in the dashboard, with 1,016,750 deaths, followed by North America with 847,942.

- Andorra had the highest reported infection rate relative to population at 17.13%.

- The United States recorded the largest reported case count in the dataset, with 32,346,971 cases, while its reported infection rate was 9.77% of the population.

- The SQL analysis also calculates a running total of vaccinations per location, enabling vaccination progress to be compared with population size.

## Tools used

- MySQL
- MySQL Workbench
- Tableau Public
- CSV and Excel exports for Tableau

## Dataset

This project uses a historical snapshot of the [Our World in Data COVID-19 dataset](https://ourworldindata.org/coronavirus-source-data).

- **Coverage:** 24 February 2020 to 30 April 2021
- **Tables used:** `deaths` and `vaccinations`
- **Measures explored:** reported cases, deaths, population, testing and vaccination data
- **Source files:** `CovidDeaths.xlsx` and `CovidVaccinations.xlsx`, imported into MySQL Workbench with the Table Data Import Wizard
- **Data availability:** The project includes the source Excel files and Tableau-ready exports.

## Repository structure

```text
.
├── my scripts/
│   ├── Covid Project script.sql       # Exploratory analysis and vaccination queries
│   └── Tableau scripts.sql            # Four result sets exported for Tableau Public
├── Tableau Tables/                    # CSV/Excel extracts used by the dashboard
├── Tableau Dash/
│   └── Covid Dash.twb                 # Tableau workbook
├── CovidDeaths.xlsx                   # Historical cases and deaths data
├── CovidVaccinations.xlsx             # Historical vaccination data
└── README.md
```

## SQL workflow

### 1. Prepare the source tables

Use MySQL Workbench's Table Data Import Wizard to import `CovidDeaths.xlsx` and `CovidVaccinations.xlsx`. Name the resulting tables `deaths` and `vaccinations` respectively; these are the table names used throughout the SQL analysis.

### 2. Run the exploratory analysis

[`Covid Project script.sql`](./my%20scripts/Covid%20Project%20script.sql) covers:

- UK case-to-death and case-to-population comparisons
- Countries with the highest infection and death rates relative to population
- Total deaths by country and continent
- Global daily and overall reported case and death totals
- A join between deaths and vaccination data
- Rolling vaccination totals using a window function
- CTE, temporary-table, and view approaches for calculating the percentage of the population vaccinated

### 3. Export Tableau-ready results

[`Tableau scripts.sql`](./my%20scripts/Tableau%20scripts.sql) produces four result sets for export:

1. Global case, death, and reported death-percentage metrics
2. Total reported deaths by continent
3. Country-level infection counts and percentages of population infected
4. Country infection trends over time

Export each result set to CSV or Excel, then use the files as Tableau data sources. This is the deliberate bridge between MySQL and Tableau Public, where a live MySQL connection is not available.

## How to run the project

1. Use MySQL 8.0 or later, then create a schema for the project.
2. Use the Table Data Import Wizard to import `CovidDeaths.xlsx` as `deaths` and `CovidVaccinations.xlsx` as `vaccinations`.
3. Confirm the two imported table names match the references in `my scripts/Covid Project script.sql`.
4. Run `Covid Project script.sql` in MySQL Workbench to explore the data and create the vaccination view.
5. Run `Tableau scripts.sql` and export the four result sets to CSV or Excel.
6. Open `Tableau Dash/Covid Dash.twb` in Tableau and connect it to the exported files, or review the published [Tableau Public dashboard](https://public.tableau.com/shared/R2X565H5M?:display_count=n&:origin=viz_share_link).

## Author

[jmtadpatrikar](https://github.com/jmtadpatrikar)  
Project repository: [Covid-19-Portfolio-Project](https://github.com/jmtadpatrikar/Covid-19-Portfolio-Project)
