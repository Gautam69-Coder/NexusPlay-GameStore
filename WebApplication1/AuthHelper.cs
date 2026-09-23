using System;
using System.Web;

namespace WebApplication1
{
    public class UserAuthInfo
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
    }

    public static class AuthHelper
    {
        public const string CookieName = "NexusUser";

        public static void SetAuthCookie(HttpResponse response, int userId, string username, string email)
        {
            if (response == null) return;
            HttpCookie cookie = new HttpCookie(CookieName);
            cookie.Values["UserId"] = userId.ToString();
            cookie.Values["Username"] = HttpUtility.UrlEncode(username ?? "");
            cookie.Values["Email"] = HttpUtility.UrlEncode(email ?? "");
            cookie.HttpOnly = true;
            cookie.Path = "/";
            cookie.Expires = DateTime.Now.AddDays(7);
            response.Cookies.Set(cookie);
        }

        public static UserAuthInfo GetCurrentUser(HttpRequest request)
        {
            if (request == null) return null;
            HttpCookie cookie = request.Cookies[CookieName];
            if (cookie == null || string.IsNullOrEmpty(cookie.Values["UserId"]))
            {
                return null;
            }

            if (int.TryParse(cookie.Values["UserId"], out int userId))
            {
                return new UserAuthInfo
                {
                    UserId = userId,
                    Username = HttpUtility.UrlDecode(cookie.Values["Username"] ?? "Gamer"),
                    Email = HttpUtility.UrlDecode(cookie.Values["Email"] ?? "")
                };
            }

            return null;
        }

        public static void ClearAuthCookie(HttpResponse response)
        {
            if (response == null) return;
            HttpCookie cookie = new HttpCookie(CookieName);
            cookie.Expires = DateTime.Now.AddDays(-1);
            cookie.Path = "/";
            cookie.Value = string.Empty;
            response.Cookies.Set(cookie);
        }
    }
}
