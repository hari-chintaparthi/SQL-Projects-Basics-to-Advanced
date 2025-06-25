# 🛒 Flipkart SQL Schema – Real-Time Data Analysis

Welcome to the **Flipkart SQL Project**, a real-world e-commerce database schema designed for practicing **SQL queries** using real-time business use cases.

This repository contains:
- A complete schema of Flipkart-style tables
- Over 30+ analytical SQL queries
- Organized folders by SQL topic (Joins, Aggregations, Subqueries, etc.)

---

## 📂 Schema Overview

The database simulates a simplified version of Flipkart with the following key tables:

| Table Name        | Description |
|-------------------|-------------|
| `Customers`       | Stores customer information like name, location, age, gender |
| `Products`        | Holds product details such as category, brand, price |
| `Orders`          | Records of customer orders, with order date, status |
| `OrderDetails`    | Line-items for each order including product, quantity, price |
| `Sellers`         | Seller profile with location and rating |
| `Categories`      | Product category classifications |
| `Payments`        | Payment type and transaction status |
| `Reviews`         | Customer feedback and rating per product |

---

## ⚙️ Setup Instructions

1. **Import SQL Schema**  
   Load the `flipkart_schema.sql` into your preferred RDBMS (MySQL/PostgreSQL/SQL Server).

2. **Sample Data**  
   If sample data is included, import `flipkart_sample_data.sql`.

3. **Start Practicing Queries!**  
   Navigate to the `queries/` folder for categorized SQL questions.

---

## 📊 Query Topics Covered

Queries are grouped based on SQL learning phases:

### ✅ Phase 1: SQL Foundation
- DDL & DML Operations
- SELECT, WHERE, ORDER BY
- Aggregate Functions (SUM, AVG, COUNT)
- GROUP BY + HAVING
- Basic Joins (INNER, LEFT, RIGHT)

### ✅ Phase 2: Intermediate SQL Pro
- Subqueries (WHERE, SELECT, FROM)
- EXISTS / NOT EXISTS
- Views, CTEs
- String, Date, and Numeric Functions
- Set Operations (UNION, INTERSECT, EXCEPT)

### ✅ Phase 3: Analytics & Business Insights
- Window Functions (ROW_NUMBER, RANK, etc.)
- Revenue Trends, Top Products
- Customer Behavior Analysis
- Category-Wise Sales Performance

---

## 🧠 Sample Use Cases

- Find top 5 selling products in Electronics
- Monthly revenue trend by category
- Customers with most canceled orders
- Compare average ratings by seller
- Identify most profitable product category

---

## 📁 Project Structure
