<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="WebApplication1.Transactions" Theme="Gaming" %>
<%@ Register Src="~/Controls/SiteFooter.ascx" TagPrefix="uc" TagName="SiteFooter" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Transaction History | NEXUS PLAY Gaming Store</title>
    <meta name="description" content="View your digital purchases, activation key records, and payment history on Nexus Play." />
    <style>
        .txn-page-header {
            padding: 120px 0 40px;
            position: relative;
            z-index: 2;
        }
        .txn-title-wrapper {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 16px;
        }
        .txn-title-wrapper h1 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #fff;
            letter-spacing: -0.5px;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .txn-title-wrapper h1 svg {
            width: 32px;
            height: 32px;
            fill: var(--neon-cyan);
        }
        .txn-badge-count {
            background: rgba(0, 240, 255, 0.15);
            color: var(--neon-cyan);
            border: 1px solid rgba(0, 240, 255, 0.3);
            border-radius: 9999px;
            padding: 4px 14px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
        }
        .txn-card {
            background: rgba(18, 22, 38, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            backdrop-filter: blur(16px);
            padding: 24px;
            margin-bottom: 16px;
            transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            position: relative;
            overflow: hidden;
        }
        .txn-card:hover {
            border-color: rgba(0, 240, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4), 0 0 20px rgba(0, 240, 255, 0.08);
        }
        .txn-card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
            padding-bottom: 16px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.06);
            margin-bottom: 16px;
        }
        .txn-id-box {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .txn-id-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #8b9bb4;
        }
        .txn-id-code {
            font-family: 'JetBrains Mono', 'Fira Code', monospace;
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--neon-cyan);
        }
        .txn-order-code {
            font-family: 'JetBrains Mono', 'Fira Code', monospace;
            font-size: 0.9rem;
            color: #b0c0d8;
            background: rgba(255, 255, 255, 0.04);
            padding: 3px 8px;
            border-radius: 6px;
        }
        .txn-status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
        .txn-status-badge.Success::before {
            content: '';
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #10b981;
            box-shadow: 0 0 8px #10b981;
        }
        .txn-details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 16px;
        }
        .txn-detail-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .txn-detail-label {
            font-size: 0.75rem;
            color: #8b9bb4;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .txn-detail-value {
            font-size: 0.95rem;
            font-weight: 600;
            color: #e2e8f0;
        }
        .txn-amount-highlight {
            font-size: 1.3rem;
            font-weight: 800;
            color: #fff;
            text-shadow: 0 0 15px rgba(0, 240, 255, 0.3);
        }
        .txn-empty-state {
            text-align: center;
            padding: 80px 24px;
            background: rgba(18, 22, 38, 0.5);
            border: 1px dashed rgba(255, 255, 255, 0.12);
            border-radius: 20px;
        }
        .txn-empty-icon {
            width: 64px;
            height: 64px;
            fill: #4a5568;
            margin-bottom: 20px;
        }
        .txn-empty-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 8px;
        }
        .txn-empty-desc {
            color: #8b9bb4;
            max-width: 440px;
            margin: 0 auto 24px;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cyber-grid-overlay"></div>

        <!-- ==========================================
             STICKY TOP NAVBAR (DEDICATED STORE NAVBAR)
             ========================================== -->
        <nav class="navbar" id="mainNavbar">
            <div class="container nav-wrapper">
                <a href="Home.aspx" class="brand-logo" id="brandLogo">
                    <div class="brand-icon-box">
                        <svg viewBox="0 0 24 24">
                            <path d="M12 2L2 7l10 5 10-5-10-5zm0 9l-8.5-4.25L2 7.5 12 13l10-5.5-1.5-.75L12 11zm0 4.5l-7-3.5-1.5.75 8.5 4.75 8.5-4.75-1.5-.75-7 3.5z" />
                        </svg>
                    </div>
                    <span class="brand-name">NEXUS<span style="color: var(--neon-cyan);">PLAY</span></span>
                </a>

                <ul class="nav-links">
                    <li><a href="Home.aspx" class="nav-link">Store Home</a></li>
                    <li><a href="Home.aspx#featuredGames" class="nav-link">Browse Games</a></li>
                    <li><a href="Cart.aspx" class="nav-link">My Cart</a></li>
                    <li><a href="Transactions.aspx" class="nav-link" style="color: var(--neon-cyan);">Transaction History</a></li>
                </ul>

                <div class="nav-actions">
                    <a href="Cart.aspx" class="nav-cart-btn">
                        <svg viewBox="0 0 24 24">
                            <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                        </svg>
                        <span>Cart</span>
                        <span class="cart-count-badge <%= CartBadgeCssClass %>" id="cartCountBadge"><asp:Literal ID="litNavCartCount" runat="server" Text="0" /></span>
                    </a>

                    <div class="user-profile-badge">
                        <span class="user-avatar-icon">
                            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor">
                                <path d="M21 6H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-10 7H8v3H6v-3H3v-2h3V8h2v3h3v2zm4.5 2c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm4-3c-.83 0-1.5-.67-1.5-1.5S18.67 9 19.5 9s1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/>
                            </svg>
                        </span>
                        <span class="user-name-text"><asp:Literal ID="litNavUsername" runat="server" Text="Gamer" /></span>
                        <a href="Signin.aspx?action=logout" class="signout-link" title="Sign out of account">Sign Out</a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- ==========================================
             TRANSACTIONS MAIN CONTENT
             ========================================== -->
        <main class="txn-page-header">
            <div class="container" style="max-width: 900px;">
                <div class="txn-title-wrapper">
                    <div>
                        <span class="section-pretitle" style="color: var(--neon-cyan); font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1.5px; font-weight: 700;">Account Activity</span>
                        <h1>
                            <svg viewBox="0 0 24 24">
                                <path d="M19 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-2 10h-4v4h-2v-4H7v-2h4V7h2v4h4v2z"/>
                            </svg>
                            Transaction History
                        </h1>
                    </div>
                    <span class="txn-badge-count"><asp:Literal ID="litTxnCount" runat="server" Text="0" /> Records</span>
                </div>

                <!-- Empty State -->
                <asp:Panel ID="pnlNoTransactions" runat="server" Visible="false">
                    <div class="txn-empty-state">
                        <svg class="txn-empty-icon" viewBox="0 0 24 24">
                            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"/>
                        </svg>
                        <h2 class="txn-empty-title">No Transactions Found</h2>
                        <p class="txn-empty-desc">You haven't completed any game purchases or rental passes yet. Browse the catalog to start gaming!</p>
                        <a href="Home.aspx#featuredGames" class="btn-primary" style="display: inline-block; padding: 12px 28px; text-decoration: none; border-radius: 10px; font-weight: 700;">Browse Game Store</a>
                    </div>
                </asp:Panel>

                <!-- Transactions List -->
                <asp:Panel ID="pnlTransactionsList" runat="server">
                    <asp:Repeater ID="rptTransactions" runat="server">
                        <ItemTemplate>
                            <div class="txn-card">
                                <div class="txn-card-top">
                                    <div class="txn-id-box">
                                        <span class="txn-id-label">Txn ID</span>
                                        <span class="txn-id-code"><%# Eval("transaction_id") %></span>
                                        <span class="txn-order-code"><%# Eval("order_number") %></span>
                                    </div>
                                    <span class="txn-status-badge <%# Eval("payment_status") %>">
                                        <%# Eval("payment_status") %>
                                    </span>
                                </div>
                                <div class="txn-details-grid">
                                    <div class="txn-detail-item">
                                        <span class="txn-detail-label">Amount Paid</span>
                                        <span class="txn-detail-value txn-amount-highlight">$<%# Convert.ToDecimal(Eval("amount")).ToString("F2") %></span>
                                    </div>
                                    <div class="txn-detail-item">
                                        <span class="txn-detail-label">Payment Method</span>
                                        <span class="txn-detail-value" style="text-transform: capitalize;">
                                            <%# Eval("payment_method") %> <%# !string.IsNullOrEmpty(Eval("card_last4")?.ToString()) && Eval("card_last4").ToString() != "N/A" ? "(**** " + Eval("card_last4") + ")" : "" %>
                                        </span>
                                    </div>
                                    <div class="txn-detail-item">
                                        <span class="txn-detail-label">Platform</span>
                                        <span class="txn-detail-value"><%# Eval("target_platform") %></span>
                                    </div>
                                    <div class="txn-detail-item">
                                        <span class="txn-detail-label">Items</span>
                                        <span class="txn-detail-value"><%# Eval("item_count") %> Game(s)</span>
                                    </div>
                                    <div class="txn-detail-item">
                                        <span class="txn-detail-label">Date & Time</span>
                                        <span class="txn-detail-value"><%# Convert.ToDateTime(Eval("created_at")).ToString("MMM dd, yyyy HH:mm") %></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </asp:Panel>
            </div>
        </main>

        <uc:SiteFooter ID="ucFooter" runat="server" />
    </form>
</body>
</html>
