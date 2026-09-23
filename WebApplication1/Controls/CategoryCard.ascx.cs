using System;
using System.Web.UI;

namespace WebApplication1.Controls
{
    public partial class CategoryCard : UserControl
    {
        public string Name { get; set; }
        public string Count { get; set; }
        public string SvgIcon { get; set; }
        public string TargetUrl { get; set; }

        public void SetCategoryData(CategoryItem item, bool isAnnual)
        {
            if (item == null) return;
            Name = item.Name;
            Count = item.Count;
            SvgIcon = item.SvgIcon;
            
            string url = "Landing.aspx?cat=" + item.FilterCategory;
            if (isAnnual) url += "&billing=annual";
            url += "#featuredGames";
            TargetUrl = url;
        }
    }
}
