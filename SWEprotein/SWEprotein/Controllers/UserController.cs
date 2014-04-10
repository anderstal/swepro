using System.Linq;
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
            var singleUserInfo = _db.tbUserInfos.FirstOrDefault(c => c.iID == WebSecurity.CurrentUserId);
            return View(singleUserInfo);
        }

        [HttpPost]
        public ActionResult EditUserInfo(tbUserInfo userInfo)
        {
            foreach (tbUserInfo or in _db.tbUserInfos.Where(c => c.iID == userInfo.iID))
            {
                or.sAdress = userInfo.sAdress;
                or.sPostalNumber = userInfo.sPostalNumber;
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
            var userOrders = _db.tbOrders.Where(c => c.iUserID == WebSecurity.CurrentUserId);
            return View(userOrders);

        }

        public ActionResult OrderDetail(int id)
        {
            var checkOrder = _db.tbOrders.FirstOrDefault(c => c.iID == id && c.iUserID == WebSecurity.CurrentUserId);
            var singleOrder = _db.tbProductOrders.Where(c => c.iOrderID == checkOrder.iID);
            return View(singleOrder);
        }

        public ActionResult Reklamera(int id)
        {
            var singleProdukt = _db.tbProducts.FirstOrDefault(c => c.iID == id);

            return View(singleProdukt);

        }
        [HttpPost]
        public ActionResult Reklamera(string messageBody, tbProduct prod)
        {
            var getEmail = _db.tbUserInfos.FirstOrDefault(c => c.iID == WebSecurity.CurrentUserId);
            var getProduct = _db.tbProducts.FirstOrDefault(c => c.iID == prod.iID);
            try
            {
                var message = new System.Net.Mail.MailMessage();
                message.To.Add(getEmail.sEmail);
                message.Subject = "Reklamering: " + getProduct.sName;
                message.From = new System.Net.Mail.MailAddress("gymuser3@gmail.com");
                message.Body = messageBody + "\nSkickat av: " + getEmail.sEmail;
                var smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587)
                {
                    Credentials = new System.Net.NetworkCredential("gymuser3@gmail.com", "asdf1234!"),
                    EnableSsl = true
                };

                smtp.Send(message);
                return RedirectToAction("Mailskickat", "Info");

            }
            catch
            {
                ViewBag.Message = "Något gick fel... ";
                return View();
            }

        }
    }
}