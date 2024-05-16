WITH medians AS (
    SELECT country, MEDIAN(daily_vaccinations) AS median_vaccinations
    FROM country_vaccination_stats
    WHERE daily_vaccinations IS NOT NULL
    GROUP BY country
),
imputed_data AS (
    SELECT t.country, 
           COALESCE(t.daily_vaccinations, m.median_vaccinations, 0) AS daily_vaccinations,
           t.date,
           t.vaccines
    FROM country_vaccination_stats t
    LEFT JOIN medians m ON t.country = m.country
)
SELECT * FROM imputed_data;
