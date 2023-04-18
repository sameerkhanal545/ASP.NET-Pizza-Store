using Pizza_Store.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Claims;
using Microsoft.AspNet.Identity;

namespace Pizza_Store
{
    public partial class PizzaDetails : System.Web.UI.Page
    {
        public PizzaModel Pizza { get; set; }

        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            RangeValidator1.MaximumValue = "10";

            if (!IsPostBack)
            {

                if (Request.QueryString["PizzaID"] != null)
                {
                    PizzaDetails page = (PizzaDetails)this.Page;

                    int pizzaId = Convert.ToInt32(Request.QueryString["PizzaID"]);
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand("SELECT * FROM Pizza WHERE PizzaID = @PizzaID", connection);
                        command.Parameters.AddWithValue("@PizzaID", pizzaId);
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            reader.Read();

                            PizzaModel pizza = new PizzaModel();
                            pizza.PizzaID = Int32.Parse(reader["PizzaID"].ToString());
                            pizza.Name = reader["Name"].ToString();
                            pizza.Description = reader["Description"].ToString();
                            pizza.ImagePath = reader["ImagePath"].ToString();
                            page.Pizza = pizza;
                            Session["Pizza"] = Pizza;

                        }
                        reader.Close();

                        command = new SqlCommand("SELECT * FROM Pizza_Sizes WHERE PizzaID = @PizzaID", connection);
                        command.Parameters.AddWithValue("@PizzaID", pizzaId);
                        reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {

                                string itemValue = reader["Price"].ToString();
                                string itemText = reader["Size"].ToString();
                                if (page.Pizza.Price <= 0)
                                    page.Pizza.Price = decimal.Parse(itemValue);

                                SizeDropDown.Items.Add(new ListItem(itemText, itemValue));
                            }
                        }
                        reader.Close();

                    }
                }
            }
        }

        protected void SizeDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            PizzaModel pizza = (PizzaModel)Session["Pizza"];

            PizzaDetails page = (PizzaDetails)this.Page;
            page.Pizza = pizza;
            page.Pizza.Price = decimal.Parse(SizeDropDown.SelectedItem.Value);


        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {

                PizzaModel pizza = (PizzaModel)Session["Pizza"];

                PizzaDetails page = (PizzaDetails)this.Page;
                page.Pizza = pizza;

                string userId = ((ClaimsIdentity)Context.User.Identity).GetUserId();
                int cartId;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("Select * from Cart where CustomerID = @CustomerID", connection);
                    cmd.Parameters.AddWithValue("@CustomerID", userId);
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        cartId = Int32.Parse(reader["CartID"].ToString());

                    }
                    else
                    {
                        reader.Close();
                        SqlCommand cmdInsert = new SqlCommand("INSERT INTO Cart (CustomerID) VALUES (@CustomerID); SELECT SCOPE_IDENTITY();", connection);
                        cmdInsert.Parameters.AddWithValue("@CustomerID", userId);
                        cartId = Convert.ToInt32(cmdInsert.ExecuteScalar());

                    }
                    if (!reader.IsClosed)
                    {
                        reader.Close();
                    }
                    SqlCommand cartItemInsert = new SqlCommand("INSERT INTO CartItem (CartID,PizzaID,Quantity,Price) VALUES (@CartID,@PizzaID,@Quantity,@Price)", connection);
                    cartItemInsert.Parameters.AddWithValue("@CartID", cartId);
                    cartItemInsert.Parameters.AddWithValue("@PizzaID", pizza.PizzaID);
                    cartItemInsert.Parameters.AddWithValue("@Quantity", Int32.Parse(cart_quantity.Text));
                    cartItemInsert.Parameters.AddWithValue("@Price", pizza.Price);
                    cartItemInsert.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "success-alert", "$('#success-alert').show();", true);

                }
            }
            else
            {
                Session["ReturnUrl"] = Request.Url.AbsoluteUri;
                Response.Redirect("/Account/Login");
            }
        }

    }
}