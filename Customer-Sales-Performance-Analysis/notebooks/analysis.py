import pandas as pd
import matplotlib.pyplot as plt

customers = pd.read_csv("../data/customers.csv")
products = pd.read_csv("../data/products.csv")
sales = pd.read_csv("../data/sales.csv", parse_dates=["order_date"])

df = sales.merge(customers, on="customer_id").merge(products, on="product_id")

# Data quality checks
print("Missing values:\n", df.isna().sum())
print("Duplicate rows:", df.duplicated().sum())

# KPI calculations
df["gross_sales"] = df["quantity"] * df["unit_price"]
df["revenue"] = df["gross_sales"] * (1 - df["discount"])

print("\nTotal Revenue:", round(df["revenue"].sum(), 2))
print("\nRevenue by Segment:")
print(df.groupby("segment")["revenue"].sum().sort_values(ascending=False))

print("\nTop Products:")
print(df.groupby("product_name")["revenue"].sum().sort_values(ascending=False).head())

# Monthly trend
monthly = df.set_index("order_date").resample("ME")["revenue"].sum()
monthly.plot(marker="o")
plt.title("Monthly Revenue")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("../monthly_revenue.png", dpi=160)
plt.show()
