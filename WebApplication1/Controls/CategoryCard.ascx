<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryCard.ascx.cs" Inherits="WebApplication1.Controls.CategoryCard" %>
<a href="<%= TargetUrl %>" class="category-tile">
    <div class="category-icon-box">
        <%= SvgIcon %>
    </div>
    <div class="category-name"><%= Name %></div>
    <div class="category-count"><%= Count %></div>
</a>
