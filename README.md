# 🌿 EcoFlux: End-to-End GreenTech Analytics Platform

## 📖 Project Overview
EcoFlux is a GreenTech platform designed to optimize EV charging and domestic energy usage across Western Europe. This project demonstrates a professional-grade data lifecycle moving from **raw data generation** to **predictive machine learning** and **executive business intelligence**.

## 🛠 Tech Stack
- **Languages:** Python (Polars, Scikit-Learn, Plotly)
- **Infrastructure:** Airbyte, Google BigQuery
- **Transformation:** dbt Cloud (Dimensional Modeling)
- **Analytics:** Amplitude (Behavioral), Looker Studio (Executive)

## 🏗 Data Architecture
The project follows a modern data stack architecture:
1. **Source:** Synthetic telemetry generation (3k users, 90k events).
2. **Ingest:** Airbyte syncs raw CSVs to BigQuery.
3. **Transform:** dbt layers (Staging -> Marts) using a Star Schema.
4. **Predict:** Scikit-Learn model classifies "Power Users" based on activity patterns.
5. **Visualize:** Looker Studio for ESG reporting; Amplitude for product funnels.

## 📊 Key Insights & Visuals

### Executive KPI Dashboard ([Looker Studio](https://lookerstudio.google.com/s/tD4t0Sinue4))
- **Cumulative Impact:** 154,544 kg of CO2 saved.
- **Top Market:** Denmark leads in "Green" feature adoption.
- **Adoption Rate:** 27% conversion from App Open to Smart Charge.

### Predictive Modeling (Scikit-Learn)
- **Model:** Random Forest Classifier.
- **Target:** User Propensity (predicting high-frequency chargers).
- **Outcome:** Insights allow for targeted push notifications to "High Potential" segments.

## 📁 Repository Structure
```text
├── dbt/                # dbt project, models, and schema tests
├── python/             # Data generation and ML scripts
│   ├── generate_data.py
│   └── ml_propensity.py
├── assets/             # Dashboards, logos, and architecture diagrams
└── README.md
