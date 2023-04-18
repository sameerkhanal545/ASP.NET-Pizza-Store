using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Pizza_Store.Models
{
    public class OrdersModel
    {
        public int OrderID { get; set; }
        public int CusermerID { get; set; }
        public string OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string CustomerName { get; set; }
        public string CustomerAddress { get; set; }
        public OrderItems OrderItems { get; set; }
    }
}