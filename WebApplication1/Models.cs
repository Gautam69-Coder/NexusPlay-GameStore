using System;

namespace WebApplication1
{
    public class GameItem
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Subtitle { get; set; }
        public string Category { get; set; }
        public string CategoryLabel { get; set; }
        public string Score { get; set; }
        public string ImageUrl { get; set; }
        public decimal BuyPrice { get; set; }
        public decimal? OriginalPrice { get; set; }
        public string DiscountBadge { get; set; }
        public decimal RentPrice { get; set; }
        public string RentDuration { get; set; }
        public string Platforms { get; set; }
    }

    public class CategoryItem
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Count { get; set; }
        public string FilterCategory { get; set; }
        public string SvgIcon { get; set; }
    }

    public class FeatureItem
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string SvgIcon { get; set; }
    }
}
