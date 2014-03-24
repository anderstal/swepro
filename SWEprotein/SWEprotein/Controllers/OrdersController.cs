using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SWEprotein.Models;

namespace SWEprotein.Controllers
{
    public class OrdersController : Controller
    {
        //
        // GET: /Orders/
        private readonly DataClasses1DataContext _db = new DataClasses1DataContext();
        readonly List<tbProduct> _basket = new List<tbProduct>();

        public ActionResult Kundkorg()
        {
            if (Session["cartList"] != null)
            {
                ViewBag.cartCount = ((List<tbProduct>)Session["cartList"]).Sum(c => c.iCount);
              
            }
            if (Session["cartList"] == null)
            {
                return View("EmptyCart");
            }
            if (((List<tbProduct>)Session["cartList"]).Count == 0)
            {
                return View("EmptyCart");
            }
            var cartList = ((List<tbProduct>)Session["cartList"]);

            return View(cartList);
        }
        public ActionResult CartRemove(int? id)
        {
            if (Session["cartList"] != null)
            {
                ViewBag.cartCount = ((List<tbProduct>)Session["cartList"]).Sum(c => c.iCount);
            }
            var tbProducts = (List<tbProduct>)Session["cartList"];
            if (tbProducts != null)
                tbProducts.RemoveAll(c => c.iID == id);
            return RedirectToAction("Kundkorg");
        }
        public ActionResult CartAdd(int? id)
        {

          
            if (Session["cartList"] != null)
            {
                ViewBag.cartCount = ((List<tbProduct>)Session["cartList"]).Sum(c => c.iCount);
            }
            var findProduct = (from f in _db.tbProducts.Where(c => c.iID == id) select f).FirstOrDefault();
          
            if (Session["cartList"] == null)
            {
                Session["cartList"] = _basket;
            }

            //Kollar om produkten redan finns i listan.
            bool checkCartList = ((List<tbProduct>)Session["cartList"]).Any(c => c.iID == id);
            if (checkCartList == false)
            {
                ((List<tbProduct>)Session["cartList"]).Add(findProduct);
                return RedirectToAction("Index", "Product");

            }
            foreach (tbProduct prod in ((List<tbProduct>)Session["cartList"]).Where(c => c.iID == id))
            {
                prod.iCount++;
            }

            return RedirectToAction("Index", "Product");


        }

        public ActionResult CheckOut()
        {
            var order = new tbOrder
            {
                UserID = 2, //Byt till Session["login"].ID
                iStatus = 1,
                iSum = ((List<tbProduct>)Session["cartList"]).Sum(prod => prod.iPrice * prod.iCount),
                dtOrderDate = DateTime.Now

            };
            
            _db.tbOrders.InsertOnSubmit(order);
            _db.SubmitChanges();
            foreach (tbProduct prod in ((List<tbProduct>)Session["cartList"]))
            {
              var  prodOrder = new tbProductOrder
                {
                    iOrderID = order.iID,
                    iProductID = prod.iID,
                    iQuantity = (int) prod.iCount,
                    iPrice = prod.iPrice
                };
                _db.tbProductOrders.InsertOnSubmit(prodOrder);

            }
            _db.SubmitChanges();
            SendReceipt(order.UserID, "Kvitto SWEprotein", "Summa: " + order.iSum + "\nDatum: " + order.dtOrderDate + "...en massa annan info");
            var receipt = _db.tbOrders.Where(c => c.UserID == order.UserID && c.iID == order.iID);
            return View(receipt); //Gå till för "färdig" betalning
        }

        public void SendReceipt(int id, string subject, string messageBody)
        {
            var emailUser = _db.UserInfos.FirstOrDefault(c => c.UserID == id);
            try
            {
                var message = new System.Net.Mail.MailMessage();
                message.To.Add(emailUser.sEmail);
                message.Subject = subject;
                message.From = new System.Net.Mail.MailAddress("gymuser3@gmail.com");
                message.Body = messageBody;
                var smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587)
                {
                    Credentials = new System.Net.NetworkCredential("gymuser3@gmail.com", "asdf1234!"),
                    EnableSsl = true
                };

                smtp.Send(message);
            }
            catch
            {
                return;
            }

        }
    }
}