using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Controls
{
    public partial class StoreInput : UserControl
    {
        public string Label { get; set; }
        public string Placeholder { get; set; }
        public string IconSvg { get; set; }
        public string WrapperCssClass { get; set; }
        public TextBoxMode InputMode { get; set; } = TextBoxMode.SingleLine;
        public string ValidationGroup { get; set; }

        public string Text
        {
            get => txtInput != null ? txtInput.Text : string.Empty;
            set
            {
                if (txtInput != null) txtInput.Text = value;
            }
        }

        public string ClientIDForLabel => txtInput?.ClientID ?? string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            ApplyProperties();
        }

        public void ApplyProperties()
        {
            if (txtInput == null) return;
            if (!string.IsNullOrEmpty(Placeholder))
            {
                txtInput.Attributes["placeholder"] = Placeholder;
            }
            txtInput.TextMode = InputMode;
            if (!string.IsNullOrEmpty(ValidationGroup))
            {
                txtInput.ValidationGroup = ValidationGroup;
            }
        }
    }
}
