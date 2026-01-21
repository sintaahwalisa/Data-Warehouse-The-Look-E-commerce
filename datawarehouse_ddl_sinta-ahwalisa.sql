-- Create Database
CREATE DATABASE dbt;

-- Dimension: Date
DROP TABLE IF EXISTS public.dim_date CASCADE;

CREATE TABLE public.dim_date (
    date_id 	   INTEGER PRIMARY KEY,
    date 		   DATE UNIQUE NOT NULL,
    year           INTEGER NOT NULL,
    quarter        INTEGER NOT NULL,
    month          INTEGER NOT NULL,
    week           INTEGER NOT NULL,
    day            INTEGER NOT NULL,
    day_of_week    INTEGER NOT NULL,
    day_name       VARCHAR(10) NOT NULL,
    month_name     VARCHAR(10) NOT NULL,
    is_weekend     BOOLEAN NOT NULL
);

-- Dimension: Users (Customers)
DROP TABLE IF EXISTS public.dim_users CASCADE;

CREATE TABLE public.dim_users (
    user_id         INTEGER PRIMARY KEY,
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    email           VARCHAR(100),
    age             INTEGER,
    gender          VARCHAR(10),
    city            VARCHAR(100) NOT NULL,
    state           VARCHAR(100) NOT NULL,
    country         VARCHAR(100) NOT NULL,
    postal_code     VARCHAR(20),
    traffic_source  VARCHAR(50) NOT NULL,
	created_at      TIMESTAMP
);

-- Dimension: Orders
DROP TABLE IF EXISTS public.dim_orders CASCADE;

CREATE TABLE public.dim_orders (
    order_id            INTEGER PRIMARY KEY,
    user_id             INTEGER NOT NULL,
    order_date          DATE NOT NULL,
    quantity            INTEGER,
    status              VARCHAR(50),
    shipped_at          TIMESTAMP,
    delivered_at        TIMESTAMP,
    returned_at         TIMESTAMP
);

-- Dimension: Distribution Centers
DROP TABLE IF EXISTS public.dim_distribution_centers CASCADE;

CREATE TABLE public.dim_distribution_centers (
    distribution_center_id   INTEGER PRIMARY KEY,
    name                     VARCHAR(100),
    latitude                 NUMERIC(9,6),
    longitude                NUMERIC(9,6)
);


-- Dimension: Products
DROP TABLE IF EXISTS public.dim_products CASCADE;

CREATE TABLE public.dim_products (
    product_id               INTEGER PRIMARY KEY,
    product_name             VARCHAR(255),
	product_price            NUMERIC(10,2),
    category                 VARCHAR(100),
    brand                    VARCHAR(100),
    department               VARCHAR(100),
    cost                     NUMERIC(10,2)
);



-- FACT_SALES TABLE
DROP TABLE IF EXISTS public.fact_sales CASCADE;

CREATE TABLE public.fact_sales (
	order_item_id			 INTEGER,
    order_id                 INTEGER,
    user_id                  INTEGER,
	product_id				 INTEGER,
    distribution_center_id   INTEGER,
    date_id            		 INTEGER,
    sale_price               NUMERIC(10,2),
    cost                     NUMERIC(10,2),
	quantity                 INTEGER NOT NULL,
    revenue                  NUMERIC(10,2),
	total_cost				 NUMERIC(10,2),
	profit                   NUMERIC(11,2),

-- Foreign Key Constraints
    CONSTRAINT fk_date FOREIGN KEY (date_id) 
        REFERENCES dim_date(date_id) ON DELETE CASCADE,
    CONSTRAINT fk_order FOREIGN KEY (order_id) 
        REFERENCES dim_orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_user FOREIGN KEY (user_id) 
        REFERENCES dim_users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_distribution_center FOREIGN KEY (distribution_center_id) 
        REFERENCES dim_distribution_centers(distribution_center_id) ON DELETE SET NULL,
	CONSTRAINT fk_product FOREIGN KEY (product_id) 
        REFERENCES dim_products(product_id) ON DELETE CASCADE
);




-- Checking & Valdiation
SELECT current_database(), current_schema();

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT COUNT(*) FROM public.dim_date;
SELECT COUNT(*) FROM public.dim_users;
SELECT COUNT(*) FROM public.dim_orders;
SELECT COUNT(*) FROM public.dim_distribution_centers;
SELECT COUNT(*) FROM public.dim_products;
SELECT COUNT(*) FROM public.fact_sales;

SELECT * FROM public.dim_date;
SELECT * FROM public.dim_users;
SELECT * FROM public.dim_orders;
SELECT * FROM public.dim_distribution_centers;
SELECT * FROM public.dim_products;
SELECT * FROM public.fact_sales;

SELECT * FROM public.fact_sales;
SELECT * FROM public.dim_date
ORDER BY date_id;
SELECT * FROM public.dim_users
ORDER BY user_id;
SELECT * FROM public.dim_orders
ORDER BY order_id;
SELECT * FROM public.dim_products
ORDER BY product_id;
SELECT * FROM public.dim_distribution_centers
ORDER BY distribution_center_id;