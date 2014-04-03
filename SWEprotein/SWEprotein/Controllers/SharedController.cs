using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using SWEprotein.Models;

namespace SWEprotein.Controllers
{
    public class SharedController : Controller
    {
        //
        // GET: /Shared/
        readonly DataClasses1DataContext _db = new DataClasses1DataContext();
        public ActionResult _TopList()
        {
            var topFive = _db.tbProducts.OrderByDescending(c => c.iItemsSold).Take(5).ToList();
            return View(topFive);
        }

        public ActionResult _Campaign()
        {
            var campaign = _db.tbCampaigns.Take(5).ToList();
            return View(campaign);
        }

        public JsonResult AutoSearch(string term)
        {
            var result = _db.tbProducts.Where(c => c.sName.ToLower().Contains(term.ToLower()));
          
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult AutoComplete(string term)
        {
            var result = (from r in _db.tbProducts
                          where r.sName.ToLower().Contains(term.ToLower())
                          select new { r.sName }).Distinct();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult ProductSearch(string searchString)
        {
            var searchResult = _db.tbProducts.Where(c => c.sName.Contains(searchString));
            return View(searchResult);
        }

   
    }
}
