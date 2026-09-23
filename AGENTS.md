# AGENTS.md — AI Agent Guidance & Coding Instructions

> **Notice to All AI Agents (Antigravity, Cursor, Copilot, Claude Code, Devin, Windsurf, etc.):**  
> Read this file carefully before reading or modifying code in this repository. It defines non-negotiable architectural constraints, coding patterns, and setup commands.

---

## 🚀 1. Prompt to Give Any AI Agent Upon Cloning

If you are cloning this repository and passing it to an AI agent, use this exact prompt:

```text
You are working on NEXUSPLAY, an enterprise-grade ASP.NET Web Forms (.NET Framework 4.8.1) Game Store and Rental application with direct ADO.NET and Microsoft SQL Server.

CRITICAL ARCHITECTURAL CONSTRAINTS:
1. ZERO SESSION: NEVER use `Session[...]` anywhere in this repository. All user identity and authentication are managed strictly via HTTP cookies using `AuthHelper.cs` (Cookie name: `NexusUser`).
2. DIRECT ADO.NET: All database interactions MUST strictly follow the direct ADO.NET pattern using `SqlConnection cn`, `SqlCommand co`, `SqlDataReader ds`, and `ds = co.ExecuteReader()`. Do NOT install or use Entity Framework, Dapper, LINQ-to-SQL, or any ORM.
3. LANDING PAGE IS PURE PRESENTATION: `Landing.aspx` is 100% design-only. Do NOT write SQL queries, database logic, or data-binding repeaters in `Landing.aspx.cs`.
4. NAVBAR RULES:
   - `Landing.aspx` navbar shows "Sign In" and "Join Free" buttons.
   - Store pages (`Home.aspx`, `Cart.aspx`, `Buy.aspx`, `Transactions.aspx`) MUST NEVER show "Sign In" or "Join Free". They show user avatar, Cart count badge, and Transaction History link.
5. DATABASE: The database is named `GameStore` on SQL Server (`.\SQLEXPRESS01`). The full table schema and seed data are located in `Database/setup_database.sql`.
6. DESIGN THEME: Uses ASP.NET Theme `Gaming` located at `App_Themes/Gaming/theme.css`. Maintain the cyberpunk dark glassmorphic UI with neon cyan, purple, and pink accents.

Read `AGENTS.md` and `README.md` for full context before making changes.
```

---

## 🛠️ 2. Environment Setup & Execution Commands

### A. Database Initialization
Execute the all-in-one setup script against SQL Server Express (`.\SQLEXPRESS01`):
```powershell
sqlcmd -S .\SQLEXPRESS01 -i "Database\setup_database.sql"
```
This automatically creates the `GameStore` database, 6 tables with proper constraints, and seeds catalog games and default user credentials.

### B. Building the Solution
Compile via MSBuild without opening Visual Studio:
```powershell
& "C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\MSBuild.exe" "WebApplication1\WebApplication1.csproj" /t:Build /p:Configuration=Debug
```

### C. Running Locally via IIS Express
Serve the application locally:
```powershell
& "C:\Program Files\IIS Express\iisexpress.exe" /path:"c:\Users\vishn\source\repos\WebApplication1\WebApplication1" /port:52149
```
Access points:
- Landing Page: `http://localhost:52149/Landing.aspx`
- Store Catalog: `http://localhost:52149/Home.aspx`
- Cart: `http://localhost:52149/Cart.aspx`
- Transactions: `http://localhost:52149/Transactions.aspx`

---

## 🏛️ 3. Core Architectural Rules (Strictly Enforced)

### Rule 1: Zero Session Architecture
- **Forbidden:** `Session["UserId"]`, `Session["User"]`, `Session.Abandon()`.
- **Required:** Use [`AuthHelper.cs`](file:///WebApplication1/AuthHelper.cs):
  ```csharp
  // Read authenticated user
  var user = AuthHelper.GetCurrentUser(Request);
  if (user == null) {
      Response.Redirect("Signin.aspx");
      return;
  }
  int userId = user.UserId;

  // Set auth on login
  AuthHelper.SetAuthCookie(Response, userId, username, email);

  // Clear auth on logout
  AuthHelper.ClearAuthCookie(Response);
  ```

### Rule 2: Classroom Direct ADO.NET Pattern
Every code-behind page requiring database data must instantiate `SqlConnection`, `SqlCommand`, and `SqlDataReader`:
```csharp
SqlConnection cn = new SqlConnection(@"Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;");
SqlCommand co = new SqlCommand();
SqlDataReader ds;

protected void Page_Load(object sender, EventArgs e)
{
    if (cn.State == ConnectionState.Closed)
        cn.Open();
    co.Connection = cn;
}

// Reading rows:
co.CommandText = "select ... from [dbo].[table] where ...";
ds = co.ExecuteReader();
while (ds.Read())
{
    // access fields via ds["column_name"]
}
ds.Close();

// Non-query executions (insert / update / delete):
co.CommandText = "insert into [dbo].[table] ...";
co.ExecuteNonQuery();
```

### Rule 3: Landing Page Separation
- [`Landing.aspx`](file:///WebApplication1/Landing.aspx): High-conversion marketing showcase.
- [`Landing.aspx.cs`](file:///WebApplication1/Landing.aspx.cs): Must contain **ZERO** database connections or SQL queries. All game highlights and pricing tiers are presented via static design markup.
- Shared models (`GameItem`, `CategoryItem`, `FeatureItem`) live in [`Models.cs`](file:///WebApplication1/Models.cs).

### Rule 4: Navigation Bar Logic
- **Landing Navbar:** Displays `Sign In` (`btn-ghost`) and `Join Free` (`btn-primary-glow`).
- **Store Pages Navbar (`Home.aspx`, `Cart.aspx`, `Buy.aspx`, `Transactions.aspx`):**
  - **NEVER** render `Sign In` or `Join Free`.
  - Display gamertag chip, `Transactions` link, and dynamic Cart badge button (`#navCartBtn`).

---

## 🗄️ 4. SQL Server Schema Reference

| Table | Description | Key Columns |
|---|---|---|
| `[dbo].[user]` | Gamer accounts & login credentials | `id` (PK), `username` (UQ), `email` (UQ), `password` |
| `[dbo].[games]` | Catalog master (PC, PS5, Xbox, Switch) | `id` (PK), `game_code` (UQ), `title`, `buy_price`, `rent_price`, `platforms` |
| `[dbo].[cart]` | Active shopping carts per user | `id` (PK), `user_id` (FK), `game_code`, `license_type` ('buy'/'rent'), `price`, `quantity` |
| `[dbo].[orders]` | Customer orders & payment totals | `id` (PK), `order_number` (UQ), `user_id` (FK), `subtotal`, `discount`, `total_amount`, `order_status` |
| `[dbo].[order_items]` | Line items with generated digital keys | `id` (PK), `order_id` (FK), `game_title`, `license_type`, `price`, `activation_key` |
| `[dbo].[transaction_history]` | Payment audit log & receipts | `id` (PK), `transaction_id` (UQ), `order_id` (FK), `order_number`, `user_id` (FK), `amount`, `payment_method`, `payment_status` |
