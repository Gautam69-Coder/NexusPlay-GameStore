<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signin.aspx.cs" Inherits="WebApplication1.Signin" Theme="Gaming" %>
<%@ Register Src="~/Controls/StoreButton.ascx" TagPrefix="uc" TagName="StoreButton" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign In | NEXUS PLAY Gaming Store</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-header">
                    <a href="Landing.aspx" class="brand-logo" id="brandLogo">
                        <div class="brand-icon-box">
                            <svg viewBox="0 0 24 24">
                                <path d="M12 2L2 7l10 5 10-5-10-5zm0 9l-8.5-4.25L2 7.5 12 13l10-5.5-1.5-.75L12 11zm0 4.5l-7-3.5-1.5.75 8.5 4.75 8.5-4.75-1.5-.75-7 3.5z" />
                            </svg>
                        </div>
                        <span class="brand-name">NEXUS<span style="color: var(--neon-cyan);">PLAY</span></span>
                    </a>
                    <h1 class="auth-title">Welcome Back</h1>
                    <p class="auth-subtitle">Sign in to access your digital game library &amp; rentals</p>
                </div>

                <div class="auth-form">
                    <div class="store-input-group">
                        <label class="store-input-label" for="txtIdentifier">Email or GamerTag</label>
                        <div class="store-input-wrapper">
                            <div class="store-input-icon">
                                <svg viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
                            </div>
                            <asp:TextBox ID="txtIdentifier" runat="server" placeholder="e.g. shadow_sniper@nexus.gg or GamerTag" />
                        </div>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator3"
                            runat="server"
                            ControlToValidate="txtIdentifier"
                            ErrorMessage="Email or GamerTag is required"
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="store-input-group">
                        <label class="store-input-label" for="txtPassword">Password</label>
                        <div class="store-input-wrapper">
                            <div class="store-input-icon">
                                <svg viewBox="0 0 24 24"><path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z"/></svg>
                            </div>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" />
                        </div>
                         <asp:RequiredFieldValidator
     ID="RequiredFieldValidator2"
     runat="server" 
     ControlToValidate="txtPassword"
        ForeColor="Red"
        Display="Dynamic"
     ErrorMessage="Password is Required">

 </asp:RequiredFieldValidator>

                    </div>

                    <asp:Label ID="lblError" runat="server" ForeColor="#ff4d4d" Visible="false"
                        style="display: block; margin-bottom: 12px; font-size: 13px; text-align: center;" />

                    <uc:StoreButton ID="btnSignIn" runat="server" 
                        Text="Sign In" 
                        Variant="Primary" 
                        Size="Large" 
                        CustomCssClass="w-100" 
                        OnClick="btnSignIn_Click" />
                </div>

                <div class="auth-footer">
                    <span>Don't have an account? </span>
                    <a href="Signup.aspx">Join Free</a>
                    <div>
                        <a href="Landing.aspx" class="back-link">&larr; Back to Store</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>