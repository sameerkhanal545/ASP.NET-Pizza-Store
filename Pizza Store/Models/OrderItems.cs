using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Pizza_Store.Models
{
    public class OrderItems
    {
        public int OrderItemID { get; set; }
        public int PizzaID { get; set; }
        public decimal Price { get; set; }
        public string OrderID { get; set; }
        public int Quantity { get; set; }
        public PizzaModel pizza { get; set; }
    }
}