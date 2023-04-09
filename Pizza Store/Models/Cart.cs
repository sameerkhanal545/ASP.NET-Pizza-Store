using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Pizza_Store.Models
{
    public class Cart
    {
        public int CartID { get; set; }
        public int PizzaID { get; set; }
        public string CustomerID { get; set; }
        public int Quantity { get; set; }

    }
}