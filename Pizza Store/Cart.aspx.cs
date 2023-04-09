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
    public partial class Cart : System.Web.UI.Page
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
                            //decimal pizzaPrice = reader.GetDecimal(4);
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

                            cartItems.Add(cartItem);
                        }

                        reader.Close();

                        // Bind the cart items to the repeater control on your cart page
                        rptCartItems.DataSource = cartItems;
                        rptCartItems.DataBind();
                    }
                }
            }
        }

        protected void btnCheckoutCart_Click(object sender, EventArgs e)
        {

        }

        protected void btnEmptyItem_Click(object sender, EventArgs e)
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
                    Response.Redirect(Request.RawUrl);
                }

               

            }
        }


        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;

            string itemIdToRemove = button.CommandArgument;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "DELETE FROM CartItem WHERE CartItemID = @CartItemID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CartItemID", itemIdToRemove);
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect(Request.RawUrl);

            }

        }
    }
}