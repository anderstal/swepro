﻿using System.Collections.Generic;
using System.Web.Mvc;


namespace SWEprotein.Controllers
{
    public class InfoController : Controller
    {
        //
        // GET: /Info/

        [HttpGet]
        public ActionResult KontaktaOss()
        {
            IEnumerable<SelectListItem> subjects = new List<SelectListItem> 
                { 
                    new SelectListItem { Text = "Produkter", Value = "Produkter" },
                    new SelectListItem { Text = "Betalning", Value = "Betalning" },
                    new SelectListItem { Text = "Övrigt", Value = "Övrigt" },
                
                };
            ViewBag.ddlSubject = subjects;
            return View();

        }
        [HttpPost]
        public ActionResult KontaktaOss(string ddlSubject, string messageBody, string mail)
        {
            IEnumerable<SelectListItem> subjects = new List<SelectListItem> 
                { 
                    new SelectListItem { Text = "Produkter", Value = "Produkter" },
                    new SelectListItem { Text = "Betalning", Value = "Betalning" },
                    new SelectListItem { Text = "Övrigt", Value = "Övrigt" },
                
                };
            ViewBag.ddlSubject = subjects;

            try
            {
                var message = new System.Net.Mail.MailMessage();
                message.To.Add(mail);
                message.Subject = ddlSubject;
                message.From = new System.Net.Mail.MailAddress("gymuser3@gmail.com");
                message.Body = messageBody + "\nSkickat av: " + mail;
                var smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587)
                {
                    Credentials = new System.Net.NetworkCredential("gymuser3@gmail.com", "asdf1234!"),
                    EnableSsl = true
                };

                smtp.Send(message);
                return View("mailskickat");

            }
            catch
            {
                ViewBag.Message = "Något gick fel... Kontrollera din email och försök igen.";
                return View();
            }

        }

        public ActionResult Kostscheman()
        {
            return View();
        }

        public ActionResult Mailskickat()
        {
            return View();
        }

    }
}
