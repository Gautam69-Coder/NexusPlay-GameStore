using System;
using System.Web.UI;

namespace WebApplication1.Controls
{
    public partial class FeatureCard : UserControl
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string SvgIcon { get; set; }

        public void SetFeatureData(FeatureItem item)
        {
            if (item == null) return;
            Title = item.Title;
            Description = item.Description;
            SvgIcon = item.SvgIcon;
        }
    }
}
