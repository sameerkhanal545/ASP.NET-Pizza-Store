using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Pizza_Store.Models
{
    public class CartItem
    {
        public int CartItemID { get; set; }
        public int PizzaID { get; set; }
        public decimal Price { get; set; }
        public string CartID { get; set; }
        public int Quantity { get; set; }
        public PizzaModel pizza { get; set; }

    }
}