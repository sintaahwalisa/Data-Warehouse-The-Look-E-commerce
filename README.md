# Data-Warehouse-The-Look-E-commerce

**A. Dataset Access**

The dataset is sourced from Google BigQuery's public dataset: bigquery-public-data.thelook_ecommerce

**B. Data Modeling**

Business Process Analysis

Core Business Story:

The Look is an e-commerce platform selling fashion products globally. The business needs to analyze:

- Sales performance across products, customers, and time periods
- Customer purchasing behavior and demographics
- Product performance and inventory insights
- Geographic sales distribution
- Order fulfillment and delivery patterns

Business Process Flow

Customer browses products → Adds to cart → Places order → Order fulfillment → Delivery
Each step generates valuable data points

Key Business Questions:

- What are our top-selling products by revenue and quantity?
- Which customer segments generate the most revenue?
- How do sales trend over time (daily, monthly, yearly)?
- What's our order fulfillment performance?
- Which geographic regions perform best?

Data Warehouse Design
**Schema Type: Star Schema**

1 Fact Table: fact_sales

5 Dimension Tables: dim_products, dim_users, dim_orders, dim_date, dim_distribution_centers

**Fact Table:**

fact_sales - Grain: One row per order item

Dimension Tables:

- dim_products - Product information
- dim_users - Customer information
- dim_orders - Orders information
- dim_date - Time dimension
- dim_distribution_centers - Distribution center details

Structure:

- Keys: order_id (FK), user_id (FK), product_id (FK), distribution_center_id (FK), date_id (FK)
- Measures: quantity, revenue, total_cost, profit
  
**Dimension Tables Structure**

- dim_products:
|-- product_id (PK)
 |-- product_name
 |-- category
 |-- brand
 |-- department
 |-- product_price
 |-- cost

- dim_users:
|-- user_id (PK)
 |-- first_name
 |-- last_name
 |-- email
 |-- age
 |-- gender
 |-- city
 |-- state
 |-- country
 |-- postal_code
 |-- traffic_source
 |-- created_at

- dim_orders:
|-- order_id (PK)
 |-- user_id
 |-- order_date
 |-- quantity
 |-- status
 |-- shipped_at
 |-- delivered_at
 |-- returned_at

- dim_distribution_centers:
|-- distribution_center_id (PK)
 |-- name
 |-- latitude
 |-- longitude

- dim_date:
|-- date_id (PK)
 |-- date
 |-- year
 |-- quarter
 |-- month
 |-- week
 |-- day
 |-- day_of_week
 |-- day_name
 |-- month_name
 |-- is_weekend


**C. Extract - BigQuery to PySpark DataFrames** 

**D. Transform - PySpark Data Processing** 

**E. Load - Load Transformed Data to PostgreSQL (DDL Script linked in folder)**
