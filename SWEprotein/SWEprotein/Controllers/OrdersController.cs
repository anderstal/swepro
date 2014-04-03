using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SWEprotein.Models;
using WebMatrix.WebData;
using System.Net.Mail;
using System.Net;
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
            if (WebSecurity.IsAuthenticated)
            {
                var order = new tbOrder
                {
                    iUserID = WebSecurity.CurrentUserId,
                    iStatus = 1,
                    iSum = ((List<tbProduct>)Session["cartList"]).Sum(prod => prod.iPrice * prod.iCount),
                    dtOrderDate = DateTime.Now
                };

                _db.tbOrders.InsertOnSubmit(order);
                _db.SubmitChanges();

                foreach (tbProduct p in ((List<tbProduct>)Session["cartList"]).Distinct())
                {
                    var prodOrder = new tbProductOrder
                    {
                        iOrderID = order.iID,
                        iProductID = p.iID,
                        iQuantity = ((List<tbProduct>)Session["cartList"]).Count(c => c.iID == p.iID)
                    };
                    _db.tbProductOrders.InsertOnSubmit(prodOrder);

                }
                _db.SubmitChanges();

                SendReceipt(order.iUserID, "Kvitto SWEprotein", "Summa: " + order.iSum + "\nDatum: " + order.dtOrderDate + "...en massa annan info");
                var receipt = _db.tbOrders.Where(c => c.iUserID == order.iUserID && c.iID == order.iID);

                Session["cartList"] = null;
                return View(receipt); //Gå till för "färdig" betalning
            }

            return View("GuestOrder");
        }

        public ActionResult GuestOrder(string mail, string telenr, string adress, string postnumber, string city)
        {
            if (Session["cartList"] != null)
            {
                ViewBag.cartCount = ((List<tbProduct>)Session["cartList"]).Sum(c => c.iCount);
            }
            var guestOrder = new tbGuestOrder
            {
                sAddress = adress,
                sPostalNumber = postnumber,
                sCity = city,
                sEmail = mail,
                sTelephone = telenr,
                iStatus = 1,
                dtOrderDate = DateTime.Today
            };
            _db.tbGuestOrders.InsertOnSubmit(guestOrder);
            _db.SubmitChanges();

            foreach (tbProduct p in ((List<tbProduct>)Session["cartList"]).Distinct())
            {
                var guestProductOrder = new tbGuestProductOrder
                {
                    iGuestOrderID = guestOrder.iID,
                    iProductID = p.iID,
                    iQuantity = ((List<tbProduct>)Session["cartList"]).Count(c => c.iID == p.iID)
                };


                tbProduct product = (from prod in _db.tbProducts
                                     where prod.iID == p.iID
                                     select prod).First();
                product.iItemsSold += guestProductOrder.iQuantity;

                tbUserInfo user = (from u in _db.tbUserInfos
                                 where u.iID == 1
                                 select u).First();
                user.iTotalPurchase += guestProductOrder.iQuantity * p.iPrice;

                guestOrder.iSum += guestProductOrder.iQuantity * p.iPrice ?? default(int);

                _db.tbGuestProductOrders.InsertOnSubmit(guestProductOrder);
                _db.SubmitChanges();
            }

            SendReceipt(0, "Kvitto SWEprotein", "Summa: " + guestOrder.iSum + "\nDatum: " + guestOrder.dtOrderDate + "...en massa annan info");
            var receipt = _db.tbGuestOrders.Where(c => c.iID == guestOrder.iID);

            Session["cartList"] = null;
            return View("CheckOut", receipt); //Gå till för "färdig" betalning
        }

        public void SendReceipt(int id, string subject, string messageBody)
        {
            var emailUser = _db.tbUserInfos.FirstOrDefault(c => c.iUserID == id);
            try
            {
                var message = new MailMessage();
                message.To.Add(emailUser.sEmail);
               
                message.Subject = subject;
                message.From = new MailAddress("gymuser3@gmail.com");
                message.Body = messageBody;
                var smtp = new SmtpClient("smtp.gmail.com", 587)
                {
                    Credentials = new NetworkCredential("gymuser3@gmail.com", "asdf1234!"),
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