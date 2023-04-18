using Microsoft.AspNet.Identity;
using Pizza_Store.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pizza_Store
{
    public partial class Orders : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string userId = Context.User.Identity.GetUserId();
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    SqlCommand cmd = new SqlCommand("Select * from Orders where CustomerID = @CustomerID", connection);
                    cmd.Parameters.AddWithValue("@CustomerID", userId);
                    SqlDataReader reader = cmd.ExecuteReader();
                    List<OrdersModel> orders = new List<OrdersModel>();
                    while (reader.Read())
                    {
                        int orderId = (int)reader["OrderID"];
                        decimal total = (decimal)reader["TotalAmount"];
                        string orderDate = reader["OrderDate"].ToString();
                        string address = reader["CustomerAddress"].ToString();

                            OrdersModel order = new OrdersModel
                            {
                                OrderID = orderId,
                                TotalAmount = total,
                                OrderDate = orderDate,
                                CustomerAddress = address
                            };

                        orders.Add(order);
                    }

                    reader.Close();

                    // Bind the cart items to the repeater control on your order page
                    rptOrders.DataSource = orders;
                    rptOrders.DataBind();
                }

            }
        }

        protected void btnOrderDetail_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            int OrderID = int.Parse(button.CommandArgument);
            Response.Redirect("OrderDetails?OrderID=" + OrderID);

        }

    }
}