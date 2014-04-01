using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Net;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using SWEprotein.Models;

namespace SWEprotein.Controllers
{

    public class AdminController : Controller
    {
        //
        // GET: /Admin/
        private readonly DataClasses1DataContext _db = new DataClasses1DataContext();

        public ActionResult Index()
        {

            return View();
        }


        public ActionResult Products()
        {
            var productList = _db.tbProducts;
            return View(productList);
        }

        public ActionResult Orders()
        {
            var orderList = _db.tbOrders.OrderBy(c => c.iStatus);
            return View(orderList);
        }

        public ActionResult Users()
        {
            var userList = _db.UserInfos;
            return View(userList);
        }

        public ActionResult ProductType()
        {
            var typeList = _db.tbProductTypes;
            return View(typeList);
        }

        public ActionResult LagerSaldo()
        {
            var saldo = _db.tbProducts.OrderBy(c => c.iStockBalance);
            return View(saldo);
        }

        public ActionResult Economy()
        {
            throw new NotImplementedException();
        }

        public ActionResult Campaigns()
        {
            var campaignList = _db.Campaigns.ToList();
            return View(campaignList);
        }

        #region CAMPAIGN
        public ActionResult EditCampaign(int id)
        {
            var singleCampaign = _db.Campaigns.FirstOrDefault(c => c.iID == id);
            return View(singleCampaign);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCampaign(Campaign camp)
        {
            foreach (Campaign ty in _db.Campaigns.Where(c => c.iID == camp.iID))
            {
                ty.sName = camp.sName;
                ty.imgURL = camp.imgURL;
                _db.SubmitChanges();
                return RedirectToAction("Campaigns");
            }
            return RedirectToAction("Campaigns");
        }

      
        public ActionResult DeleteCampaign(int id)
        {
            var singleCampaign = _db.Campaigns.FirstOrDefault(c => c.iID == id);
            if (singleCampaign == null)
            {
                return HttpNotFound();
            }
            return View(singleCampaign);

        }

        [HttpPost, ActionName("DeleteCampaign")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmedC(int id)
        {
            var singleCampaign = (from f in _db.Campaigns.Where(c => c.iID == id) select f).FirstOrDefault();
            _db.Campaigns.DeleteOnSubmit(singleCampaign);

            _db.SubmitChanges();
            return RedirectToAction("Campaigns");
        }
        [HttpGet]
        public ActionResult CreateCampaign()
        {

            return View();
        }

        [HttpPost]
        public ActionResult CreateCampaign(Campaign camp, HttpPostedFileBase file)
        {
            string fileString = null;
            try
            {
                _db.Campaigns.InsertOnSubmit(camp);
                _db.SubmitChanges();
                var fileName = Path.GetFileName(file.FileName);
                if (fileName != null)
                {
                    var path = Path.Combine(Server.MapPath("/images/campaign"), fileName);
                    fileString = fileName;
                    file.SaveAs(path);

                }
                var campish = _db.Campaigns.Where(c => c.iID == camp.iID);
                foreach (Campaign p in campish)
                {
                    p.imgURL = string.Format("/images/campaign/{0}", fileString);
              
                    _db.SubmitChanges();
                }

                return RedirectToAction("Campaigns");
            }
            catch (Exception)
            {
                ViewBag.ErrorMessage = "Något gick fel... Försök igen!";

            }
            return View();
        }

        #endregion
        #region ORDERS

        public ActionResult EditOrder(int id)
        {
            var singleOrder = _db.tbOrders.FirstOrDefault(c => c.iID == id);
            return View(singleOrder);
        }
          [HttpPost]
        public ActionResult EditOrder(tbOrder order)
        {
              foreach (tbOrder or in _db.tbOrders.Where(c => c.iID == order.iID))
              {
                  or.dtOrderDate = order.dtOrderDate;
                  or.iStatus = order.iStatus;
                  or.iSum = order.iSum;
                  or.UserID = order.UserID;
                  _db.SubmitChanges();
                  return RedirectToAction("Orders");
              }

              return RedirectToAction("Orders");
        }

      

        public ActionResult DeleteOrder(int id)
        {
            var singleOrder = _db.tbOrders.FirstOrDefault(c => c.iID == id);
            if (singleOrder == null)
            {
                return HttpNotFound();
            }
            return View(singleOrder);

        }

        [HttpPost, ActionName("DeleteOrder")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmedO(int id)
        {
            var singleOrder = (from f in _db.tbOrders.Where(c => c.iID == id) select f).FirstOrDefault();
            _db.tbOrders.DeleteOnSubmit(singleOrder);
           
            _db.SubmitChanges();
            return RedirectToAction("Orders");
        }
        
        public ActionResult SendOrder(int id)
        {
            var singleOrder = (from o in _db.tbOrders.Where(c => c.iID == id) select o);
            foreach (tbOrder or in singleOrder)
            {
                or.iStatus = 2;
                _db.SubmitChanges();
                return RedirectToAction("Orders");
            }
            return RedirectToAction("Orders");
        }
        #endregion
        #region PRODUCTS

        public ActionResult EditProduct(int id)
        {
            ViewBag.iProductType = new SelectList(_db.tbProductTypes, "iID", "sName");
            ViewBag.iCampaign = new SelectList(_db.Campaigns, "iID", "sName");
            var singleProduct = _db.tbProducts.FirstOrDefault(c => c.iID == id);
            return View(singleProduct);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProduct(tbProduct product)
        {
            ViewBag.iProductType = new SelectList(_db.tbProductTypes, "iID", "sName");
            ViewBag.iCampaign = new SelectList(_db.Campaigns, "iID", "sName");
          
            foreach (tbProduct pr in _db.tbProducts.Where(c => c.iID == product.iID))
            {
                pr.sName = product.sName;
                pr.sDescription = product.sDescription;
                pr.sMoreInfo = product.sMoreInfo;
                pr.iStockBalance = product.iStockBalance;
                pr.iProductType = product.iProductType; //Bytas ut mot dropdown
                pr.sPicture = product.sPicture; //Bytas ut mot fileupload + ta bort gamla bilden(?)
                pr.iTaste = product.iTaste; //Bytas ut mot checkboxes vilka smaker som finns
                pr.iCampaign = product.iCampaign;
               
               
                _db.SubmitChanges();
                return RedirectToAction("Products");
            }
            return RedirectToAction("Products");
        }
     

      public ActionResult DeleteProduct(int id)
        {
            var singleProduct = _db.tbProducts.FirstOrDefault(c => c.iID == id);
            if (singleProduct == null)
            {
                return HttpNotFound();
            }
            return View(singleProduct);

        }

        [HttpPost, ActionName("DeleteProduct")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmedP(int id)
        {
            var singleProduct = (from f in _db.tbProducts.Where(c => c.iID == id) select f).FirstOrDefault();
                _db.tbProducts.DeleteOnSubmit(singleProduct);
           
            _db.SubmitChanges();
            return RedirectToAction("Products");
        }
        
        [HttpGet]
        public ActionResult CreateProduct()
        {
            ViewBag.iProductType = new SelectList(_db.tbProductTypes, "iID", "sName");
            ViewBag.iCampaign = new SelectList(_db.Campaigns, "iID", "sName");
           // ViewBag.iTaste = new SelectList(_db.Tastes, "iID", "sTaste");
            ViewBag.iTaste = _db.Tastes.ToList();
            return View();
        }
        [HttpPost]
        public ActionResult CreateProduct(tbProduct product, HttpPostedFileBase file)
        {
           
            ViewBag.iProductType = new SelectList(_db.tbProductTypes, "iID", "sName");
            ViewBag.iCampaign = new SelectList(_db.Campaigns, "iID", "sName");
         //   ViewBag.iTaste = new SelectList(_db.Tastes, "iID", "sTaste");
            ViewBag.iTaste = _db.Tastes.ToList();
              string fileString = null;
            try
            {
            
                _db.tbProducts.InsertOnSubmit(product);             
                _db.SubmitChanges();
                var fileName = Path.GetFileName(file.FileName);
                if (fileName != null)
                {
                    var path = Path.Combine(Server.MapPath("/images/products"), fileName);
                    fileString = fileName;
                    file.SaveAs(path);
                   
                }
                var prod = _db.tbProducts.Where(c => c.iID == product.iID);
                foreach (tbProduct p in prod)
                {
                    p.sPicture = string.Format("/images/products/{0}", fileString);
                    p.iCount = 1;
                    _db.SubmitChanges();
                }

                return RedirectToAction("Products");
            }
            catch (Exception)
            {
                ViewBag.ErrorMessage = "Något gick fel... Försök igen!";

            }
          
          
            return View();
        }

        #endregion
        #region PRODUCT TYPES

        public ActionResult EditProductType(int id)
        {
            ViewBag.iProductCategory = new SelectList(_db.tbProductCategories, "iID", "sName");
            var singleProductType = _db.tbProductTypes.FirstOrDefault(c => c.iID == id);
            return View(singleProductType);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProductType(tbProductType type)
        {
            ViewBag.iProductCategory = new SelectList(_db.tbProductCategories, "iID", "sName");
            foreach (tbProductType ty in _db.tbProductTypes.Where(c => c.iID == type.iID))
            {
                ty.sName = type.sName;
                ty.iProductCategory = type.iProductCategory;
                _db.SubmitChanges();
               return RedirectToAction("ProductType");
            }
            return RedirectToAction("ProductType");
        }

      

        public ActionResult DeleteProductType(int id)
        {
            var singleProductType = _db.tbProductTypes.FirstOrDefault(c => c.iID == id);
            if (singleProductType == null)
            {
                return HttpNotFound();
            }
            return View(singleProductType);

        }

        [HttpPost, ActionName("DeleteProductType")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var singleProductType = (from f in _db.tbProductTypes.Where(c => c.iID == id) select f).FirstOrDefault();
                _db.tbProductTypes.DeleteOnSubmit(singleProductType);
           
            _db.SubmitChanges();
            return RedirectToAction("ProductType");
        }
        [HttpGet]
        public ActionResult CreateProductType()
        {
            ViewBag.iProductCategory = new SelectList(_db.tbProductCategories, "iID", "sName");
            return View();
        }
        [HttpPost]
        public ActionResult CreateProductType(tbProductType productType)
        {
            ViewBag.iProductCategory = new SelectList(_db.tbProductCategories, "iID", "sName");
        
            if (ModelState.IsValid)
            {
                _db.tbProductTypes.InsertOnSubmit(productType);
                _db.SubmitChanges();
              return  RedirectToAction("ProductType");
            }
            return View();
        }

        #endregion
        #region USERINFO

        public ActionResult EditUserInfo(int id)
        {
            var singleUserInfo = _db.UserInfos.FirstOrDefault(c => c.UserID == id);
            return View(singleUserInfo);
        }
        [HttpPost]
        public ActionResult EditUserInfo(UserInfo userInfo)
        {
            foreach (UserInfo or in _db.UserInfos.Where(c => c.UserID == userInfo.iID))
            {
                or.Adress = userInfo.Adress;
                or.iTotalPurchase = userInfo.iTotalPurchase;
                or.PostalNumber = userInfo.PostalNumber;
                or.sEmail = userInfo.sEmail;
                or.sTelephone = userInfo.sTelephone;
                or.sCity = userInfo.sCity;
             
                _db.SubmitChanges();
                return RedirectToAction("Users");
            }

            return RedirectToAction("Users");
        }

     

        public ActionResult DeleteUserInfo(int id)
        {
            var singleUserInfo = _db.UserInfos.FirstOrDefault(c => c.UserID == id);
            if (singleUserInfo == null)
            {
                return HttpNotFound();
            }
            return View(singleUserInfo);

        }

        [HttpPost, ActionName("DeleteUserInfo")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmedU(int id)
        {
            var singleUserInfo = (from f in _db.UserInfos.Where(c => c.UserID == id) select f).FirstOrDefault();
            _db.UserInfos.DeleteOnSubmit(singleUserInfo);

            _db.SubmitChanges();
            return RedirectToAction("Users");
        }

       
        #endregion

        public ActionResult RefillStock(int id, int stockRefill)
        {
            var stock = _db.tbProducts.Where(c => c.iID == id);
            foreach (tbProduct p in stock)
            {
                p.iStockBalance += stockRefill;
                _db.SubmitChanges();
              return  RedirectToAction("LagerSaldo");
            }
        return    RedirectToAction("LagerSaldo");
        }

        public ActionResult InfoOrder(int id)
        {
            var orderProducts = _db.tbProductOrders.Where(c => c.iOrderID == id).OrderBy(c => c.tbOrder.dtOrderDate);
            var whoOrder = _db.tbOrders.First(c => c.iID == id);

            var orderShipInfo = _db.UserInfos.Where(c => c.UserID == whoOrder.UserID);
            ViewBag.orderInfo = orderShipInfo;
            return View(orderProducts);

        }
    }
}
   