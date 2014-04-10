using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using SWEprotein.Models;

namespace SWEprotein.Controllers
{
    public class SharedController : Controller
    {
        //
        // GET: /Shared/
        readonly DataClasses1DataContext _db = new DataClasses1DataContext();





        public ActionResult _Kundkorg()
        {
            if (Session["cartList"] != null)
            {
                ViewBag.BasketCount = ((List<tbProduct>)Session["cartList"]).Count;
                ViewBag.BasketList = ((List<tbProduct>)Session["cartList"]).ToList();
                ViewBag.BasketCost = ((List<tbProduct>)Session["cartList"]).Sum(prod => prod.iPrice * prod.iCount);

                return View();
            }
            else
                ViewBag.BasketCount = "0";
            ViewBag.BasketList = "";
            ViewBag.BasketCost = "0";
            return View();

        }

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






    }
}
