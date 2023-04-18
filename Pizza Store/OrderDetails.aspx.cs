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
    public partial class OrderDetails : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                int orderId = Convert.ToInt32(Request.QueryString["OrderID"]);
                List<OrderItems> orderItems = new List<OrderItems>();

                string userId = Context.User.Identity.GetUserId();
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand cmd = new SqlCommand("Select * from Orders where OrderID = @OrderID", connection);
                    cmd.Parameters.AddWithValue("@OrderID", orderId);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        decimal total = Decimal.Parse(reader["TotalAmount"].ToString());
                        lblTotal.Text = string.Format("{0:C}", total);

                        reader.Close();
                        // Join the CartItems table with the Pizza table to get the pizza details of the cart items
                        string query = "SELECT ci.OrderItemID, ci.Quantity, ci.Price, p.PizzaID, p.Name, p.Description,p.ImagePath " +
                                   "FROM OrderItem ci " +
                                   "JOIN Pizza p ON ci.PizzaID = p.PizzaID " +
                                   "WHERE ci.OrderID = @OrderID";

                        cmd = new SqlCommand(query, connection);
                        cmd.Parameters.AddWithValue("@OrderID", orderId);

                        reader = cmd.ExecuteReader();


                        while (reader.Read())
                        {
                            int orderItemId = (int)reader["OrderItemID"];
                            int quantity = (int)reader["Quantity"];
                            int pizzaId = (int)reader["PizzaID"];
                            decimal price = (decimal)reader["Price"];
                            string pizzaName = reader["Name"].ToString();
                            string Description = reader["Description"].ToString();
                            //decimal pizzaPrice = reader.GetDecimal(4);
                            string pizzaImageUrl = reader["ImagePath"].ToString();

                            // Create a new CartItemViewModel object with the fetched data

                            OrderItems orderItem = new OrderItems
                            {
                                OrderItemID = orderItemId,
                                Quantity = quantity,
                                Price = price,
                                pizza = new PizzaModel
                                {
                                    PizzaID = pizzaId,
                                    Name = pizzaName,
                                    Description = Description,
                                    ImagePath = pizzaImageUrl

                                }
                            };

                            orderItems.Add(orderItem);
                        }

                    }
                    reader.Close();

                    // Bind the cart items to the repeater control on your cart page
                    OrderItemsRepeater.DataSource = orderItems;
                    OrderItemsRepeater.DataBind();
                }
            }
        }



    }
}