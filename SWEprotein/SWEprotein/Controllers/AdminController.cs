using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SWEprotein.Models;

namespace SWEprotein.Controllers
{

    public class AdminController : Controller
    {
        //

        // ssjsjsjsj
        // GET: /Admin/
        private readonly DataClasses1DataContext _db = new DataClasses1DataContext();

        #region RETURN LISTS

        public ActionResult Index()
        {

            return View();
        }


        public ActionResult Products()
        {
            var productList = _db.tbProducts.Where(c => c.iActive == 1);
            return View(productList);
        }
        public ActionResult OldProducts()
        {
            var oldProductList = _db.tbProducts.Where(c => c.iActive == 2);
            return View(oldProductList);
        }
        public ActionResult ProductTaste()
        {
            var tasteList = _db.tbTastes;
            return View(tasteList);
        }
        public ActionResult Orders()
        {
            var orderList = _db.tbOrders.OrderBy(c => c.iStatus);
            return View(orderList);
        }

        public ActionResult Users()
        {
            var userList = _db.tbUserInfos;
            return View(userList);
        }

        public ActionResult ProductType()
        {
            var typeList = _db.tbProductTypes;
            return View(typeList);
        }

        public ActionResult ProductCategory()
        {
            var categoryList = _db.tbProductCategories;
            return View(categoryList);
        }

        public ActionResult LagerSaldo()
        {
            var saldo = _db.tbProducts.OrderBy(c => c.iStockBalance);
            return View(saldo);
        }

        #endregion


        #region ECONOMY

        [HttpGet]
        public ActionResult Economy(string searchString)
        {
            ViewBag.ddlProductType = new SelectList(_db.tbProductTypes.OrderBy((c => c.sName)), "iID", "sName");
            IEnumerable<SelectListItem> ddlTopProductsAmount = new List<SelectListItem>
            {
                new SelectListItem {Text = "1", Value = "1"},
                new SelectListItem {Text = "2", Value = "2"},
                new SelectListItem {Text = "3", Value = "3"},
                new SelectListItem {Text = "4", Value = "4"}, 
                new SelectListItem {Text = "5", Value = "5"},
            };
            ViewBag.ddlTopProductsAmount = ddlTopProductsAmount;

            return View();
        }

