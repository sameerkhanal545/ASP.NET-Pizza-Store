using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Pizza_Store.Models
{
    public class PizzaModel
    {
        public int PizzaID { get; set; }
        public decimal Price { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ShortDescription { get; set; }
        public string ImagePath { get; set; }
    }
}