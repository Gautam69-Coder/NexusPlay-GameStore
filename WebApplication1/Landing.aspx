<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Landing.aspx.cs" Inherits="WebApplication1.Landing" Theme="Gaming" %>
<%@ Register Src="~/Controls/SiteFooter.ascx" TagPrefix="uc" TagName="SiteFooter" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NEXUS PLAY | Next-Gen Digital Game Store &amp; Rentals</title>
    <meta name="description" content="Official publisher keys, flexible game rentals, and 100% rent-to-own credit on PC, PlayStation, Xbox, and Nintendo Switch." />
</head>
<body>
    <form id="form1" runat="server">
        <div class="cyber-grid-overlay"></div>

        <!-- ==========================================
             STICKY TOP NAVBAR (LANDING PAGE ONLY)
             ========================================== -->
        <nav class="navbar" id="mainNavbar">
            <div class="container nav-wrapper">
                <a href="Landing.aspx" class="brand-logo" id="brandLogo">
                    <div class="brand-icon-box">
                        <svg viewBox="0 0 24 24">
                            <path d="M12 2L2 7l10 5 10-5-10-5zm0 9l-8.5-4.25L2 7.5 12 13l10-5.5-1.5-.75L12 11zm0 4.5l-7-3.5-1.5.75 8.5 4.75 8.5-4.75-1.5-.75-7 3.5z" />
                        </svg>
                    </div>
                    <span class="brand-name">NEXUS<span style="color: var(--neon-cyan);">PLAY</span></span>
                </a>

                <ul class="nav-links">
                    <li><a href="#featuredGames" class="nav-link">Featured Titles</a></li>
                    <li><a href="#categories" class="nav-link">Categories</a></li>
                    <li><a href="#features" class="nav-link">Why Nexus</a></li>
                    <li><a href="#pricing" class="nav-link">Access Passes</a></li>
                    <li><a href="Home.aspx" class="nav-link" style="color: var(--neon-cyan); font-weight: 700;">Enter Store &rarr;</a></li>
                </ul>

                <!-- Landing Auth CTAs (Sign In and Join Free) -->
                <div class="nav-actions">
                    <a href="Signin.aspx" class="btn-ghost">Sign In</a>
                    <a href="Signup.aspx" class="btn-primary-glow">Join Free</a>
                </div>
            </div>
        </nav>

        <!-- ==========================================
             HERO SECTION
             ========================================== -->
        <section class="hero-section" id="hero">
            <div class="container hero-grid">
                <div class="hero-content">
                    <div class="hero-badge-tag">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                        </svg>
                        <span>Official Publisher Licenses &bull; Instant Delivery</span>
                    </div>

                    <h1 class="hero-title">
                        Play Without Limits.<br />
                        <span class="gradient-text-cyan">Buy Permanent. Rent Flexible.</span>
                    </h1>

                    <p class="hero-description">
                        Discover 1,500+ blockbuster AAA titles and indie gems with 100% genuine publisher keys. Rent top titles with full rent-to-own purchase credit.
                    </p>

                    <div class="hero-cta-group">
                        <a href="Home.aspx" class="btn-primary-glow btn-large">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H8V4h12v12z"/>
                            </svg>
                            <span>Explore Game Store</span>
                        </a>
                        <a href="Signup.aspx" class="btn-ghost btn-large">Join Free Account</a>
                    </div>

                    <div class="hero-quick-stats">
                        <div>
                            <div class="stat-num">1,500<span>+</span></div>
                            <div class="stat-label">Games Available</div>
                        </div>
                        <div>
                            <div class="stat-num">100<span>%</span></div>
                            <div class="stat-label">Publisher Keys</div>
                        </div>
                        <div>
                            <div class="stat-num">500K<span>+</span></div>
                            <div class="stat-label">Active Gamers</div>
                        </div>
                    </div>
                </div>

                <div class="hero-visual">
                    <div class="hero-art-card">
                        <img src="images/hero-banner.jpg" alt="Nexus Play Gaming Universe" class="hero-image" />
                        <div class="hero-art-overlay">
                            <div class="hero-art-badge-top">
                                <span class="status-dot-pulse"></span>
                                <span>Official DRM Keys &bull; Instant Delivery</span>
                            </div>
                            <div class="hero-featured-info">
                                <h3>Next-Gen Gaming Vault</h3>
                                <p>Buy permanent keys or rent with 100% credit</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==========================================
             FEATURED GAMES SHOWCASE
             ========================================== -->
        <section id="featuredGames">
            <div class="container">
                <div class="section-header">
                    <span class="section-pretitle">Digital Key &amp; Rental Vault</span>
                    <h2 class="section-title">Trending Games</h2>
                    <p class="section-description">
                        Instant digital delivery with Steam, PlayStation, Xbox, and Nintendo Switch license keys.
                    </p>
                </div>

                <!-- Showcase Games Grid -->
                <div class="games-grid">
                    <!-- Game Card 1 -->
                    <div class="game-card">
                        <div class="game-card-poster">
                            <img src="images/cover-cyberstorm.jpg" alt="Cyberstorm 2088" />
                            <span class="game-tag-category">Action RPG</span>
                            <span class="discount-pill">-25% OFF</span>
                            <span class="game-badge-score">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>
                                9.8
                            </span>
                        </div>
                        <div class="game-card-body">
                            <div>
                                <h3 class="game-card-title">Cyberstorm 2088</h3>
                                <div class="game-card-meta">
                                    <span>Ray-Tracing Cyberpunk RPG</span>
                                    <span class="game-platform-badge">PC &bull; PS5 &bull; Xbox</span>
                                </div>
                            </div>
                            <div class="game-pricing-grid">
                                <div class="pricing-option">
                                    <div class="option-label">BUY TO OWN</div>
                                    <div class="option-price">
                                        <span class="currency">$</span>49.99
                                        <span class="original-price">$69.99</span>
                                    </div>
                                    <a href="Home.aspx" class="btn-store btn-buy">Buy Key</a>
                                </div>
                                <div class="pricing-option">
                                    <div class="option-label">RENT (7 DAYS)</div>
                                    <div class="option-price">
                                        <span class="currency">$</span>9.99
                                    </div>
                                    <a href="Home.aspx" class="btn-store btn-rent">Rent Key</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Game Card 2 -->
                    <div class="game-card">
                        <div class="game-card-poster">
                            <img src="images/cover-elder-realms.jpg" alt="Elder Realms: Oblivion" />
                            <span class="game-tag-category">Open World</span>
                            <span class="discount-pill">-35% OFF</span>
                            <span class="game-badge-score">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>
                                9.6
                            </span>
                        </div>
                        <div class="game-card-body">
                            <div>
                                <h3 class="game-card-title">Elder Realms: Oblivion</h3>
                                <div class="game-card-meta">
                                    <span>Epic Fantasy Open World</span>
                                    <span class="game-platform-badge">PC &bull; PS5</span>
                                </div>
                            </div>
                            <div class="game-pricing-grid">
                                <div class="pricing-option">
                                    <div class="option-label">BUY TO OWN</div>
                                    <div class="option-price">
                                        <span class="currency">$</span>39.99
                                        <span class="original-price">$59.99</span>
                                    </div>
                                    <a href="Home.aspx" class="btn-store btn-buy">Buy Key</a>
                                </div>
                                <div class="pricing-option">
                                    <div class="option-label">RENT (7 DAYS)</div>
                                    <div class="option-price">
                                        <span class="currency">$</span>7.99
                                    </div>
                                    <a href="Home.aspx" class="btn-store btn-rent">Rent Key</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Game Card 3 -->
                    <div class="game-card">
                        <div class="game-card-poster">
                            <img src="images/cover-valkyrie.jpg" alt="Valkyrie: Sky Protocol" />
                            <span class="game-tag-category">Mech Combat</span>
                            <span class="discount-pill">POPULAR</span>
                            <span class="game-badge-score">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>
                                9.4
                            </span>
                        </div>
                        <div class="game-card-body">
                            <div>
                                <h3 class="game-card-title">Valkyrie: Sky Protocol</h3>
                                <div class="game-card-meta">
                                    <span>High-Speed Mecha Battles</span>
                                    <span class="game-platform-badge">PC &bull; Xbox &bull; PS5</span>
                                </div>
                            </div>
                            <div class="game-pricing-grid">
                                <div class="pricing-option">
                                    <div class="option-label">BUY TO OWN</div>
                                    <div class="option-price">
                                        <span class="currency">$</span>39.99
                                    </div>
                                    <a href="Home.aspx" class="btn-store btn-buy">Buy Key</a>
                                </div>
                                <div class="pricing-option">
                                    <div class="option-label">RENT (7 DAYS)</div>
                                    <div class="option-price">
                                        <span class="currency">$</span>8.99
                                    </div>
                                    <a href="Home.aspx" class="btn-store btn-rent">Rent Key</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Game Card 4 -->
                    <div class="game-card">
                        <div class="game-card-poster">
                            <img src="images/cover-apex.jpg" alt="Apex Velocity GT" />
                            <span class="game-tag-category">Racing</span>
                            <span class="discount-pill">-20% OFF</span>
                            <span class="game-badge-score">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>
                                9.2
                            </span>
                        </div>
                        <div class="game-card-body">
                            <div>
                                <h3 class="game-card-title">Apex Velocity GT</h3>
                                <div class="game-card-meta">
                                    <span>Sim Racing Simulation</span>
                                    <span class="game-platform-badge">PC &bull; PS5</span>
                                </div>
                            </div>
                            <div class="game-pricing-grid">
                                <div class="pricing-option">
                                    <div class="option-label">BUY TO OWN</div>
                                    <div class="option-price">
                                        <span class="currency">$</span>44.99
                                        <span class="original-price">$54.99</span>
                                    </div>
                                    <a href="Home.aspx" class="btn-store btn-buy">Buy Key</a>
                                </div>
                                <div class="pricing-option">
                                    <div class="option-label">RENT (7 DAYS)</div>
                                    <div class="option-price">
                                        <span class="currency">$</span>8.49
                                    </div>
                                    <a href="Home.aspx" class="btn-store btn-rent">Rent Key</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="text-align: center; margin-top: 3rem;">
                    <a href="Home.aspx#featuredGames" class="btn-primary-glow btn-large">
                        Browse Full 1,500+ Catalog &rarr;
                    </a>
                </div>
            </div>
        </section>

        <!-- ==========================================
             GAME CATEGORIES
             ========================================== -->
        <section id="categories">
            <div class="container">
                <div class="section-header">
                    <span class="section-pretitle">Catalog</span>
                    <h2 class="section-title">Explore Genres</h2>
                    <p class="section-description">
                        From heart-pounding combat to deep RPG sagas, find your next addiction.
                    </p>
                </div>

                <div class="categories-grid">
                    <a href="Home.aspx?cat=action#featuredGames" class="category-tile">
                        <div class="category-icon-box">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M14.5 12.5l5.5-5.5-2-2-5.5 5.5-2-2L9 10l-6 6 2 2 6-6 1.5 1.5 2-1zM21 3l-4 4 2 2 4-4-2-2z"/></svg>
                        </div>
                        <h4 class="category-name">Action &amp; Combat</h4>
                        <span class="category-count">140+ Titles</span>
                    </a>

                    <a href="Home.aspx?cat=fantasy#featuredGames" class="category-tile">
                        <div class="category-icon-box">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2L1 21h22L12 2zm0 3.45L18.88 19H5.12L12 5.45zM11 10v4h2v-4h-2zm0 6v2h2v-2h-2z"/></svg>
                        </div>
                        <h4 class="category-name">Open World RPG</h4>
                        <span class="category-count">95+ Titles</span>
                    </a>

                    <a href="Home.aspx?cat=action#featuredGames" class="category-tile">
                        <div class="category-icon-box">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11v8.8z"/></svg>
                        </div>
                        <h4 class="category-name">Sci-Fi &amp; Cyber</h4>
                        <span class="category-count">78+ Titles</span>
                    </a>

                    <a href="Home.aspx?cat=mech#featuredGames" class="category-tile">
                        <div class="category-icon-box">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.49 2 2 6.49 2 12s4.49 10 10 10 10-4.49 10-10S17.51 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm1-13h-2v4H7v2h4v4h2v-4h4v-2h-4V7z"/></svg>
                        </div>
                        <h4 class="category-name">Mech Warfare</h4>
                        <span class="category-count">64+ Titles</span>
                    </a>

                    <a href="Home.aspx?cat=racing#featuredGames" class="category-tile">
                        <div class="category-icon-box">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M18.92 6.01C18.72 5.42 18.16 5 17.5 5h-11c-.66 0-1.21.42-1.42 1.01L3 12v8c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-1h12v1c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-8l-2.08-5.99zM6.85 7h10.29l1.08 3.11H5.77L6.85 7zM19 17H5v-4.66l.12-.34h13.77l.11.34V17z"/></svg>
                        </div>
                        <h4 class="category-name">Speed &amp; Racing</h4>
                        <span class="category-count">42+ Titles</span>
                    </a>

                    <a href="Home.aspx#featuredGames" class="category-tile">
                        <div class="category-icon-box">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H8V4h12v12z"/></svg>
                        </div>
                        <h4 class="category-name">All Categories</h4>
                        <span class="category-count">1,500+ Games</span>
                    </a>
                </div>
            </div>
        </section>

        <!-- ==========================================
             WHY NEXUS PLAY (STORE GUARANTEES)
             ========================================== -->
        <section id="features">
            <div class="container">
                <div class="section-header">
                    <span class="section-pretitle">Store Guarantees</span>
                    <h2 class="section-title">Built for Real Gamers</h2>
                    <p class="section-description">
                        Every purchase and rental is backed by our direct studio relationships and 100% key guarantee.
                    </p>
                </div>

                <div class="features-grid">
                    <div class="feature-box">
                        <div class="feature-icon-wrapper">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 14.5v-9l6 4.5-6 4.5z"/></svg>
                        </div>
                        <h3 class="feature-title">Instant Key Delivery</h3>
                        <p class="feature-text">Receive official publisher activation keys immediately upon checkout. Works with Steam, Epic, PSN, and Xbox.</p>
                    </div>

                    <div class="feature-box">
                        <div class="feature-icon-wrapper">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M19.35 10.04C18.67 6.59 15.64 4 12 4 9.11 4 6.6 5.64 5.35 8.04 2.34 8.36 0 10.91 0 14c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96z"/></svg>
                        </div>
                        <h3 class="feature-title">100% Rent-to-Own</h3>
                        <p class="feature-text">Every dollar spent renting any game rolls directly into purchase credit. Complete your purchase anytime at a discount.</p>
                    </div>

                    <div class="feature-box">
                        <div class="feature-icon-wrapper">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M21 6H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-10 7H8v3H6v-3H3v-2h3V8h2v3h3v2zm4.5 2c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm4-3c-.83 0-1.5-.67-1.5-1.5S18.67 9 19.5 9s1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/></svg>
                        </div>
                        <h3 class="feature-title">Multi-Platform Ready</h3>
                        <p class="feature-text">Rent or buy games across PC, PlayStation, Xbox, and Nintendo Switch with unified cloud save tracking.</p>
                    </div>

                    <div class="feature-box">
                        <div class="feature-icon-wrapper">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z"/></svg>
                        </div>
                        <h3 class="feature-title">Studio Guaranteed</h3>
                        <p class="feature-text">All keys sourced directly from official game studios and authorized global distributors with 24/7 key replacement.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==========================================
             RENTAL PASSES / PRICING
             ========================================== -->
        <section id="pricing">
            <div class="container">
                <div class="section-header">
                    <span class="section-pretitle">Rental Memberships</span>
                    <h2 class="section-title">Choose Your Access Pass</h2>
                    <p class="section-description">
                        Rent multiple games simultaneously or enjoy extra discounts on all store purchases.
                    </p>
                </div>

                <div class="pricing-grid">
                    <!-- Free Tier -->
                    <div class="pricing-card">
                        <div>
                            <h3 class="plan-tier-name">Scout Pass</h3>
                            <p class="plan-desc">For casual gamers who buy single titles</p>
                            <div class="plan-price-block">
                                <span class="plan-price-currency">$</span>
                                <span class="plan-price-amount">0</span>
                                <span class="plan-price-period">/ month</span>
                            </div>
                            <ul class="plan-perks-list">
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    Official DRM Key Purchases
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    Individual 7-Day Game Rentals
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    Cloud Save Tracking
                                </li>
                                <li class="perk-item disabled">
                                    <svg viewBox="0 0 24 24"><path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/></svg>
                                    Multi-Game Rentals
                                </li>
                                <li class="perk-item disabled">
                                    <svg viewBox="0 0 24 24"><path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/></svg>
                                    Extra Store Discounts
                                </li>
                            </ul>
                        </div>
                        <a href="Signup.aspx" class="btn-ghost w-100">Get Started Free</a>
                    </div>

                    <!-- Pro Gamer Pass (Featured) -->
                    <div class="pricing-card featured">
                        <span class="pricing-ribbon">Most Popular</span>
                        <div>
                            <h3 class="plan-tier-name">Pro Gamer Pass</h3>
                            <p class="plan-desc">Best value for enthusiastic gamers</p>
                            <div class="plan-price-block">
                                <span class="plan-price-currency">$</span>
                                <span class="plan-price-amount">9.99</span>
                                <span class="plan-price-period">/ month</span>
                            </div>
                            <ul class="plan-perks-list">
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    Official DRM Key Purchases
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    2 Simultaneous Game Rentals
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    10% Extra Storewide Discount
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    Priority Key Replacement
                                </li>
                                <li class="perk-item disabled">
                                    <svg viewBox="0 0 24 24"><path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/></svg>
                                    Day-1 New Releases
                                </li>
                            </ul>
                        </div>
                        <a href="Signup.aspx" class="btn-primary-glow w-100">Join Pro Pass</a>
                    </div>

                    <!-- Elite Tier -->
                    <div class="pricing-card">
                        <div>
                            <h3 class="plan-tier-name">Elite Pass</h3>
                            <p class="plan-desc">Ultimate access for hardcore players</p>
                            <div class="plan-price-block">
                                <span class="plan-price-currency">$</span>
                                <span class="plan-price-amount">19.99</span>
                                <span class="plan-price-period">/ month</span>
                            </div>
                            <ul class="plan-perks-list">
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    Official DRM Key Purchases
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    5 Simultaneous Game Rentals
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    20% Extra Storewide Discount
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    Day-1 New Release Access
                                </li>
                                <li class="perk-item">
                                    <svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                                    VIP Discord &amp; Alpha Tests
                                </li>
                            </ul>
                        </div>
                        <a href="Signup.aspx" class="btn-ghost w-100">Get Elite Access</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==========================================
             FINAL CTA BANNER
             ========================================== -->
        <section class="cta-section">
            <div class="container">
                <div class="cta-banner-card">
                    <h2 class="cta-headline">Ready to Level Up Your Game Library?</h2>
                    <p class="cta-subtitle">Join over 500,000 players buying genuine publisher keys and renting next-gen titles with zero lock-in.</p>
                    <div class="cta-actions">
                        <a href="Signup.aspx" class="btn-primary-glow btn-large">Create Free Account</a>
                        <a href="Home.aspx" class="btn-ghost btn-large">Explore All Games</a>
                    </div>
                </div>
            </div>
        </section>

        <uc:SiteFooter ID="siteFooter" runat="server" />
    </form>
</body>
</html>
