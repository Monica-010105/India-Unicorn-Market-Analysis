# India Unicorn Market Analysis

Macro-level analysis of India's 99 unicorn startups (2011–2021) using Python, SQL, PostgreSQL and Tableau.

## Project Overview
This project investigates India's unicorn startup landscape — businesses that have crossed a $1 billion valuation. Through an end-to-end analytics pipeline, I examine what the rapid rise of Indian unicorns tells us about sectoral trends, geographic concentration, investor dominance, funding behaviour, and the structural health of India's startup economy.

**Core Question:** What does India's unicorn boom reveal about where value is created, who controls it, and whether it is sustainable?

## Goals & Analysis
| # | Goal | Method |
|---|------|--------|
| 1 | Track the unicorn boom over time | Yearly unicorn count, cumulative growth, peak year analysis |
| 2 | Identify sector leaders and laggards | Sector share by count, avg valuation, emerging vs saturated classification |
| 3 | Map startup geography | City-wise distribution, Tier 1 vs Tier 2 breakdown |
| 4 | Profile the investor landscape | Most active investors, sector dominance, portfolio value |
| 5 | Analyse funding and valuation dynamics | Speed to unicorn, capital efficiency ratio, profitability vs valuation |
| 6 | Deliver strategic recommendations | Actionable insights for investors, founders, and policymakers |

## Project Structure

```text
unicorn-startup-analysis/
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   │   └── Data cleaning, preprocessing, and standardization
│   └── 02_data_enrichment.ipynb
│       └── Data enrichment using fuzzy matching techniques
│
├── data/
│   ├── Unicorn_Startups.csv
│   │   └── Original startup dataset
│   ├── Unicorn_Companies.csv
│   │   └── Global unicorn dataset (secondary source)
│   ├── Unicorn_Startups_Cleaned.csv
│   │   └── Cleaned dataset generated from Notebook 01
│   └── Unicorn_Startups_Enriched.csv
│       └── Final enriched dataset used for SQL and Tableau analysis
│
├── sql_queries/
│   ├── section1_market_overview.sql
│   ├── section2_industry_analysis.sql
│   ├── section3_geography.sql
│   ├── section4_investor_analysis.sql
│   └── section5_funding_valuation.sql
│
└── README.md
    └── Project documentation and analysis summary
```

## Datasets
| Dataset | Source | Records |
|---------|--------|---------|
| Indian Unicorn Startups | Kaggle — saquib7hussain | 99 startups |
| Global Unicorn Companies | Kaggle — deepcontractor | 1,037 companies |

City, investor, and funding data was enriched by merging both datasets using fuzzy name matching. 48 of 99 startups were successfully enriched. The remaining 51 are primarily post-2022 entrants not yet captured in the global dataset.

## Methodology

### Phase 1 — Data Cleaning (Python)
- Standardised all column names and data types
- Converted valuation and profit/loss fields from text format to numeric
- Unified inconsistent sector labels ("Fintech", "Financial Technology", "Fintech Payments" → "Fintech & Financial Services")
- Engineered key columns: `years_to_unicorn`, `is_profitable`, `valuation_million_usd`

### Phase 2 — Data Enrichment (Python)
- Filtered global dataset for Indian companies (63 matches identified)
- Exact name matching applied first (46 matches)
- Fuzzy matching via `thefuzz` library for remaining records (threshold ≥ 65)
- Added city, investor names, total funding raised, and investor count columns

### Phase 3 — SQL Analysis (PostgreSQL)
18 queries across 5 analytical areas:
- **Market Overview** — boom years, cumulative unicorn growth
- **Industry Analysis** — sector dominance, avg valuation, emerging vs saturated
- **Geography** — city hubs, Tier 1 vs Tier 2 split
- **Investor Analysis** — most active investors, portfolio concentration
- **Funding & Valuation** — capital efficiency, speed to unicorn, profitability correlation

### Phase 4 — Visualisation (Tableau Public)
Built a 7-chart interactive dashboard with cross-filtering across all key dimensions.

## Analysis & Key Findings

### 1. The Unicorn Boom — Timeline
| Year | New Unicorns |
|------|-------------|
| 2021 | 46 |
| 2022 | 23 |
| 2020 | 14 |
| 2019 | 9 |
| 2018 | 4 |

