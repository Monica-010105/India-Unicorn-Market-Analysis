/* SECTION 1 — MARKET OVERVIEW */
-- Q1: Total unicorns born each year
-- SELECT 
--     unicorn_entry_year,
--     COUNT(*) AS new_unicorns
-- FROM unicorns
-- GROUP BY unicorn_entry_year
-- ORDER BY unicorn_entry_year ASC;

-- Q2: Cumulative growth curve
-- SELECT 
--     unicorn_entry_year,
--     COUNT(*) AS new_unicorns,
--     SUM(COUNT(*)) OVER (ORDER BY unicorn_entry_year) AS cumulative_total
-- FROM unicorns
-- GROUP BY unicorn_entry_year
-- ORDER BY unicorn_entry_year;

-- Q3: Which year had the biggest surge?
-- SELECT 
--     unicorn_entry_year,
--     COUNT(*) AS new_unicorns,
--     RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
-- FROM unicorns
-- GROUP BY unicorn_entry_year
-- ORDER BY new_unicorns DESC;

/*  SECTION 2 — INDUSTRY ANALYSIS */
-- Q4: Which sectors dominate?
-- SELECT 
--     industry_clean AS industry,
--     COUNT(*) AS total_unicorns,
--     ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM unicorns), 1) AS percentage
-- FROM unicorns
-- GROUP BY industry_clean
-- ORDER BY total_unicorns DESC;

-- Q5: Emerging vs growing vs saturated sectors
-- SELECT 
--     industry_clean,
--     COUNT(*) AS total_unicorns,
--     MIN(unicorn_entry_year) AS first_unicorn_year,
--     MAX(unicorn_entry_year) AS latest_unicorn_year,
--     CASE 
--         WHEN COUNT(*) >= 10 THEN 'Saturated'
--         WHEN COUNT(*) >= 5  THEN 'Growing'
--         ELSE 'Emerging'
--     END AS sector_stage
-- FROM unicorns
-- GROUP BY industry_clean
-- ORDER BY total_unicorns DESC;

-- Q6: Average valuation by sector — which creates most value?
-- SELECT 
--     industry_clean,
--     COUNT(*) AS total_unicorns,
--     ROUND(AVG(valuation_million_usd)::NUMERIC, 2) AS avg_valuation_million,
--     ROUND(MAX(valuation_million_usd)::NUMERIC, 2) AS max_valuation_million,
--     ROUND(SUM(valuation_million_usd)::NUMERIC, 2) AS total_sector_valuation
-- FROM unicorns
-- WHERE valuation_million_usd IS NOT NULL
-- GROUP BY industry_clean
-- ORDER BY avg_valuation_million DESC;

/* SECTION 3 — GEOGRAPHY ANALYSIS */
-- Q7: Which cities are India's startup hubs?
-- SELECT 
--     city,
--     COUNT(*) AS total_unicorns,
--     ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM unicorns WHERE city IS NOT NULL), 1) AS percentage,
--     ROUND(AVG(valuation_million_usd)::NUMERIC, 2) AS avg_valuation_million
-- FROM unicorns
-- WHERE city IS NOT NULL
-- GROUP BY city
-- ORDER BY total_unicorns DESC;

-- Q8: Are unicorns concentrated in Tier 1 or spreading to Tier 2?
-- SELECT 
--     CASE 
--         WHEN city IN ('Bengaluru', 'Mumbai', 'New Delhi', 'Gurgaon') THEN 'Tier 1'
--         ELSE 'Tier 2'
--     END AS city_tier,
--     COUNT(*) AS total_unicorns,
--     ROUND(AVG(valuation_million_usd)::NUMERIC, 2) AS avg_valuation_million,
--     ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM unicorns WHERE city IS NOT NULL), 1) AS percentage
-- FROM unicorns
-- WHERE city IS NOT NULL
-- GROUP BY city_tier
-- ORDER BY total_unicorns DESC;

-- Q9: Industry breakdown by city
-- SELECT 
--     city,
--     industry_clean,
--     COUNT(*) AS total_unicorns
-- FROM unicorns
-- WHERE city IS NOT NULL
-- GROUP BY city, industry_clean
-- ORDER BY city, total_unicorns DESC;

/* SECTION 4 — INVESTOR ANALYSIS */
-- Q10: Most active investors
-- SELECT 
--     TRIM(investor) AS investor_name,
--     COUNT(*) AS backed_unicorns
-- FROM unicorns,
--     UNNEST(STRING_TO_ARRAY(investors, ',')) AS investor
-- WHERE investors IS NOT NULL
-- GROUP BY investor_name
-- ORDER BY backed_unicorns DESC
-- LIMIT 15;

