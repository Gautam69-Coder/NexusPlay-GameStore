<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="WebApplication1.Cart" Theme="Gaming" %>
<%@ Register Src="~/Controls/SiteFooter.ascx" TagPrefix="uc" TagName="SiteFooter" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Shopping Cart | NEXUS PLAY Gaming Store</title>
    <meta name="description" content="Review your digital game keys and rentals before checkout. 100% official publisher licenses with instant key delivery." />
    <script src="js/cart.js" defer></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cyber-grid-overlay"></div>

        <!-- ==========================================
             STICKY TOP NAVBAR (DEDICATED STORE NAVBAR)
             ========================================== -->
        <nav class="navbar" id="mainNavbar">
            <div class="container nav-wrapper">
                <!-- Brand Logo -->
                <a href="Home.aspx" class="brand-logo" id="brandLogo">
                    <div class="brand-icon-box">
                        <svg viewBox="0 0 24 24">
                            <path d="M12 2L2 7l10 5 10-5-10-5zm0 9l-8.5-4.25L2 7.5 12 13l10-5.5-1.5-.75L12 11zm0 4.5l-7-3.5-1.5.75 8.5 4.75 8.5-4.75-1.5-.75-7 3.5z" />
                        </svg>
                    </div>
                    <span class="brand-name">NEXUS<span style="color: var(--neon-cyan);">PLAY</span></span>
                </a>

                <!-- Navigation Links -->
                <ul class="nav-links">
                    <li><a href="Home.aspx" class="nav-link">Store Home</a></li>
                    <li><a href="Home.aspx#featuredGames" class="nav-link">Browse Games</a></li>
                    <li><a href="Transactions.aspx" class="nav-link">Transactions</a></li>
                    <li><a href="Home.aspx#subscription" class="nav-link">Rental Passes</a></li>
                </ul>

                <!-- Action CTAs -->
                <div class="nav-actions">
                    <a href="Cart.aspx" class="nav-cart-btn" style="border-color: var(--neon-cyan); background: rgba(0, 240, 255, 0.15);">
                        <svg viewBox="0 0 24 24">
                            <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                        </svg>
                        <span>Cart</span>
                        <span class="cart-count-badge <%= CartBadgeCssClass %>" id="cartCountBadge"><asp:Literal ID="litNavCartCount" runat="server" Text="0" /></span>
                    </a>

                    <!-- User Account Badge (No Sign In or Join Free on Store pages) -->
                    <div class="user-profile-badge">
                        <span class="user-avatar-icon">
                            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor">
                                <path d="M21 6H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-10 7H8v3H6v-3H3v-2h3V8h2v3h3v2zm4.5 2c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm4-3c-.83 0-1.5-.67-1.5-1.5S18.67 9 19.5 9s1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/>
                            </svg>
                        </span>
                        <span class="user-display-name"><asp:Literal ID="litNavUsername" runat="server" /></span>
                    </div>
                    <asp:HyperLink ID="lnkSignOut" runat="server" NavigateUrl="Signin.aspx?action=logout" CssClass="btn-ghost btn-sm" Text="Sign Out" />
                </div>
            </div>
        </nav>

        <!-- ==========================================
             CART PAGE CONTENT
             ========================================== -->
        <main class="container">
            <div class="cart-header-section">
                <div class="cart-breadcrumbs">
                    <a href="Home.aspx">&larr; Back to Store</a>
                    <span>/</span>
                    <span style="color: var(--neon-cyan);">Shopping Cart</span>
                </div>
                <h1 class="cart-page-title">
                    Your Gaming Cart (<asp:Literal ID="litHeaderCount" runat="server" Text="0" /> Items)
                </h1>
            </div>

            <!-- Active Cart Layout (Rendered from SQL Server) -->
            <asp:Panel ID="pnlActiveCart" runat="server" CssClass="cart-grid-layout">
                <!-- Left: Cart Items List -->
                <div class="cart-items-panel">
                    <div id="cartItemList">
                        <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                            <ItemTemplate>
                                <div class="cart-item-card">
                                    <img src='<%# Eval("image_url") != DBNull.Value && !string.IsNullOrEmpty(Eval("image_url").ToString()) ? Eval("image_url") : "images/hero-banner.jpg" %>' 
                                         alt='<%# Eval("title") %>' class="cart-item-img" />
                                    
                                    <div class="cart-item-details">
                                        <h3 class="cart-item-title"><%# Eval("title") %></h3>
                                        <div class="cart-item-meta">
                                            <span class='<%# string.Equals(Eval("license_type").ToString(), "Rent", StringComparison.OrdinalIgnoreCase) ? "badge-license-rent" : "badge-license-buy" %>'>
                                                <%# string.Equals(Eval("license_type").ToString(), "Rent", StringComparison.OrdinalIgnoreCase) ? "7-Day Rental Pass" : "Permanent DRM Key" %>
                                            </span>
                                            <span class="cart-item-platform"><%# Eval("platform") %></span>
                                        </div>
                                    </div>

                                    <!-- Stepper Quantity Control -->
                                    <div class="qty-stepper">
                                        <asp:LinkButton ID="btnDec" runat="server" CommandName="dec" CommandArgument='<%# Eval("id") %>' CssClass="qty-btn">&minus;</asp:LinkButton>
                                        <span class="qty-val"><%# Eval("quantity") %></span>
                                        <asp:LinkButton ID="btnInc" runat="server" CommandName="inc" CommandArgument='<%# Eval("id") %>' CssClass="qty-btn">&plus;</asp:LinkButton>
                                    </div>

                                    <div class="cart-item-pricing">
                                        <div class="cart-item-unit-price">$<%# string.Format("{0:F2}", Convert.ToDecimal(Eval("price")) * Convert.ToInt32(Eval("quantity"))) %></div>
                                        <div class="cart-item-subtotal-label">$<%# string.Format("{0:F2}", Eval("price")) %> each</div>
                                    </div>

                                    <asp:LinkButton ID="btnRemove" runat="server" CommandName="del" CommandArgument='<%# Eval("id") %>' CssClass="btn-remove-item" ToolTip="Remove Item">
                                        <svg viewBox="0 0 24 24"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/></svg>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Bottom Bar -->
                    <div class="cart-actions-bar">
                        <a href="Home.aspx#featuredGames" class="btn-ghost btn-sm" style="display: inline-flex; align-items: center; gap: 0.4rem;">
                            &larr; Continue Shopping
                        </a>
                        <asp:LinkButton ID="btnClearCart" runat="server" CssClass="btn-ghost btn-sm" style="color: #ef4444;" OnClick="btnClearCart_Click" OnClientClick="return confirm('Are you sure you want to clear your cart?');">
                            Clear Cart
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Right: Sticky Order Summary Box -->
                <aside class="cart-summary-box">
                    <h2 class="summary-title">Order Summary</h2>

                    <div class="summary-row">
                        <span>Items Subtotal</span>
                        <span style="font-weight: 700; color: #fff;"><asp:Literal ID="litSubtotal" runat="server" Text="$0.00" /></span>
                    </div>

                    <div class="summary-row">
                        <span>Estimated Tax</span>
                        <span style="color: var(--neon-green); font-weight: 600;">$0.00 (Included)</span>
                    </div>

                    <div class="summary-row">
                        <span>Digital Key Delivery</span>
                        <span style="color: var(--neon-cyan); font-weight: 600;">Instant (Free)</span>
                    </div>

                    <asp:Panel ID="pnlDiscountRow" runat="server" Visible="false" CssClass="summary-row" style="color: var(--neon-pink);">
                        <span>Promo Code Discount (10%)</span>
                        <asp:Literal ID="litDiscount" runat="server" Text="-$0.00" />
                    </asp:Panel>

                    <!-- Promo Code Box -->
                    <div class="promo-box">
                        <asp:TextBox ID="txtPromo" runat="server" CssClass="promo-input" placeholder="Promo code (try: NEXUS10)" />
                        <asp:Button ID="btnApplyPromo" runat="server" CssClass="promo-btn" Text="Apply" OnClick="btnApplyPromo_Click" />
                    </div>
                    <asp:Label ID="lblPromoFeedback" runat="server" Visible="false" style="font-size: 0.8rem; margin-top: -0.5rem; margin-bottom: 0.75rem; display: block;" />

                    <div class="summary-row total-row">
                        <span>Grand Total</span>
                        <span class="total-amount"><asp:Literal ID="litGrandTotal" runat="server" Text="$0.00" /></span>
                    </div>

                    <!-- Proceed to Buy Button -->
                    <asp:HyperLink ID="btnProceedToBuy" runat="server" NavigateUrl="Buy.aspx?source=cart" CssClass="btn-primary-glow btn-large w-100" style="margin-top: 1.5rem; text-align: center; display: block;">
                        Proceed to Buy &rarr;
                    </asp:HyperLink>

                    <!-- Security & Trust Badges -->
                    <div class="trust-badges-list">
                        <div class="trust-badge-item">
                            <svg viewBox="0 0 24 24"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z"/></svg>
                            <span>Official Publisher Authorized DRM Keys</span>
                        </div>
                        <div class="trust-badge-item">
                            <svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>
                            <span>100% Rent-to-Own Credit Rollover</span>
                        </div>
                        <div class="trust-badge-item">
                            <svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14H9V8h2v8zm4 0h-2V8h2v8z"/></svg>
                            <span>Instant Delivery to your Game Library</span>
                        </div>
                    </div>
                </aside>
            </asp:Panel>

            <!-- Empty Cart Layout (Shown when SQL cart has 0 items) -->
            <asp:Panel ID="pnlEmptyCart" runat="server" CssClass="empty-cart-card" Visible="false">
                <div class="empty-cart-icon-box">
                    <svg viewBox="0 0 24 24">
                        <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                    </svg>
                </div>
                <h2 class="empty-cart-title">Your Gaming Cart is Empty</h2>
                <p class="empty-cart-desc">
                    You haven't added any games or rental passes to your cart yet. Explore our curated store catalog to discover top blockbuster deals and rental discounts.
                </p>
                <a href="Home.aspx#featuredGames" class="btn-primary-glow btn-large">
                    Explore Store Catalog &rarr;
                </a>
            </asp:Panel>
        </main>

        <!-- Reusable Site Footer -->
        <uc:SiteFooter ID="siteFooter" runat="server" />
    </form>
</body>
</html>
