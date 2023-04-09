using Microsoft.AspNet.Identity;
using Pizza_Store.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pizza_Store
{
    public partial class Checkout : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        decimal total = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<CartItem> cartItems = GetCartDetails();
                lblTotal.Text = string.Format("{0:C}", total);
                cartRepeater.DataSource = cartItems;
                cartRepeater.DataBind();

            }
        }

        protected void btn_PlaceOrder_Click(object sender, EventArgs e)
        {
            string userId = Context.User.Identity.GetUserId();
            List<CartItem> cartItems = GetCartDetails();
            string queryString = "INSERT INTO Orders (CustomerID, OrderDate, TotalAmount,CustomerName, CustomerAddress, Zipcode) VALUES (@CustomerID, GETDATE(), @TotalAmount,@CustomerName,@CustomerAddress,@Zipcode); SELECT SCOPE_IDENTITY();";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand(queryString, connection);
                cmd.Parameters.AddWithValue("@CustomerID", userId);
                cmd.Parameters.AddWithValue("@TotalAmount", total);
                cmd.Parameters.AddWithValue("@CustomerAddress", address.Text);
                cmd.Parameters.AddWithValue("@Zipcode", zip.Text);
                cmd.Parameters.AddWithValue("@CustomerName", firstName.Text + " " + lastName.Text);
                int orderId = Convert.ToInt32(cmd.ExecuteScalar());

                if (orderId > 0)
                {

                    queryString = "INSERT INTO OrderItem (OrderID, PizzaID, Price,Quantity) VALUES (@OrderID, @PizzaID,@Price, @Quantity)";
                    foreach (CartItem cartItem in cartItems)
                    {
                        cmd = new SqlCommand(queryString, connection);
                        cmd.Parameters.AddWithValue("@OrderID", orderId);
                        cmd.Parameters.AddWithValue("@PizzaID", cartItem.pizza.PizzaID);
                        cmd.Parameters.AddWithValue("@Price", cartItem.Price);
                        cmd.Parameters.AddWithValue("@Quantity", cartItem.Quantity);
                        SqlDataReader   reader = cmd.ExecuteReader();
                        reader.Close();
                   
                    }
                    EmptyCart();
                }
                connection.Close();
            }
            Response.Redirect("Orders.aspx");

        }

        private List<CartItem> GetCartDetails()
        {
            string userId = Context.User.Identity.GetUserId();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlCommand cmd = new SqlCommand("Select * from Cart where CustomerID = @CustomerID", connection);
                cmd.Parameters.AddWithValue("@CustomerID", userId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    int cartId = Int32.Parse(reader["CartID"].ToString());

                    reader.Close();
                    // Join the CartItems table with the Pizza table to get the pizza details of the cart items
                    string query = "SELECT ci.CartItemID, ci.Quantity, ci.Price, p.PizzaID, p.Name, p.Description,p.ImagePath " +
                                   "FROM CartItem ci " +
                                   "JOIN Pizza p ON ci.PizzaID = p.PizzaID " +
                                   "WHERE ci.CartID = @CartID";

                    cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@CartID", cartId);

                    reader = cmd.ExecuteReader();

                    List<CartItem> cartItems = new List<CartItem>();

                    while (reader.Read())
                    {
                        int cartItemId = (int)reader["CartItemID"];
                        int quantity = (int)reader["Quantity"];
                        int pizzaId = (int)reader["PizzaID"];
                        decimal price = (decimal)reader["Price"];
                        string pizzaName = reader["Name"].ToString();
                        string Description = reader["Description"].ToString();
                        string pizzaImageUrl = reader["ImagePath"].ToString();

                        // Create a new CartItemViewModel object with the fetched data

                        CartItem cartItem = new CartItem
                        {
                            CartItemID = cartItemId,
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
                        total += price * quantity;
                        cartItems.Add(cartItem);
                    }


                    reader.Close();
                    return cartItems;
                }
            }
            return null;
        }

        protected void EmptyCart()
        {
            string userId = Context.User.Identity.GetUserId();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("Select * from Cart where CustomerID = @CustomerID", connection);
                cmd.Parameters.AddWithValue("@CustomerID", userId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    int cartId = Int32.Parse(reader["CartID"].ToString());
                    reader.Close();
                    string query = "DELETE FROM CartItem WHERE CartID = @CartID";
                    cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@CartID", cartId);
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }



            }
        }

    }
}