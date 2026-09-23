<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication1.Home" MaintainScrollPositionOnPostback="true" Theme="Gaming" %>
<%@ Register Src="~/Controls/SiteFooter.ascx" TagPrefix="uc" TagName="SiteFooter" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NEXUS PLAY | Official Game Store — Buy, Rent & Play</title>
    <meta name="description" content="Discover 1,500+ digital blockbuster games. Buy permanent keys or rent with instant delivery to Steam, Epic, PS5, and Xbox." />
    <script src="js/cart.js" defer></script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Animated Cyber Grid Overlay -->
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

                <!-- Dedicated Store Navigation Links (No Landing Page Anchor Links) -->
                <ul class="nav-links">
                    <li><a href="#featuredGames" class="nav-link" style="color: var(--neon-cyan);">Browse Games</a></li>
                    <li><a href="#categoryTabs" class="nav-link">Categories</a></li>
                    <li><a href="Transactions.aspx" class="nav-link">Transactions</a></li>
                    <li><a href="#subscription" class="nav-link">Rental Passes</a></li>
                </ul>

                <!-- Action CTAs -->
                <div class="nav-actions">
                    <!-- Live Cart Button with Instant Badge -->
                    <a href="Cart.aspx" class="nav-cart-btn" id="navCartBtn" title="View Your Shopping Cart">
                        <svg viewBox="0 0 24 24">
                            <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
                        </svg>
                        <span>Cart</span>
                        <span class="cart-count-badge <%= CartBadgeCssClass %>" id="cartCountBadge"><asp:Literal ID="litCartCount" runat="server" Text="0" /></span>
                    </a>

                    <!-- User Account CTAs (No Sign In or Join Free on Home) -->
                    <div class="user-profile-badge">
                        <span class="user-avatar-icon">
                            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor">
                                <path d="M21 6H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-10 7H8v3H6v-3H3v-2h3V8h2v3h3v2zm4.5 2c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm4-3c-.83 0-1.5-.67-1.5-1.5S18.67 9 19.5 9s1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/>
                            </svg>
                        </span>
                        <span class="user-display-name"><asp:Literal ID="litUsername" runat="server" /></span>
                    </div>
                    <asp:HyperLink ID="lnkSignOut" runat="server" NavigateUrl="Signin.aspx?action=logout" CssClass="btn-ghost btn-sm" Text="Sign Out" />
                </div>
            </div>
        </nav>

        <!-- ==========================================
             GAMER STORE DASHBOARD HERO SECTION
             ========================================== -->
        <section class="hero-section">
            <div class="container hero-grid">
                <div class="hero-content">
                    <div class="hero-badge-tag">
                        <span class="sparkle">&#9889;</span>
                        <span>NEXUS GAMER PORTAL &bull; OFFICIAL STORE PORTAL</span>
                    </div>

                    <h1 class="hero-title">
                        Welcome Back, <br />
                        <span class="gradient-text-cyan"><asp:Literal ID="litHeroUser" runat="server" Text="Gamer" /></span>
                    </h1>

                    <p class="hero-description">
                        Access your official digital keys, exclusive rental passes, and 100% rent-to-own credit on 1,500+ top titles. Instant delivery to your Steam, Epic, and Console accounts.
                    </p>

                    <div class="hero-features-chips">
                        <div class="feature-chip">
                            <svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 14.5v-9l6 4.5-6 4.5z"/></svg>
                            Instant Delivery
                        </div>
                        <div class="feature-chip">
                            <svg viewBox="0 0 24 24"><path d="M19.35 10.04C18.67 6.59 15.64 4 12 4 9.11 4 6.6 5.64 5.35 8.04 2.34 8.36 0 10.91 0 14c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96z"/></svg>
                            Rent from $2.99
                        </div>
                        <div class="feature-chip">
                            <svg viewBox="0 0 24 24"><path d="M21 6H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-10 7H8v3H6v-3H3v-2h3V8h2v3h3v2zm4.5 2c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm4-3c-.83 0-1.5-.67-1.5-1.5S18.67 9 19.5 9s1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/></svg>
                            100% Rent-to-Own
                        </div>
                    </div>

                    <div class="hero-cta-group">
                        <a href="#featuredGames" class="btn-primary-glow btn-large">Browse Game Catalog</a>
                        <a href="Cart.aspx" class="btn-secondary-glow btn-large">Open Shopping Cart</a>
                    </div>
                </div>

                <!-- Right Spotlight Artwork -->
                <div class="hero-art-card">
                    <img src="images/hero-banner.jpg" alt="Featured Blockbuster" class="hero-image" />
                    <div class="hero-art-overlay">
                        <div class="hero-art-badge-top">
                            <span class="status-dot-pulse"></span>
                            <span>SPOTLIGHT TITLE</span>
                        </div>
                        <div class="hero-featured-info">
                            <h3>Cyberstorm: Neon War</h3>
                            <p>Special Publisher Discount &bull; 9.8 Critic Score</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==========================================
             GAMES STORE CATALOG & FILTER SECTION
             ========================================== -->
        <section id="featuredGames">
            <div class="container">
                <div class="section-header">
                    <span class="section-pretitle">Digital Key &amp; Rental Vault</span>
                    <h2 class="section-title">Popular &amp; Trending Games</h2>
                    <p class="section-description">Choose to purchase permanent activation keys or rent for 7 days with complete rent-to-own credit.</p>
                </div>

                <!-- Search Bar -->
                <div class="store-search-bar">
                    <div class="store-input-group">
                        <div class="store-input-wrapper">
                            <div class="store-input-icon">
                                <svg viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg>
                            </div>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="store-input-field" placeholder="Search by game title, genre or keyword..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged" />
                        </div>
                    </div>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-primary-glow" OnClick="btnSearch_Click" />
                </div>

                <!-- Category Filter Tabs -->
                <div class="game-filter-tabs" id="categoryTabs">
                    <asp:HyperLink ID="tabAll" runat="server" NavigateUrl="Home.aspx?cat=all#featuredGames" CssClass="filter-tab" Text="All Games" />
                    <asp:HyperLink ID="tabAction" runat="server" NavigateUrl="Home.aspx?cat=action#featuredGames" CssClass="filter-tab" Text="Action & Combat" />
                    <asp:HyperLink ID="tabFantasy" runat="server" NavigateUrl="Home.aspx?cat=fantasy#featuredGames" CssClass="filter-tab" Text="Open World RPG" />
                    <asp:HyperLink ID="tabMech" runat="server" NavigateUrl="Home.aspx?cat=mech#featuredGames" CssClass="filter-tab" Text="Mech Warfare" />
                    <asp:HyperLink ID="tabRacing" runat="server" NavigateUrl="Home.aspx?cat=racing#featuredGames" CssClass="filter-tab" Text="Speed & Racing" />
                </div>

                <!-- Games Grid -->
                <div class="games-grid">
                    <asp:Repeater ID="rptGames" runat="server">
                        <ItemTemplate>
                            <div class="game-card">
                                <div class="game-card-poster">
                                    <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Title") %>' />
                                    <span class="game-tag-category"><%# Eval("CategoryLabel") %></span>
                                    <%# !string.IsNullOrEmpty((string)Eval("DiscountBadge")) ? "<span class=\"discount-pill\">" + Eval("DiscountBadge") + "</span>" : "" %>
                                    <span class="game-badge-score">
                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>
                                        <%# Eval("Score") %>
                                    </span>
                                </div>
                                <div class="game-card-body">
                                    <div>
                                        <h3 class="game-card-title"><%# Eval("Title") %></h3>
                                        <div class="game-card-meta">
                                            <span><%# Eval("Subtitle") %></span>
                                            <span class="game-platform-badge"><%# Eval("Platforms") %></span>
                                        </div>
                                    </div>

                                    <!-- Dual Buy & Rent Controls -->
                                    <div class="game-pricing-grid">
                                        <!-- Buy Option -->
                                        <div class="pricing-option buy-option">
                                            <div class="option-label">BUY TO OWN</div>
                                            <div class="option-price">
                                                <span class="currency">$</span><%# string.Format("{0:F2}", Eval("BuyPrice")) %>
                                                <%# Eval("OriginalPrice") != null ? "<span class=\"original-price\">$" + string.Format("{0:F2}", Eval("OriginalPrice")) + "</span>" : "" %>
                                            </div>
                                            <div style="display:flex; flex-direction:column; gap:4px;">
                                                <a href='Buy.aspx?id=<%# Eval("Id") %>&action=buy' class="btn-store btn-buy" title="1-Click Direct Buy">Buy Now</a>
                                                <button type="button" class="btn-ghost btn-sm" style="font-size: 0.78rem; padding: 0.3rem 0.5rem;"
                                                    onclick="addToCart('<%# Eval("Id") %>', 'Buy'); return false;">
                                                    + Cart
                                                </button>
                                            </div>
                                        </div>

                                        <!-- Rent Option -->
                                        <div class="pricing-option rent-option">
                                            <div class="option-label">RENT (<%# Eval("RentDuration") %>)</div>
                                            <div class="option-price">
                                                <span class="currency">$</span><%# string.Format("{0:F2}", Eval("RentPrice")) %>
                                            </div>
                                            <div style="display:flex; flex-direction:column; gap:4px;">
                                                <a href='Buy.aspx?id=<%# Eval("Id") %>&action=rent' class="btn-store btn-rent" title="1-Click Direct Rent">Rent Now</a>
                                                <button type="button" class="btn-ghost btn-sm" style="font-size: 0.78rem; padding: 0.3rem 0.5rem;"
                                                    onclick="addToCart('<%# Eval("Id") %>', 'Rent'); return false;">
                                                    + Cart
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>

        <!-- ==========================================
             RENT-TO-OWN BENEFIT SECTION
             ========================================== -->
        <section id="subscription" style="background: rgba(11, 13, 20, 0.5);">
            <div class="container">
                <div class="cta-banner-card">
                    <h2 class="cta-headline">100% Rent-to-Own Credit Guarantee</h2>
                    <p class="cta-subtitle">
                        Never waste money on digital games again. Every cent you spend on rental passes automatically counts toward the permanent purchase price. Play the full game first, then claim your permanent DRM key whenever you choose.
                    </p>
                    <div class="cta-actions">
                        <a href="Cart.aspx" class="btn-primary-glow btn-large">Check Cart &amp; Checkout</a>
                        <a href="#featuredGames" class="btn-ghost btn-large">Explore All Games</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Reusable Site Footer -->
        <uc:SiteFooter ID="siteFooter" runat="server" />

        <script>
            function addToCart(gameCode, licenseType) {
                fetch('Home.aspx/AddToCartAjax', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8'
                    },
                    body: JSON.stringify({ gameCode: gameCode, licenseType: licenseType })
                })
                .then(function(res) { return res.json(); })
                .then(function(data) {
                    var result = data.d || data;
                    if (result.redirect) {
                        window.location.href = result.redirect;
                        return;
                    }
                    if (result.success) {
                        var badge = document.getElementById('cartCountBadge');
                        if (badge) {
                            badge.textContent = result.totalCount;
                            if (result.totalCount > 0) {
                                badge.classList.add('has-items');
                            }
                        }
                        NexusCart.showToast('Added to Cart', result.message);
                    } else {
                        NexusCart.showToast('Notice', result.message || 'Could not add to cart.');
                    }
                })
                .catch(function(err) {
                    console.error('Error adding to cart:', err);
                    window.location.href = 'Home.aspx?action=add&id=' + encodeURIComponent(gameCode) + '&type=' + encodeURIComponent(licenseType);
                });
            }
        </script>
    </form>
</body>
</html>
