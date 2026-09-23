# 🤖 AI Agent Clone & Instruction Prompt

> Copy and paste the prompt below directly into any AI assistant or coding agent (such as **ChatGPT**, **Claude**, **Cursor**, **GitHub Copilot**, **Antigravity**, **Devin**, or **Windsurf**) when asking it to clone, understand, or extend this project.

---

## 📋 Copy-Paste Prompt for AI Agents

```text
I am cloning the NEXUSPLAY Game Store repository (https://github.com/Gautam69-Coder/NexusPlay-GameStore).

Please inspect the codebase and follow these strict repository rules and guidelines:

1. ARCHITECTURE & TECH STACK:
   - Framework: ASP.NET Web Forms (.NET Framework 4.8.1) in C# 12.
   - Database: Microsoft SQL Server (`GameStore` database on `.\SQLEXPRESS01`).
   - Data Access: Direct ADO.NET (`SqlConnection cn`, `SqlCommand co`, `SqlDataReader ds`, `ds = co.ExecuteReader()`). Do NOT use Entity Framework, Dapper, or any ORM.
   - Auth: Zero Session Architecture. NEVER use `Session[...]`. User authentication and session state are managed strictly via HTTP-only encrypted cookies using `AuthHelper.cs` (`NexusUser` cookie).

2. DATABASE SETUP:
   - Schema and seed files are in `Database/`:
     * Run `Database\setup_database.sql` to create `GameStore` and all 6 tables: `user`, `games`, `cart`, `orders`, `order_items`, and `transaction_history`.
     * Or run `Database\schema.sql` (DDL) and `Database\seed.sql` (Seed data).

3. PAGE RESPONSIBILITIES & NAVBAR RULES:
   - `Landing.aspx`: Pure presentation marketing page. `Landing.aspx.cs` must NOT contain database connections or SQL queries. Its navbar shows "Sign In" and "Join Free".
   - Store Pages (`Home.aspx`, `Cart.aspx`, `Buy.aspx`, `Transactions.aspx`): Functional ecommerce store pages. Their navbar MUST NEVER show "Sign In" or "Join Free"; they display gamer tag, cart count badge, and transaction history.
   - Shared entities (`GameItem`, `CategoryItem`, `FeatureItem`) live in `Models.cs`.

4. STYLING:
   - ASP.NET Theme `Gaming` in `App_Themes/Gaming/theme.css` and `Controls.skin`.
   - Maintain the cyberpunk dark glassmorphism design system (neon cyan `#00f0ff`, neon purple `#9d4edd`, neon pink `#ff007f`).

Refer to `AGENTS.md` and `README.md` for complete command lines and architectural details.
```

---

## ⚡ Quick Verification Commands for Agents

### Initialize Database:
```powershell
sqlcmd -S .\SQLEXPRESS01 -i Database\setup_database.sql
```

### Build with MSBuild:
```powershell
& "C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\MSBuild.exe" "WebApplication1\WebApplication1.csproj" /t:Build /p:Configuration=Debug
```

### Run on IIS Express:
```powershell
& "C:\Program Files\IIS Express\iisexpress.exe" /path:"c:\Users\vishn\source\repos\WebApplication1\WebApplication1" /port:52149
```