2021 was a once-in-a-decade event — 46 unicorns emerged in a single year, accounting for 46% of all Indian unicorns. This was driven by post-COVID digital acceleration, record-low global interest rates, and a surge of venture capital into emerging markets. The 2023 funding winter (just 3 new unicorns) confirms this was macro-driven, not structural.

### 2. Sector Dominance
| Sector | Unicorns | Share |
|--------|----------|-------|
| Fintech & Financial Services | 26 | 26.3% |
| E-commerce | 24 | 24.2% |
| SaaS & Enterprise Tech | 14 | 14.1% |
| Healthtech | 7 | 7.1% |
| Media & Entertainment | 6 | 6.1% |

Fintech and E-commerce together account for 50% of all Indian unicorns. India's startup economy is fundamentally a payments and commerce story — built on UPI adoption, a massive unbanked population, and digital-first consumer behaviour.

### 3. Geography — Bengaluru's Dominance
| City | Unicorns |
|------|----------|
| Bengaluru | 23 |
| Gurgaon | 9 |
| Mumbai | 5 |
| Pune | 4 |
| New Delhi | 3 |

Bengaluru holds nearly half of all mapped unicorn headquarters. Its compounding advantages — deep tech talent, established VC networks, and startup culture — make this dominance structural rather than coincidental. Tier 2 cities (Jaipur, Noida, Chennai) collectively account for just 3 unicorns.

### 4. Investor Concentration — The Power Trio
| Investor | Unicorns Backed |
|----------|----------------|
| Sequoia Capital India | 19 |
| Tiger Global Management | 10 |
| Accel | 8 |
| SoftBank Group | 5 |
| Nexus Venture Partners | 4 |

Sequoia, Tiger Global, and Accel together backed 37% of all Indian unicorns. This highly concentrated investor landscape means a small number of gatekeepers shape which startups reach billion-dollar status.

### 5. Capital Efficiency
| Startup | Raised | Valuation | Ratio |
|---------|--------|-----------|-------|
| Upstox | $54M | $3,400M | 62.96x |
| CoinDCX | $109M | $2,150M | 19.65x |
| CRED | $613M | $6,400M | 10.43x |
| Razorpay | $741M | $7,500M | 10.11x |
| Darwinbox | $106M | $1,000M | 9.37x |

Upstox is India's most capital-efficient unicorn — $54M raised to reach a $3.4B valuation. CRED required 11x more capital to reach a comparable tier, illustrating how dramatically capital efficiency varies even within the same sector.

### 6. Speed to Unicorn by Sector
| Sector | Avg Years to $1B |
|--------|-----------------|
| AI & Research | 1.0 |
| Manufacturing | 3.0 |
| Automotive | 4.5 |
| E-commerce | 6.8 |
| Fintech & Financial Services | 7.9 |
| SaaS & Enterprise Tech | 10.5 |
| Media & Entertainment | 10.8 |

AI startups are moving fastest — Krutrim reached unicorn status in just 1 year. SaaS and Media are slower-burn businesses where relationships and enterprise sales cycles extend the timeline significantly.

## Strategic Recommendations

**For Investors:**
- Fintech offers the strongest risk-adjusted returns — highest sector share and capital efficiency
- Tier 2 cities represent an early-mover opportunity in currently underserved markets

**For Founders:**
- Capital efficiency is more critical than ever in a post-2021 funding environment — build lean
- AI & Research is the fastest path to unicorn status; SaaS requires patient, long-term capital

**For Policymakers:**
- Bengaluru's 50% geographic concentration is a structural risk — VC incentives in Tier 2 cities would distribute value more equitably
- Profitability pathways need policy support — 55% of unicorns are currently loss-making

## Key Takeaways
| # | Insight | Data Point |
|---|---------|-----------|
| 1 | 2021 was India's unicorn supercycle | 46 unicorns in one year — 46% of all 99 |
| 2 | Fintech + E-commerce dominate | Together = 50% of all Indian unicorns |
| 3 | Bengaluru is India's startup capital | 23 unicorn HQs — nearly half of all mapped |
| 4 | 3 investors control the ecosystem | Sequoia, Tiger Global, Accel backed 37% |
| 5 | Most unicorns are loss-making | 55/99 unprofitable — growth over profit dominates |
| 6 | Profitability is rewarded eventually | Profitable unicorns valued 23% higher on average |
| 7 | Capital efficiency varies widely | Upstox 62.96x vs CRED 10.43x — same tier, different approach |
| 8 | Speed to unicorn is sector-dependent | AI: 1 year vs Media & Entertainment: 10.8 years |
