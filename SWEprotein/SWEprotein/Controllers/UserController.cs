using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SWEprotein.Models;
using WebMatrix.WebData;

namespace SWEprotein.Controllers
{
    public class UserController : Controller
    {
        //
        // GET: /User/
        private readonly DataClasses1DataContext _db = new DataClasses1DataContext();

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult EditUserInfo()
        {
            var singleUserInfo = _db.UserInfos.FirstOrDefault(c => c.iID == WebSecurity.CurrentUserId);
            return View(singleUserInfo);
        }

        [HttpPost]
        public ActionResult EditUserInfo(UserInfo userInfo)
        {
            foreach (UserInfo or in _db.UserInfos.Where(c => c.iID == userInfo.iID))
            {
                or.Adress = userInfo.Adress;
                or.PostalNumber = userInfo.PostalNumber;
                or.sEmail = userInfo.sEmail;
                or.sTelephone = userInfo.sTelephone;
                or.sCity = userInfo.sCity;

                _db.SubmitChanges();
                return RedirectToAction("Index", "User");
            }
            return View();

        }

        public ActionResult UserOrders()
        {
            var userOrders = _db.tbOrders.Where(c => c.UserID == WebSecurity.CurrentUserId);
            return View(userOrders);

        }
    }
}