<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PricingCard.ascx.cs" Inherits="WebApplication1.Controls.PricingCard" %>
<div class='<%= IsPopular ? "pricing-card featured" : "pricing-card" %>'>
    <% if (IsPopular) { %>
        <div class="pricing-ribbon">Most Popular</div>
    <% } %>
    <div>
        <div class="plan-tier-name" style='<%= HeaderStyle %>'><%= PlanName %></div>
        <p class="plan-desc"><%= Description %></p>
        <div class="plan-price-block">
            <span class="plan-price-currency">$</span>
            <span class="plan-price-amount"><%= DisplayPrice %></span>
            <span class="plan-price-period"><%= DisplayPeriod %></span>
        </div>
        <ul class="plan-perks-list">
            <% if (Perks != null) { foreach (var perk in Perks) { %>
                <li class='<%= perk.IsEnabled ? "perk-item" : "perk-item disabled" %>'>
                    <% if (perk.IsEnabled) { %>
                        <svg viewBox="0 0 24 24" fill="currentColor"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
                    <% } else { %>
                        <svg viewBox="0 0 24 24" fill="currentColor"><path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/></svg>
                    <% } %>
                    <%= perk.Text %>
                </li>
            <% } } %>
        </ul>
    </div>
    <asp:HyperLink ID="lnkCtaPrimary" runat="server" SkinID="PricingBtnPrimary" Visible="false" />
    <asp:HyperLink ID="lnkCtaGhost" runat="server" SkinID="PricingBtnGhost" Visible="false" />
</div>
