# NEXUSPLAY — Next-Gen Digital Game Store & Rental Platform

An enterprise-grade, dark cyberpunk-themed **ASP.NET Web Forms (.NET Framework 4.8.1)** gaming ecommerce platform with direct **ADO.NET (`SqlConnection`, `SqlCommand`, `SqlDataReader`)** integration and **Zero-Session Cookie Authentication**.

---

## 🎮 Features

- **Cyberpunk Dark UI**: Glassmorphic neon theme powered by `Orbitron`, `Rajdhani`, and `Inter` typography with responsive card layouts and micro-interactions.
- **Dual Purchase Model**:
  - **Buy to Own**: Permanent DRM keys across PC (Steam/Epic), PlayStation, Xbox, and Nintendo Switch.
  - **Rent Flexible**: 7-day flexible rentals with 100% rent-to-own purchase credit.
- **Zero-Session Architecture**: Authentication and gamer identity stored securely in encrypted HTTP-only cookies (`NexusUser`) via `AuthHelper`.
- **Direct ADO.NET Architecture**:
  - All database operations utilize `SqlConnection cn`, `SqlCommand co`, and `ds = co.ExecuteReader()`.
  - Zero ORM overhead, fast database queries.
- **Dynamic Shopping Cart**:
  - Real-time AJAX and postback cart management.
  - Platform selection, quantity adjustment, subtotal/tax calculation.
- **Multi-Item & Single-Item Checkout**:
  - Multi-table SQL transaction checkout (`[dbo].[orders]`, `[dbo].[order_items]`, `[dbo].[transaction_history]`).
  - Automatic activation license key generator (`NX-XXXX-XXXX-XXXX`).
- **Transaction History**:
  - Dedicated audit log and digital receipts page (`Transactions.aspx`).
- **Pure Presentation Landing Page**:
  - `Landing.aspx` dedicated to high-impact marketing, featured vault titles, categories, and membership access passes.

---

## 🛠️ Technology Stack

- **Framework**: ASP.NET Web Forms (.NET Framework 4.8.1)
- **Language**: C# 12
- **Database**: Microsoft SQL Server (`GameStore` database)
- **Data Access**: Direct ADO.NET (`System.Data.SqlClient`)
- **Styling**: ASP.NET Themes (`App_Themes/Gaming/theme.css`, `Controls.skin`)
- **Icons**: Custom Cyberpunk SVG Vectors

---

## 🗄️ Database Schema

The SQL Server database (`GameStore`) consists of:

1. **`[dbo].[user]`**: User accounts (username, email, password hash, role, created_at).
2. **`[dbo].[games]`**: Game catalog (title, category, buy/rent pricing, platform support, rating, image URL).
3. **`[dbo].[cart]`**: Active user shopping carts with license type and quantity.
4. **`[dbo].[orders]`**: Completed purchases with total, tax, payment details, and shipping.
5. **`[dbo].[order_items]`**: Line items per order with generated activation license keys.
6. **`[dbo].[transaction_history]`**: Financial audit trail for all order payments and receipts.

---

## 🚀 Getting Started

### Prerequisites

- Visual Studio 2022 or Visual Studio 2026 / Community Edition with **ASP.NET and web development** workload.
- Microsoft SQL Server / SQL Server Express (e.g. `.\SQLEXPRESS01`).
- IIS Express (included with Visual Studio).

### Running Locally

1. Open the solution in Visual Studio:
   ```bash
   WebApplication1.slnx
   ```
2. Ensure SQL Server is running and connection string points to your instance:
   ```csharp
   Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Encrypt=True;TrustServerCertificate=True;
   ```
3. Press **F5** or run via IIS Express:
   ```bash
   http://localhost:52149/Landing.aspx
   ```

---

## 📄 License

MIT License. Built for gamers and developers.
