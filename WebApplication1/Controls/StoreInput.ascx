<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StoreInput.ascx.cs" Inherits="WebApplication1.Controls.StoreInput" %>
<div class="store-input-group <%= WrapperCssClass %>">
    <% if (!string.IsNullOrEmpty(Label)) { %>
        <label class="store-input-label" for="<%= txtInput.ClientID %>"><%= Label %></label>
    <% } %>
    <div class="store-input-wrapper">
        <% if (!string.IsNullOrEmpty(IconSvg)) { %>
            <div class="store-input-icon"><%= IconSvg %></div>
        <% } %>
        <asp:TextBox ID="txtInput" runat="server" CssClass="store-input-field" />
    </div>
</div>
