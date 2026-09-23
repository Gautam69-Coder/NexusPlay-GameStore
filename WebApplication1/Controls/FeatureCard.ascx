<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FeatureCard.ascx.cs" Inherits="WebApplication1.Controls.FeatureCard" %>
<div class="feature-box">
    <div class="feature-icon-wrapper">
        <%= SvgIcon %>
    </div>
    <h3 class="feature-title"><%= Title %></h3>
    <p class="feature-text"><%= Description %></p>
</div>
