using System;
using System.Web.UI;

namespace WebApplication1.Controls
{
    public partial class GameCard : UserControl
    {
        public string Title { get; set; }
        public string Subtitle { get; set; }
        public string GameCategory { get; set; }
        public string CategoryLabel { get; set; }
        public string Score { get; set; }
        public string ImageUrl { get; set; }
        public decimal BuyPrice { get; set; }
        public decimal? OriginalPrice { get; set; }
        public string DiscountBadge { get; set; }
        public decimal RentPrice { get; set; }
        public string RentDuration { get; set; }
        public string Platforms { get; set; }
        public string BuyUrl { get; set; }
        public string RentUrl { get; set; }

        public void SetGameData(GameItem game)
        {
            if (game == null) return;
            Title = game.Title;
            Subtitle = game.Subtitle;
            GameCategory = game.Category;
            CategoryLabel = game.CategoryLabel;
            Score = game.Score;
            ImageUrl = game.ImageUrl;
            BuyPrice = game.BuyPrice;
            OriginalPrice = game.OriginalPrice;
            DiscountBadge = game.DiscountBadge;
            RentPrice = game.RentPrice;
            RentDuration = game.RentDuration;
            Platforms = game.Platforms;
            BuyUrl = "Checkout.aspx?action=buy&id=" + Server.UrlEncode(game.Id);
            RentUrl = "Checkout.aspx?action=rent&id=" + Server.UrlEncode(game.Id);

            if (lnkBuy != null) lnkBuy.NavigateUrl = BuyUrl;
            if (lnkRent != null) lnkRent.NavigateUrl = RentUrl;
            if (lblCategory != null) lblCategory.Text = CategoryLabel;
            if (lblDiscount != null)
            {
                lblDiscount.Text = DiscountBadge;
                lblDiscount.Visible = !string.IsNullOrEmpty(DiscountBadge);
            }
        }
    }
}
