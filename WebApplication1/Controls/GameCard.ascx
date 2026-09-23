<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GameCard.ascx.cs" Inherits="WebApplication1.Controls.GameCard" %>
<div class="game-card" data-category="<%= GameCategory %>">
    <div class="game-card-poster">
        <img src="<%= ImageUrl %>" alt="<%= Title %>" />
        <asp:Label ID="lblCategory" runat="server" SkinID="CategoryTag" />
        <asp:Label ID="lblDiscount" runat="server" SkinID="DiscountPill" />
        <span class="game-badge-score">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>
            <%= Score %>
        </span>
    </div>
    <div class="game-card-body">
        <div>
            <h3 class="game-card-title"><%= Title %></h3>
            <div class="game-card-meta">
                <span><%= Subtitle %></span>
                <span class="game-platform-badge"><%= Platforms %></span>
            </div>
        </div>
        <div class="game-pricing-grid">
            <div class="pricing-option buy-option">
                <div class="option-label">BUY TO OWN</div>
                <div class="option-price">
                    <span class="currency">$</span><%= BuyPrice.ToString("F2") %>
                    <% if (OriginalPrice.HasValue) { %>
                        <span class="original-price">$<%= OriginalPrice.Value.ToString("F2") %></span>
                    <% } %>
                </div>
                <asp:HyperLink ID="lnkBuy" runat="server" SkinID="BuyBtn" Text="Buy Game" />
            </div>
            <div class="pricing-option rent-option">
                <div class="option-label">RENT (<%= RentDuration %>)</div>
                <div class="option-price">
                    <span class="currency">$</span><%= RentPrice.ToString("F2") %>
                </div>
                <asp:HyperLink ID="lnkRent" runat="server" SkinID="RentBtn" Text="Rent Game" />
            </div>
        </div>
    </div>
</div>
