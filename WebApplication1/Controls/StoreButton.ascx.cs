using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Controls
{
    public partial class StoreButton : UserControl
    {
        public event EventHandler Click;

        public string Text { get; set; } = "Submit";
        public string NavigateUrl { get; set; }
        public string Variant { get; set; } = "Primary"; // Primary, Secondary, Ghost, Buy, Rent
        public string Size { get; set; } = "Medium";     // Small, Medium, Large
        public string CustomCssClass { get; set; }
        public string ValidationGroup { get; set; }
        public bool CausesValidation { get; set; } = true;
        public string CommandName { get; set; }
        public string CommandArgument { get; set; }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            ApplyButtonConfiguration();
        }

        private void ApplyButtonConfiguration()
        {
            string computedClass = BuildCssClass();

            if (!string.IsNullOrEmpty(NavigateUrl))
            {
                // Link Navigation Mode
                lnkButton.Visible = true;
                btnAction.Visible = false;
                lnkButton.Text = Text;
                lnkButton.NavigateUrl = NavigateUrl;
                lnkButton.CssClass = computedClass;
            }
            else
            {
                // Form Submit / PostBack Mode
                btnAction.Visible = true;
                lnkButton.Visible = false;
                btnAction.Text = Text;
                btnAction.CssClass = computedClass;
                btnAction.CausesValidation = CausesValidation;
                if (!string.IsNullOrEmpty(ValidationGroup)) btnAction.ValidationGroup = ValidationGroup;
                if (!string.IsNullOrEmpty(CommandName)) btnAction.CommandName = CommandName;
                if (!string.IsNullOrEmpty(CommandArgument)) btnAction.CommandArgument = CommandArgument;
            }
        }

        private string BuildCssClass()
        {
            string variantClass = "btn-primary-glow";
            switch (Variant?.ToLowerInvariant())
            {
                case "secondary":
                    variantClass = "btn-secondary-glow";
                    break;
                case "ghost":
                    variantClass = "btn-ghost";
                    break;
                case "buy":
                    variantClass = "btn-store btn-buy";
                    break;
                case "rent":
                    variantClass = "btn-store btn-rent";
                    break;
                default:
                    variantClass = "btn-primary-glow";
                    break;
            }

            string sizeClass = "";
            switch (Size?.ToLowerInvariant())
            {
                case "small":
                    sizeClass = "btn-sm";
                    break;
                case "large":
                    sizeClass = "btn-large";
                    break;
                default:
                    sizeClass = "";
                    break;
            }

            return $"{variantClass} {sizeClass} {CustomCssClass}".Trim();
        }

        protected void btnAction_Click(object sender, EventArgs e)
        {
            Click?.Invoke(this, e);
        }
    }
}