-- Q11: Which investors dominate which sectors?
-- SELECT 
--     TRIM(investor) AS investor_name,
--     industry_clean,
--     COUNT(*) AS investments
-- FROM unicorns,
--     UNNEST(STRING_TO_ARRAY(investors, ',')) AS investor
-- WHERE investors IS NOT NULL
-- GROUP BY investor_name, industry_clean
-- HAVING COUNT(*) >= 2
-- ORDER BY investments DESC
-- LIMIT 20;

-- Q12: Which investors back the highest valued startups?
-- SELECT 
--     TRIM(investor) AS investor_name,
--     COUNT(*) AS backed_unicorns,
--     ROUND(AVG(valuation_million_usd)::NUMERIC, 2) AS avg_portfolio_valuation,
--     ROUND(SUM(valuation_million_usd)::NUMERIC, 2) AS total_portfolio_value
-- FROM unicorns,
--     UNNEST(STRING_TO_ARRAY(investors, ',')) AS investor
-- WHERE investors IS NOT NULL
-- AND valuation_million_usd IS NOT NULL
-- GROUP BY investor_name
-- HAVING COUNT(*) >= 2
-- ORDER BY avg_portfolio_valuation DESC
-- LIMIT 15;

/* SECTION 5 — FUNDING & VALUATION INSIGHTS */
-- Q13: Average time from founding to unicorn — by sector
-- SELECT 
--     industry_clean,
--     ROUND(AVG(years_to_unicorn)::NUMERIC, 1) AS avg_years_to_unicorn,
--     MIN(years_to_unicorn) AS fastest_years,
--     MAX(years_to_unicorn) AS slowest_years,
--     COUNT(*) AS total_unicorns
-- FROM unicorns
-- WHERE years_to_unicorn IS NOT NULL
-- GROUP BY industry_clean
-- ORDER BY avg_years_to_unicorn ASC;

-- Q14: Is the road to unicorn getting faster over time?
-- SELECT 
--     unicorn_entry_year,
--     ROUND(AVG(years_to_unicorn)::NUMERIC, 1) AS avg_years_to_unicorn,
--     COUNT(*) AS unicorns_that_year
-- FROM unicorns
-- WHERE years_to_unicorn IS NOT NULL
-- GROUP BY unicorn_entry_year
-- ORDER BY unicorn_entry_year;

-- Q15: Funding vs valuation — which startups do more with less?
-- SELECT 
--     startup_name,
--     industry_clean,
--     city,
--     ROUND(total_raised_million_usd::NUMERIC, 2) AS total_raised_million,
--     ROUND(valuation_million_usd::NUMERIC, 2) AS valuation_million,
--     ROUND((valuation_million_usd / NULLIF(total_raised_million_usd, 0))::NUMERIC, 2) AS valuation_to_funding_ratio
-- FROM unicorns
-- WHERE total_raised_million_usd IS NOT NULL 
-- AND valuation_million_usd IS NOT NULL
-- ORDER BY valuation_to_funding_ratio DESC
-- LIMIT 15;

-- Q16: Top 10 most valuable unicorns overall
-- SELECT 
--     startup_name,
--     industry_clean,
--     city,
--     founding_year,
--     unicorn_entry_year,
--     years_to_unicorn,
--     valuation_million_usd,
--     status_clean
-- FROM unicorns
-- WHERE valuation_million_usd IS NOT NULL
-- ORDER BY valuation_million_usd DESC
-- LIMIT 10;

-- Q17: Profitability vs valuation — do profitable startups get valued higher?
-- SELECT 
--     is_profitable,
--     COUNT(*) AS total_unicorns,
--     ROUND(AVG(valuation_million_usd)::NUMERIC, 2) AS avg_valuation_million,
--     ROUND(AVG(years_to_unicorn)::NUMERIC, 1) AS avg_years_to_unicorn
-- FROM unicorns
-- GROUP BY is_profitable
-- ORDER BY avg_valuation_million DESC;

-- Q18: Profitability breakdown by industry
-- SELECT 
--     industry_clean,
--     is_profitable,
--     COUNT(*) AS count,
--     ROUND(AVG(valuation_million_usd)::NUMERIC, 2) AS avg_valuation
-- FROM unicorns
-- GROUP BY industry_clean, is_profitable
-- ORDER BY industry_clean, count DESC;