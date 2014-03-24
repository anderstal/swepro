﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using SWEprotein.Models;

namespace SWEprotein.Controllers
{
    public class ProductController : Controller
    {
        readonly DataClasses1DataContext _db = new DataClasses1DataContext();
        public ActionResult Index()
        {
            if (Session["cartList"] != null)
            {
                ViewBag.cartCount = ((List<tbProduct>)Session["cartList"]).Sum(c => c.iCount);
            }
            var allProducts = _db.tbProducts.ToList();

            return View(allProducts);
        }

        public ActionResult Produkt(int id)
        {
            var singleProduct = _db.tbProducts.Where(c => c.iID == id);
            return View(singleProduct);
        }
        public ActionResult Topplistan()
        {
            var topProducts = _db.tbProducts.OrderByDescending(c => c.iItemsSold).Take(8);
            return View(topProducts);
        }


        public ActionResult Campaign(int id)
        {
            var campaignProducts = _db.tbProducts.Where(c => c.iCampaign == id);
            return View(campaignProducts);
        }

        public ActionResult Sortiment(int id)
        {
            var sortedProducts = _db.tbProducts.Where(c => c.iProductType == id);
            return View(sortedProducts);
        }
        public JsonResult AutoSearch(string term)
        {
            var result = _db.tbProducts.Where(c => c.sName.ToLower().Contains(term.ToLower()));

            return Json(result, JsonRequestBehavior.AllowGet);
        }

   
      
    }
}
