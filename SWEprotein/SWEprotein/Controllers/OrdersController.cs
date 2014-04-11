using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web.Mvc;
using DotNetOpenAuth.OpenId.Extensions.AttributeExchange;
//using PaysonIntegration;
//using PaysonIntegration.Data;
//using PaysonIntegration.Response;
//using PaysonIntegration.Utils;
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

            ViewBag.activeUser = _db.tbUserInfos.Where(c => c.iUserID == WebSecurity.CurrentUserId);

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

            foreach (tbProduct prod in ((List<tbProduct>)Session["cartList"]).Where(c => c.iID == id))
            {
                if (prod.iCount <= 1)
                {
                    tbProducts.RemoveAll(c => c.iID == id);
                    return RedirectToAction("Index", "Product");
                }
                else
                {
                    prod.iCount--;
                    return RedirectToAction("Index", "Product");
                }
            }
            return RedirectToAction("Index", "Product");
        }

        public ActionResult CartAdd(string sName, int iTaste, int iQuantity)
        {
            var findProduct = _db.tbProducts.First(c => c.sName == sName && c.iTaste == iTaste);

            if (Session["cartList"] == null)
            {
                Session["cartList"] = _basket;
            }

            //Kollar om produkten redan finns i listan.
            bool checkCartList = ((List<tbProduct>)Session["cartList"]).Any(c => c.sName == sName && c.iTaste == iTaste);
            if (checkCartList == false)
            {

                ((List<tbProduct>)Session["cartList"]).Add(findProduct);
                var prod = ((List<tbProduct>)Session["cartList"]).Find(c => c.sName == sName && c.iTaste == iTaste);
                prod.iCount = iQuantity;
                return RedirectToAction("Index", "Product");

            }

            foreach (tbProduct prod in ((List<tbProduct>)Session["cartList"]).Where(c => c.sName == sName && c.iTaste == iTaste))
            {
                prod.iCount += iQuantity;
            }

            return RedirectToAction("Index", "Product");

            #region GAMLA MED ID

            //var findProduct = (from f in _db.tbProducts.Where(c => c.iID == id) select f).FirstOrDefault();

            //if (Session["cartList"] == null)
            //{
            //    Session["cartList"] = _basket;
            //}

            ////Kollar om produkten redan finns i listan.
            //bool checkCartList = ((List<tbProduct>) Session["cartList"]).Any(c => c.iID == id);
            //if (checkCartList == false)
            //{
            //    ((List<tbProduct>) Session["cartList"]).Add(findProduct);
            //    return RedirectToAction("Index", "Product");

            //}
            //foreach (tbProduct prod in ((List<tbProduct>) Session["cartList"]).Where(c => c.iID == id))
            //{
            //    prod.iCount++;
            //}

            //return RedirectToAction("Index", "Product");

            #endregion
        }

        public ActionResult CheckOut()
        {
            if (WebSecurity.IsAuthenticated)
            {
                return View("GuestOrder");
            }

            var order = new tbOrder
            {
                iUserID = WebSecurity.CurrentUserId,
                iStatus = 3,
                iSum = ((List<tbProduct>)Session["cartList"]).Sum(prod => prod.iPrice * prod.iCount),
                dtOrderDate = DateTime.Now

            };

            _db.tbOrders.InsertOnSubmit(order);
            _db.SubmitChanges();
            foreach (tbProduct prod in ((List<tbProduct>)Session["cartList"]))
            {
                var prodOrder = new tbProductOrder
                {
                    iOrderID = order.iID,
                    iProductID = prod.iID,
                    iQuantity = (int)prod.iCount,
                    iPrice = prod.iPrice
                };
                _db.tbProductOrders.InsertOnSubmit(prodOrder);

            }


            foreach (tbProduct prod in ((List<tbProduct>)Session["cartList"]))
            {
                tbProduct prod1 = prod;
                foreach (tbProduct pr in _db.tbProducts.Where(c => c.iID == prod1.iID))
                {
                    pr.iItemsSold += prod1.iCount;
                    pr.iStockBalance -= prod1.iCount;
                }
            }
            _db.SubmitChanges();
            SendReceipt(order.iUserID, "Kvitto SWEprotein", "Summa: " + order.iSum + "\nDatum: " + order.dtOrderDate + "...en massa annan info");
            var receipt = _db.tbOrders.Where(c => c.iUserID == order.iUserID && c.iID == order.iID);

            return View(receipt); //Gå till för "färdig" betalning
        }

        public ActionResult GuestOrder(string fnamn, string enamn, string mail, string telenr, string adress, string postnumber, string city)
        {
            if (Session["cartList"] != null)
            {
                ViewBag.cartCount = ((List<tbProduct>)Session["cartList"]).Sum(c => c.iCount);
            }

            var guestUser = new tbUserInfo
            {
                iUserID = 2,
                sFirstName = fnamn,
                sLastName = enamn,
                sAdress = adress,
                sPostalNumber = postnumber,
                sCity = city,
                sEmail = mail,
                sTelephone = telenr,
                iTotalPurchase = 0,
                iNewsOffers = 0
            };
            _db.tbUserInfos.InsertOnSubmit(guestUser);
            _db.SubmitChanges();

            var order = new tbOrder
            {
                iUserID = 2,
                iStatus = 1,
                iSum = ((List<tbProduct>)Session["cartList"]).Sum(prod => prod.iPrice * prod.iCount),
                dtOrderDate = DateTime.Now
            };

            _db.tbOrders.InsertOnSubmit(order);
            _db.SubmitChanges();
	    
	        SendReceipt(order.iUserID, "Kvitto SWEprotein", "Summa: " + order.iSum + "\nDatum: " + order.dtOrderDate + "...en massa annan info");
            var receipt = _db.tbOrders.Where(c => c.iUserID == order.iUserID && c.iID == order.iID);
		
	    return View("CheckOut", receipt);
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

        //public ActionResult CheckOut2(tbUserInfo u)
        //{

        //    const decimal sum = 5;

        //    //var paysonApi = new PaysonApi("20516", "d615e80b-4ad4-4c46-a88e-7cffc66ab4b2");
        //    var paysonApi = new PaysonApi("4", "2acab30d-fe50-426f-90d7-8c60a7eb31d4");
        //    var paymentSender = new Sender(u.sEmail) {FirstName = u.sFirstName, LastName = u.sLastName};

        //    var receivers = new List<Receiver>
        //    {
        //        //new Receiver("gymoskar@gmail.com", sum)
        //        new Receiver("testagent-1@payson.se", sum)
        //    };

        //    var payData = new PayData("www.google.se", "www.facebook.com", "SWEprotein", paymentSender, receivers);

        //    payData.SetIpnNotificationUrl("ipn_notification_url");
        //    payData.SetCurrencyCode("SEK");
        //    payData.FeesPayer = FeesPayer.Sender;

        //    PayResponse payResponse = paysonApi.MakePayRequest(payData);

        //    if (payResponse.Success)
        //    {
        //        Response.Redirect(paysonApi.GetForwardPayUrl(payResponse.Token));
        //    }
        //    //För att få info om betalningen
        //    //var paymentDetailsData = new PaymentDetailsData(payResponse.Token);
        //    //var paymentDetailsResponse = paysonApi.MakePaymentDetailsRequest(paymentDetailsData);

        //    return View();
        //}
    }
}