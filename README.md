---
## A. Dataset Access

---

The dataset is sourced from **Google BigQuery public dataset**:

`bigquery-public-data.thelook_ecommerce`

This dataset contains transactional, customer, product, and logistics data from a global fashion e-commerce platform.

---

## B. Data Modeling

---

### Business Process Analysis

#### Core Business Story

The Look is a global e-commerce platform selling fashion products. The business needs to analyze:

* Sales performance across products, customers, and time periods
* Customer purchasing behavior and demographics
* Product performance and inventory insights
* Geographic sales distribution
* Order fulfillment and delivery patterns

---

### Business Process Flow

---

Customer browses products → Adds to cart → Places order →
Order fulfillment → Delivery

Each step generates valuable transactional and operational data.

---

### Key Business Questions

---

* What are the top-selling products by revenue and quantity?
* Which customer segments generate the most revenue?
* How do sales trend over time (daily, monthly, yearly)?
* How effective is order fulfillment performance?
* Which geographic regions perform best?

---

## Data Warehouse Design

---

### Schema Type: **Star Schema**

* **1 Fact Table**

  * `fact_sales`

* **5 Dimension Tables**

  * `dim_products`
  * `dim_users`
  * `dim_orders`
  * `dim_date`
  * `dim_distribution_centers`

---

### Fact Table

---

**fact_sales**

* **Grain**: One row per order item

* **Measures**:

  * quantity
  * revenue
  * total_cost
  * profit

* **Foreign Keys**:

  * order_id
  * user_id
  * product_id
  * distribution_center_id
  * date_id

---

### Dimension Tables

---

**dim_products**

* product_id (PK)
* product_name
* category
* brand
* department
* product_price
* cost

**dim_users**

* user_id (PK)
* first_name
* last_name
* email
* age
* gender
* city
* state
* country
* postal_code
* traffic_source
* created_at

**dim_orders**

* order_id (PK)
* user_id
* order_date
* quantity
* status
* shipped_at
* delivered_at
* returned_at

**dim_distribution_centers**

* distribution_center_id (PK)
* name
* latitude
* longitude

**dim_date**

* date_id (PK)
* date
* year
* quarter
* month
* week
* day
* day_of_week
* day_name
* month_name
* is_weekend

---

## C. Extract

---

Data is extracted from **BigQuery** into **PySpark DataFrames** for scalable processing.

---

## D. Transform

---

Data is cleaned, validated, and transformed using **PySpark**, applying business rules and preparing data for analytics and reporting.

---

## E. Load

---

Transformed data is loaded into **PostgreSQL** using **DDL scripts**, creating analytics-ready fact and dimension tables.

---
