using System;
using System.Collections.Generic;
using System.Web.UI;

namespace WebApplication1.Controls
{
    public class PricingPerkItem
    {
        public string Text { get; set; }
        public bool IsEnabled { get; set; }

        public PricingPerkItem(string text, bool isEnabled = true)
        {
            Text = text;
            IsEnabled = isEnabled;
        }
    }

    public class PricingPlanItem
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal MonthlyPrice { get; set; }
        public decimal AnnualPrice { get; set; }
        public bool IsPopular { get; set; }
        public string HeaderStyle { get; set; }
        public string PlanParam { get; set; }
        public string CtaText { get; set; }
        public string CtaClass { get; set; }
        public List<PricingPerkItem> Perks { get; set; } = new List<PricingPerkItem>();
    }

    public partial class PricingCard : UserControl
    {
        public string PlanName { get; set; }
        public string Description { get; set; }
        public string DisplayPrice { get; set; }
        public string DisplayPeriod { get; set; }
        public bool IsPopular { get; set; }
        public string HeaderStyle { get; set; }
        public string CtaText { get; set; }
        public string CtaClass { get; set; }
        public string CtaUrl { get; set; }
        public List<PricingPerkItem> Perks { get; set; } = new List<PricingPerkItem>();

        public void SetPlanData(PricingPlanItem plan, bool isAnnual)
        {
            if (plan == null) return;
            PlanName = plan.Name;
            Description = plan.Description;
            IsPopular = plan.IsPopular;
            HeaderStyle = plan.HeaderStyle;
            CtaText = plan.CtaText;
            CtaClass = plan.CtaClass;
            Perks = plan.Perks ?? new List<PricingPerkItem>();

            if (plan.MonthlyPrice == 0)
            {
                DisplayPrice = "0";
                DisplayPeriod = "/ month";
                CtaUrl = "Signup.aspx";
            }
            else
            {
                DisplayPrice = isAnnual ? plan.AnnualPrice.ToString("F2") : plan.MonthlyPrice.ToString("F2");
                DisplayPeriod = isAnnual ? "/ month (billed annually)" : "/ month";
                CtaUrl = "Signup.aspx?plan=" + plan.PlanParam + "&billing=" + (isAnnual ? "annual" : "monthly");
            }

            if (IsPopular)
            {
                if (lnkCtaPrimary != null)
                {
                    lnkCtaPrimary.Text = CtaText;
                    lnkCtaPrimary.NavigateUrl = CtaUrl;
                    lnkCtaPrimary.Visible = true;
                }
                if (lnkCtaGhost != null) lnkCtaGhost.Visible = false;
            }
            else
            {
                if (lnkCtaGhost != null)
                {
                    lnkCtaGhost.Text = CtaText;
                    lnkCtaGhost.NavigateUrl = CtaUrl;
                    lnkCtaGhost.Visible = true;
                }
                if (lnkCtaPrimary != null) lnkCtaPrimary.Visible = false;
            }
        }
    }
}