        [HttpPost]
        public ActionResult Economy(DateTime? fromDate, DateTime? toDate, string ddlProductType, string ddlTopProductsAmount, string searchString)
        {
            var searchedProducts = from f in _db.tbProducts
                                   select f;
            if (!String.IsNullOrEmpty(searchString))
            {
                searchedProducts =
                    searchedProducts.Where(c => c.sName.Contains(searchString) || c.sProductBrand.Contains(searchString))
                        .Take(10);

                return View(searchedProducts.ToList());
            }   

            //populerar dropdownlistor
            IEnumerable<SelectListItem> ddlTopProductsAmount2 = new List<SelectListItem>
            {
                new SelectListItem {Text = "1", Value = "1"},
                new SelectListItem {Text = "2", Value = "2"},
                new SelectListItem {Text = "3", Value = "3"},
                new SelectListItem {Text = "4", Value = "4"},
                new SelectListItem {Text = "5", Value = "5"},
            };
            ViewBag.ddlTopProductsAmount = ddlTopProductsAmount2;
            ViewBag.ddlProductType = new SelectList(_db.tbProductTypes.OrderBy((c => c.sName)), "iID", "sName");
            ViewBag.ddlTopProductsAmount = ddlTopProductsAmount;
            //sparar valda datum
            ViewBag.fromDate = fromDate;
            ViewBag.toDate = toDate;

            if (fromDate == null && toDate == null)
            {
                //var products = from f in _db.tbProducts
                //               select f;
                //ViewBag.products = products;
                ViewBag.errorMessage = "Välj mellan vilka datum";
                ViewBag.Date = DateTime.Now;
                ViewBag.StringDate = DateTime.Today.ToString("yyyy/MM/dd");
                return View();
            }

            if (fromDate != null && toDate != null)
            {
                //Fråga som summerar totalinkomsten per order mellan valda datum
                var salesIncomeChosenPeriod = _db.tbOrders.Where(c => c.dtOrderDate >= fromDate && c.dtOrderDate <= toDate).Sum(c => c.iSum);
                ViewBag.income = salesIncomeChosenPeriod;

                //Fråga som tar visar hur många ordrar som är beställt mellan valda datum
                var totalOrdersChosenPeriod = _db.tbOrders.Where(c => c.dtOrderDate >= fromDate && c.dtOrderDate <= toDate);
                ViewBag.totalOrders = totalOrdersChosenPeriod.Count();

                //fråga som visar antal sålda produkter mellan valda datum
                var totalSoldProductsChosenPeriod = _db.tbProductOrders.Where(c => c.tbOrder.dtOrderDate >= fromDate && c.tbOrder.dtOrderDate <= toDate);
                ViewBag.totalProductsSold = totalSoldProductsChosenPeriod.Count();

                //fråga som tar fram medelinkomst per order.
                var averageIncomeOrder = _db.tbOrders.Where(c => c.dtOrderDate >= fromDate && c.dtOrderDate <= toDate).Average(c => c.iSum);
                ViewBag.average = averageIncomeOrder;

                //fråga som tar fram mest sålda produkter i antal efter admins önskan   
                try
                {
                    var mostSoldProduct = _db.tbProductOrders.Where(c => c.tbOrder.dtOrderDate >= fromDate && c.tbOrder.dtOrderDate <= toDate)
                                            .OrderByDescending(c => c.tbProduct.iItemsSold).Take(int.Parse(ddlTopProductsAmount));
                    ViewBag.mostSoldProducts = mostSoldProduct;
                }
                catch
                {
                    return View();
                }

                var allProductsSoldChosenPeriod =
                         _db.tbProductOrders.Where(c => c.tbOrder.dtOrderDate >= fromDate && c.tbOrder.dtOrderDate <= toDate).ToList();
                ViewBag.allproducts = allProductsSoldChosenPeriod;

                return View();
            }

            return View();
        }
        [HttpGet]
        public ActionResult ProductEconomy(int? id)
        {
            var productOrdered = _db.tbProductOrders.Where(c => c.tbProduct.iID == id).Count();
            ViewBag.productOrdered = productOrdered;

            var productIncome = _db.tbProductOrders.Where(c => c.tbProduct.iID == id).Sum(c => c.tbOrder.iSum);
            ViewBag.productIncome = productIncome;

            var itemsSoldProduct = _db.tbProducts.Where(c => c.iID == id).Select(c => c.iItemsSold).First();
            ViewBag.itemsSoldProduct = itemsSoldProduct;

            var productPicture = _db.tbProducts.Where(c => c.iID == id).Select(c => c.sPicture).FirstOrDefault();
            ViewBag.picture = productPicture;

            var economyOfChosenProduct = _db.tbProducts.Where(c => c.iID == id);

            return View(economyOfChosenProduct.Select(c => c.sName));
            //return View();
        }
        [HttpPost]
        public ActionResult ProductEconomy(int id, DateTime? fromDate, DateTime? toDate)
        {
            var productOrdered =
                _db.tbProductOrders.Where(c => c.tbOrder.dtOrderDate >= fromDate && c.tbOrder.dtOrderDate <= toDate && c.tbProduct.iID == id).Count();
            ViewBag.productOrdered = productOrdered;

            var productIncome = _db.tbProductOrders.Where(c => c.tbOrder.dtOrderDate >= fromDate && c.tbOrder.dtOrderDate <= toDate && c.tbProduct.iID == id).Sum(c => c.tbOrder.iSum);
            ViewBag.productIncome = productIncome;

            var itemsSoldProduct = _db.tbProductOrders.Where(
                    c => c.tbOrder.dtOrderDate >= fromDate && c.tbOrder.dtOrderDate <= toDate && c.tbProduct.iID == id)
                    .Select(c => c.tbProduct.iItemsSold)
                    .First();
            ViewBag.itemsSoldProduct = itemsSoldProduct;

            var productPicture = _db.tbProducts.Where(c => c.iID == id).Select(c => c.sPicture);
            ViewBag.picture = productPicture;

            var economyOfChosenProduct = _db.tbProducts.Where(c => c.iID == id);

            return View(economyOfChosenProduct.Select(c => c.sName));
        }

        #endregion

        #region CAMPAIGN
        public ActionResult Campaigns()
        {
            var campaignList = _db.tbCampaigns.ToList();
            return View(campaignList);
        }


