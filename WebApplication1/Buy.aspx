<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Buy.aspx.cs" Inherits="WebApplication1.Buy" Theme="Gaming" %>
<%@ Register Src="~/Controls/SiteFooter.ascx" TagPrefix="uc" TagName="SiteFooter" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Complete Purchase | NEXUS PLAY Gaming Store</title>
    <meta name="description" content="Secure digital checkout. Choose your gaming platform, complete purchase, and receive instant DRM activation keys." />
    <script src="js/cart.js" defer></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cyber-grid-overlay"></div>

        <!-- Sticky Top Navbar -->
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
                    <li><a href="Cart.aspx" class="nav-link">Shopping Cart</a></li>
                </ul>

                <div class="nav-actions">
                    <a href="Cart.aspx" class="nav-cart-btn">
                        <svg viewBox="0 0 24 24">
                            <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                        </svg>
                        <span>Cart</span>
                        <span class="cart-count-badge <%= CartBadgeCssClass %>" id="cartCountBadge"><asp:Literal ID="litNavCartCount" runat="server" Text="0" /></span>
                    </a>

                    <!-- User Account Badge -->
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

        <main class="container">
            <!-- ==========================================
                 CHECKOUT FORM PANEL (Active during checkout)
                 ========================================== -->
            <asp:Panel ID="pnlCheckoutForm" runat="server">
                <div class="checkout-header">
                    <div class="cart-breadcrumbs">
                        <a href="Home.aspx">&larr; Back to Store</a>
                        <span>/</span>
                        <a href="Cart.aspx">Cart</a>
                        <span>/</span>
                        <span style="color: var(--neon-cyan);">Checkout &amp; Buy</span>
                    </div>
                    <h1 class="checkout-title">Review &amp; Complete Purchase</h1>
                </div>

                <asp:HiddenField ID="hfSelectedPayment" runat="server" Value="card" />

                <div class="checkout-grid">
                    <!-- Left: Form Steps -->
                    <div class="checkout-steps-panel">
                        <!-- Step 1: Customer & Delivery Details -->
                        <div class="checkout-step-card">
                            <div class="step-title-row">
                                <div class="step-num-badge">1</div>
                                <h2 class="step-heading">Delivery &amp; Account Details</h2>
                            </div>

                            <div style="display: flex; flex-direction: column; gap: 1.25rem;">
                                <div class="store-input-group">
                                    <label class="store-input-label" for="txtDeliveryEmail">Delivery Email</label>
                                    <div class="store-input-wrapper">
                                        <div class="store-input-icon">
                                            <svg viewBox="0 0 24 24"><path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>
                                        </div>
                                        <asp:TextBox ID="txtDeliveryEmail" runat="server" CssClass="store-input-field" />
                                    </div>
                                    <span style="font-size: 0.78rem; color: var(--text-muted); margin-top: 0.25rem;">Digital keys will be registered to this account and displayed immediately after checkout.</span>
                                </div>

                                <div class="store-input-group">
                                    <label class="store-input-label" for="ddlPlatform">Target Activation Platform</label>
                                    <asp:DropDownList ID="ddlPlatform" runat="server" CssClass="store-input-field" 
                                        style="background: rgba(18, 22, 36, 0.7); border: 1px solid var(--border-subtle); border-radius: 8px; padding: 0.75rem 1rem;">
                                        <asp:ListItem Value="Steam (PC)" Selected="True">Steam (PC)</asp:ListItem>
                                        <asp:ListItem Value="Epic Games Store (PC)">Epic Games Store (PC)</asp:ListItem>
                                        <asp:ListItem Value="PlayStation 5 (PSN)">PlayStation 5 (PSN Key)</asp:ListItem>
                                        <asp:ListItem Value="Xbox Series X|S">Xbox Series X|S (Xbox Live)</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <!-- Step 2: Payment Method -->
                        <div class="checkout-step-card">
                            <div class="step-title-row">
                                <div class="step-num-badge">2</div>
                                <h2 class="step-heading">Payment Method</h2>
                            </div>

                            <div class="payment-methods-grid">
                                <div class="payment-method-card active" id="payMethodCard" onclick="selectPayment('card', this)">
                                    <svg viewBox="0 0 24 24"><path d="M20 4H4c-1.11 0-1.99.89-1.99 2L2 18c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z"/></svg>
                                    <div class="payment-method-name">Credit / Debit Card</div>
                                    <div class="payment-method-sub">Visa &bull; Mastercard</div>
                                </div>

                                <div class="payment-method-card" id="payMethodWallet" onclick="selectPayment('wallet', this)">
                                    <svg viewBox="0 0 24 24"><path d="M21 18v1c0 1.1-.9 2-2 2H5c-1.11 0-2-.9-2-2V5c0-1.1.89-2 2-2h14c1.1 0 2 .9 2 2v1h-9c-1.11 0-2 .9-2 2v8c0 1.1.89 2 2 2h9zm-9-2h10V8H12v8zm4-2.5c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/></svg>
                                    <div class="payment-method-name">Nexus Wallet</div>
                                    <div class="payment-method-sub" style="color: var(--neon-cyan);">$150.00 Credit</div>
                                </div>

                                <div class="payment-method-card" id="payMethodPaypal" onclick="selectPayment('paypal', this)">
                                    <svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14H9V8h2v8zm4 0h-2V8h2v8z"/></svg>
                                    <div class="payment-method-name">PayPal / UPI</div>
                                    <div class="payment-method-sub">Instant Checkout</div>
                                </div>
                            </div>

                            <!-- Card Inputs Section -->
                            <div id="cardFieldsSection" style="display: flex; flex-direction: column; gap: 1rem;">
                                <div class="store-input-group">
                                    <label class="store-input-label">Card Number</label>
                                    <div class="store-input-wrapper">
                                        <input type="text" class="store-input-field" placeholder="4532 &bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull; 8921" value="4532 8920 1142 8921" />
                                    </div>
                                </div>

                                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                                    <div class="store-input-group">
                                        <label class="store-input-label">Expires</label>
                                        <div class="store-input-wrapper">
                                            <input type="text" class="store-input-field" placeholder="MM/YY" value="08/29" />
                                        </div>
                                    </div>
                                    <div class="store-input-group">
                                        <label class="store-input-label">Security CVC</label>
                                        <div class="store-input-wrapper">
                                            <input type="password" class="store-input-field" placeholder="CVC" value="774" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Step 3: Terms & Agreement -->
                        <div class="checkout-step-card" style="padding: 1.5rem 2rem;">
                            <label style="display: flex; align-items: flex-start; gap: 0.75rem; cursor: pointer; font-size: 0.88rem; color: #cbd5e1;">
                                <asp:CheckBox ID="chkAgree" runat="server" Checked="true" style="margin-top: 3px;" />
                                <span>I agree to the Digital Software License Agreement and acknowledge that official publisher activation keys will be delivered immediately and cannot be refunded once revealed.</span>
                            </label>
                        </div>
                    </div>

                    <!-- Right: Order Summary Box -->
                    <aside class="cart-summary-box">
                        <h2 class="summary-title">Items in Order</h2>

                        <!-- Single Direct Item View (if id in query string) -->
                        <asp:PlaceHolder ID="phSingleItem" runat="server" Visible="false">
                            <div class="cart-item-card" style="padding: 0.75rem; margin-bottom: 1.25rem;">
                                <asp:Image ID="imgSingleGame" runat="server" CssClass="cart-item-img" style="width: 70px; height: 42px;" />
                                <div class="cart-item-details">
                                    <div style="font-weight: 700; color: #fff; font-size: 0.95rem;">
                                        <asp:Literal ID="litSingleTitle" runat="server" />
                                    </div>
                                    <div class="cart-item-meta" style="margin-top: 2px;">
                                        <asp:Label ID="lblSingleTypeBadge" runat="server" CssClass="badge-license-buy" />
                                        <span class="cart-item-platform"><asp:Literal ID="litSinglePlatform" runat="server" /></span>
                                    </div>
                                </div>
                                <div style="font-family: var(--font-subdisplay); font-size: 1.15rem; font-weight: 700; color: #fff;">
                                    $<asp:Literal ID="litSinglePrice" runat="server" />
                                </div>
                            </div>
                        </asp:PlaceHolder>

                        <!-- Cart Multi-Items View (loaded directly from SQL Server [dbo].[cart]) -->
                        <asp:PlaceHolder ID="phCartItems" runat="server" Visible="false">
                            <div style="margin-bottom: 1.25rem;">
                                <asp:Repeater ID="rptCartSummary" runat="server">
                                    <ItemTemplate>
                                        <div class="cart-item-card" style="padding: 0.6rem 0.75rem; margin-bottom: 0.5rem;">
                                            <div class="cart-item-details">
                                                <div style="font-weight: 700; color: #fff; font-size: 0.9rem;">
                                                    <%# Eval("title") %> (x<%# Eval("quantity") %>)
                                                </div>
                                                <div class="cart-item-meta" style="margin-top: 2px;">
                                                    <span class='<%# string.Equals(Eval("license_type").ToString(), "Rent", StringComparison.OrdinalIgnoreCase) ? "badge-license-rent" : "badge-license-buy" %>'>
                                                        <%# string.Equals(Eval("license_type").ToString(), "Rent", StringComparison.OrdinalIgnoreCase) ? "Rent" : "Permanent" %>
                                                    </span>
                                                    <span class="cart-item-platform"><%# Eval("platform") %></span>
                                                </div>
                                            </div>
                                            <div style="font-family: var(--font-subdisplay); font-size: 1.1rem; font-weight: 700; color: #fff;">
                                                $<%# string.Format("{0:F2}", Convert.ToDecimal(Eval("price")) * Convert.ToInt32(Eval("quantity"))) %>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:PlaceHolder>

                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span style="font-weight: 700; color: #fff;">
                                $<asp:Literal ID="litSubtotal" runat="server">0.00</asp:Literal>
                            </span>
                        </div>

                        <div class="summary-row">
                            <span>Instant Digital Delivery</span>
                            <span style="color: var(--neon-cyan); font-weight: 600;">$0.00 (Instant)</span>
                        </div>

                        <asp:Panel ID="pnlDiscountRow" runat="server" Visible="false" CssClass="summary-row" style="color: var(--neon-pink);">
                            <span>Discount</span>
                            <asp:Literal ID="litDiscount" runat="server" Text="-$0.00" />
                        </asp:Panel>

                        <div class="summary-row total-row">
                            <span>Total Due</span>
                            <span class="total-amount">
                                $<asp:Literal ID="litTotal" runat="server">0.00</asp:Literal>
                            </span>
                        </div>

                        <asp:Button ID="btnConfirmPurchase" runat="server" 
                            Text="Confirm Purchase & Claim Keys" 
                            CssClass="btn-primary-glow btn-large w-100" 
                            style="margin-top: 1.5rem; cursor: pointer;"
                            OnClick="btnConfirmPurchase_Click" />

                        <div class="trust-badges-list">
                            <div class="trust-badge-item">
                                <svg viewBox="0 0 24 24"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z"/></svg>
                                <span>Official Verified Publisher Key</span>
                            </div>
                            <div class="trust-badge-item">
                                <svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14H9V8h2v8zm4 0h-2V8h2v8z"/></svg>
                                <span>100% Rent-to-Own Credit Protection</span>
                            </div>
                        </div>
                    </aside>
                </div>
            </asp:Panel>

            <!-- ==========================================
                 ORDER CONFIRMATION SUCCESS VIEW
                 ========================================== -->
            <asp:Panel ID="pnlOrderSuccess" runat="server" Visible="false">
                <div class="order-success-card">
                    <div class="order-success-icon">
                        <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                    </div>

                    <h1 class="order-success-title">Order Completed Successfully!</h1>
                    <p style="color: var(--text-muted); font-size: 1.05rem; margin-bottom: 1rem;">
                        Your digital license keys have been generated and recorded in your account: <strong style="color: var(--neon-cyan);"><asp:Literal ID="litSuccessEmail" runat="server" /></strong>.
                    </p>

                    <div class="order-ref-pill">
                        Order Reference: <asp:Literal ID="litOrderId" runat="server">#NX-984102</asp:Literal>
                    </div>

                    <!-- List of Generated Activation Keys -->
                    <div class="activation-keys-list">
                        <asp:Repeater ID="rptKeys" runat="server">
                            <ItemTemplate>
                                <div class="key-box-row">
                                    <div>
                                        <div class="key-game-title"><%# Eval("Title") %></div>
                                        <div class="key-game-meta">
                                            Platform: <strong><%# Eval("Platform") %></strong> &bull; 
                                            License: <span style="color: var(--neon-cyan);"><%# Eval("LicenseType") %></span>
                                        </div>
                                    </div>
                                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                                        <span class="digital-key-display" id='key_<%# Container.ItemIndex %>'><%# Eval("Key") %></span>
                                        <button type="button" class="copy-key-btn" onclick="copyKey('key_<%# Container.ItemIndex %>');">Copy</button>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Instructions -->
                    <div style="background: rgba(0,0,0,0.4); border: 1px solid var(--border-subtle); border-radius: 12px; padding: 1.5rem; text-align: left; margin-bottom: 2rem;">
                        <h3 style="font-family: var(--font-display); font-size: 1rem; color: #fff; margin-bottom: 0.5rem;">How to Activate Your Game</h3>
                        <ol style="margin-left: 1.25rem; font-size: 0.88rem; color: var(--text-muted); line-height: 1.7;">
                            <li>Open your selected platform client (e.g. Steam, Epic Games Launcher, PlayStation Store, or Xbox Guide).</li>
                            <li>Navigate to <strong>Games &rarr; Activate a Product on Steam</strong> or <strong>Redeem Code</strong>.</li>
                            <li>Paste the digital key shown above and click Confirm. Your game will begin downloading immediately!</li>
                        </ol>
                    </div>

                    <a href="Home.aspx" class="btn-primary-glow btn-large">
                        &larr; Return to Store Home
                    </a>
                </div>
            </asp:Panel>
        </main>

        <!-- Reusable Site Footer -->
        <uc:SiteFooter ID="siteFooter" runat="server" />
    </form>

    <script>
        function selectPayment(type, el) {
            document.querySelectorAll('.payment-method-card').forEach(function (card) {
                card.classList.remove('active');
            });
            el.classList.add('active');
            var hf = document.getElementById('<%= hfSelectedPayment.ClientID %>');
            if (hf) hf.value = type;

            var cardSection = document.getElementById('cardFieldsSection');
            if (cardSection) {
                cardSection.style.display = type === 'card' ? 'flex' : 'none';
            }
        }

        function copyKey(elementId) {
            var el = document.getElementById(elementId);
            if (el) {
                navigator.clipboard.writeText(el.innerText || el.textContent).then(function () {
                    NexusCart.showToast('Key Copied', 'Activation key copied to clipboard!');
                });
            }
        }
    </script>
</body>
</html>
