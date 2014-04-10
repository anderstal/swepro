using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using SWEprotein.Models;

namespace SWEprotein.Controllers
{
    public class ProductController : Controller
    {
        readonly DataClasses1DataContext _db = new DataClasses1DataContext();

        public ActionResult QuickSearch(string term)
        {
            var qry = _db.tbProducts.Where(c => c.sName.ToLower().Contains(term.ToLower()))
                .Take(10)
                .Select(r => new { label = r.sName });
            return Json(qry, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Index()
        {

            var allProducts = _db.tbProducts.DistinctBy(c => c.sName).Where(c => c.iActive != 2).ToList();

            return View(allProducts);

        }

        [HttpPost]
        public ActionResult Index(string searchString)
        {
            if (!String.IsNullOrEmpty(searchString))
            {
                var searchProducts = _db.tbProducts.Where(c => c.sName.ToLower().Contains(searchString.ToLower())).ToList();
                return View(searchProducts);
            }
            var allProducts = _db.tbProducts.Where(c => c.iActive != 2).ToList();

            return View(allProducts);
        }

        public ActionResult Produkt(int id)
        {
            var singleProduct = _db.tbProducts.Where(c => c.iID == id).ToList();

            //Alla smaker från en produkt med ett visst namn

            // var test = _db.tbProducts.First(c => c.iID == id);
            var qry = from a in _db.tbTastes
                      join q in _db.tbProducts.Where(c => c.sName == singleProduct.First().sName)
                          on a.iID equals q.iTaste
                      select a;
            ViewBag.iTaste = new SelectList(qry, "iID", "sTaste");
            //  ViewBag.iTaste = new SelectList(_db.tbTastes, "iID", "sTaste");
            IEnumerable<SelectListItem> quantity = new List<SelectListItem> 
                { 
                    new SelectListItem { Text = "1", Value = "1" },
                    new SelectListItem { Text = "2", Value = "2" },
                    new SelectListItem { Text = "3", Value = "3" },
                       new SelectListItem { Text = "4", Value = "4" },
                    new SelectListItem { Text = "5", Value = "5" },
                    new SelectListItem { Text = "6", Value = "6" },
                       new SelectListItem { Text = "7", Value = "7" },
                    new SelectListItem { Text = "8", Value = "8" },
                    new SelectListItem { Text = "9", Value = "9" },
                
                };
            ViewBag.iQuantity = quantity;
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
            ViewBag.topProduct = sortedProducts.OrderByDescending(c => c.iItemsSold).Take(1);


            return View(sortedProducts);
        }





    }
}