        public ActionResult EditCampaign(int id)
        {
            var singleCampaign = _db.tbCampaigns.FirstOrDefault(c => c.iID == id);
            return View(singleCampaign);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCampaign(tbCampaign camp)
        {
            foreach (tbCampaign ty in _db.tbCampaigns.Where(c => c.iID == camp.iID))
            {
                ty.sName = camp.sName;
                ty.sImgURL = camp.sImgURL;
                _db.SubmitChanges();
                return RedirectToAction("Campaigns");
            }
            return RedirectToAction("Campaigns");
        }


        public ActionResult DeleteCampaign(int id)
        {
            var singleCampaign = _db.tbCampaigns.FirstOrDefault(c => c.iID == id);
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
            var singleCampaign = (from f in _db.tbCampaigns.Where(c => c.iID == id) select f).FirstOrDefault();
            _db.tbCampaigns.DeleteOnSubmit(singleCampaign);

            _db.SubmitChanges();
            return RedirectToAction("Campaigns");
        }
        [HttpGet]
        public ActionResult CreateCampaign()
        {

            return View();
        }

        [HttpPost]
        public ActionResult CreateCampaign(tbCampaign camp, HttpPostedFileBase file)
        {
            string fileString = null;
            try
            {
                _db.tbCampaigns.InsertOnSubmit(camp);
                _db.SubmitChanges();
                var fileName = Path.GetFileName(file.FileName);
                if (fileName != null)
                {
                    var path = Path.Combine(Server.MapPath("/Images/Campaign"), fileName);
                    fileString = fileName;
                    file.SaveAs(path);


                }
                var campish = _db.tbCampaigns.Where(c => c.iID == camp.iID);
                foreach (tbCampaign p in campish)
                {
                    p.sImgURL = string.Format("/Images/Campaign/{0}", fileString);

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
            ViewBag.iStatus = new SelectList(_db.tbStatus, "iID", "sStatus");
            var singleOrder = _db.tbOrders.FirstOrDefault(c => c.iID == id);
            return View(singleOrder);
        }
        [HttpPost]
        public ActionResult EditOrder(tbOrder order)
        {
            ViewBag.iStatus = new SelectList(_db.tbStatus, "iID", "sStatus");
            foreach (tbOrder or in _db.tbOrders.Where(c => c.iID == order.iID))
            {
                or.dtOrderDate = order.dtOrderDate;
                or.iStatus = order.iStatus;
                or.iSum = order.iSum;
                or.iUserID = order.iUserID;
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
                or.iStatus = 4;
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
            ViewBag.iCampaign = new SelectList(_db.tbCampaigns, "iID", "sName");
            ViewBag.iActive = new SelectList(_db.tbActives, "iID", "sName");
            var singleProduct = _db.tbProducts.FirstOrDefault(c => c.iID == id);
            return View(singleProduct);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProduct(tbProduct product)
        {
            ViewBag.iActive = new SelectList(_db.tbActives, "iID", "sName");
            ViewBag.iProductType = new SelectList(_db.tbProductTypes, "iID", "sName");
            ViewBag.iCampaign = new SelectList(_db.tbCampaigns, "iID", "sName");

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
                pr.iActive = product.iActive;

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
            ViewBag.iCampaign = new SelectList(_db.tbCampaigns, "iID", "sName");
            ViewBag.iTaste = new SelectList(_db.tbTastes, "iID", "sTaste");
            ViewBag.iProductCategory = new SelectList(_db.tbProductCategories, "iID", "sName");
            ViewBag.iActive = new SelectList(_db.tbActives, "iID", "sName");
            return View();
        }
        [HttpPost]
        public ActionResult CreateProduct(tbProduct product, HttpPostedFileBase file)
        {

            ViewBag.iProductType = new SelectList(_db.tbProductTypes, "iID", "sName");
            ViewBag.iCampaign = new SelectList(_db.tbCampaigns, "iID", "sName");
            ViewBag.iTaste = new SelectList(_db.tbTastes, "iID", "sTaste");
            ViewBag.iProductCategory = new SelectList(_db.tbProductCategories, "iID", "sName");
            ViewBag.iActive = new SelectList(_db.tbActives, "iID", "sName");
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
                    p.iItemsSold = 0;
                    p.iPoints = 0;
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

            if (!ModelState.IsValid) return View();
            _db.tbProductTypes.InsertOnSubmit(productType);
            _db.SubmitChanges();
            return RedirectToAction("ProductType");
        }

        #endregion
        #region USERINFO

        public ActionResult EditUserInfo(int id)
        {
            var singleUserInfo = _db.tbUserInfos.FirstOrDefault(c => c.iUserID == id);
            return View(singleUserInfo);
        }
        [HttpPost]
        public ActionResult EditUserInfo(tbUserInfo userInfo)
        {
            foreach (tbUserInfo or in _db.tbUserInfos.Where(c => c.iUserID == userInfo.iID))
            {
                or.sAdress = userInfo.sAdress;
                or.iTotalPurchase = userInfo.iTotalPurchase;
                or.sPostalNumber = userInfo.sPostalNumber;
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
            var singleUserInfo = _db.tbUserInfos.FirstOrDefault(c => c.iUserID == id);
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
            var singleUserInfo = (from f in _db.tbUserInfos.Where(c => c.iUserID == id) select f).FirstOrDefault();
            _db.tbUserInfos.DeleteOnSubmit(singleUserInfo);

            _db.SubmitChanges();
            return RedirectToAction("Users");
        }


        #endregion
        #region PRODUCT CATEGORIES

        public ActionResult EditProductCategory(int id)
        {

            var singleProductType = _db.tbProductCategories.FirstOrDefault(c => c.iID == id);
            return View(singleProductType);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProductCategory(tbProductCategory type)
        {

            foreach (tbProductCategory ty in _db.tbProductCategories.Where(c => c.iID == type.iID))
            {
                ty.sName = type.sName;

                _db.SubmitChanges();
                return RedirectToAction("ProductCategory");
            }
            return RedirectToAction("ProductCategory");
        }



        public ActionResult DeleteProductCategory(int id)
        {
            var singleProductType = _db.tbProductCategories.FirstOrDefault(c => c.iID == id);
            if (singleProductType == null)
            {
                return HttpNotFound();
            }
            return View(singleProductType);

        }

        [HttpPost, ActionName("DeleteProductCategory")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmedCat(int id)
        {
            var singleProductType = (from f in _db.tbProductCategories.Where(c => c.iID == id) select f).FirstOrDefault();
            _db.tbProductCategories.DeleteOnSubmit(singleProductType);

            _db.SubmitChanges();
            return RedirectToAction("ProductCategory");
        }
        [HttpGet]
        public ActionResult CreateProductCategory()
        {
            ViewBag.iProductCategory = new SelectList(_db.tbProductCategories, "iID", "sName");
            return View();
        }
        [HttpPost]
        public ActionResult CreateProductCategory(tbProductCategory productType)
        {
            ViewBag.iProductCategory = new SelectList(_db.tbProductCategories, "iID", "sName");

            if (ModelState.IsValid)
            {
                _db.tbProductCategories.InsertOnSubmit(productType);
                _db.SubmitChanges();
                return RedirectToAction("ProductCategory");
            }
            return View();
        }

        #endregion
        #region PRODUCT TASTE

        public ActionResult EditProductTaste(int id)
        {

            var singleTaste = _db.tbTastes.FirstOrDefault(c => c.iID == id);
            return View(singleTaste);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProductTaste(tbTaste taste)
        {

            foreach (tbTaste ty in _db.tbTastes.Where(c => c.iID == taste.iID))
            {
                ty.sTaste = taste.sTaste;

                _db.SubmitChanges();
                return RedirectToAction("ProductTaste");
            }
            return RedirectToAction("ProductTaste");
        }



        public ActionResult DeleteProductTaste(int id)
        {
            var singleTaste = _db.tbTastes.FirstOrDefault(c => c.iID == id);
            if (singleTaste == null)
            {
                return HttpNotFound();
            }
            return View(singleTaste);

        }

        [HttpPost, ActionName("DeleteProductTaste")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmedT(int id)
        {
            var singleTaste = (from f in _db.tbTastes.Where(c => c.iID == id) select f).FirstOrDefault();
            _db.tbTastes.DeleteOnSubmit(singleTaste);

            _db.SubmitChanges();
            return RedirectToAction("ProductTaste");
        }
        [HttpGet]
        public ActionResult CreateProductTaste()
        {

            return View();
        }
        [HttpPost]
        public ActionResult CreateProductTaste(tbTaste productTaste)
        {


            if (ModelState.IsValid)
            {
                _db.tbTastes.InsertOnSubmit(productTaste);
                _db.SubmitChanges();
                return RedirectToAction("ProductTaste");
            }
            return View();
        }

        #endregion
        public ActionResult RefillStock(int id, int stockRefill)
        {
            var stock = _db.tbProducts.Where(c => c.iID == id);
            foreach (tbProduct p in stock)
            {
                p.iStockBalance += stockRefill;
                _db.SubmitChanges();
                return RedirectToAction("LagerSaldo");
            }
            return RedirectToAction("LagerSaldo");
        }

        public ActionResult InfoOrder(int id)
        {
            var orderProducts = _db.tbProductOrders.Where(c => c.iOrderID == id).OrderBy(c => c.tbOrder.dtOrderDate).ThenBy(c => c.tbOrder.dtOrderDate);
            var whoOrder = _db.tbOrders.First(c => c.iID == id);

            var orderShipInfo = _db.tbUserInfos.Where(c => c.iUserID == whoOrder.iUserID);
            ViewBag.orderInfo = orderShipInfo;
            return View(orderProducts);

        }
    }
}
