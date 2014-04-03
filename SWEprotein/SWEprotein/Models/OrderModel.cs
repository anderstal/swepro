using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SWEprotein.Models
{
    public class OrderModel
    {
        public List<tbOrder> UserOrderList { get; set; }
        public List<tbGuestOrder> GuestOrderList { get; set; }
    }
}