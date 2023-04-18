using Pizza_Store.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Pizza_Store.admin
{
    public partial class AddPizzaSize : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Request.QueryString["PizzaID"] != null)
                {
                    pizzaDropdown.SelectedValue = Request.QueryString["PizzaID"];
                    pizzaDropdown.Enabled = false;

                }


            }
        }
        protected void addPizzaButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // check if the page is valid based on the validation controls
            {
                // create a new Pizza object with the form data
                string query = "INSERT INTO Pizza_Sizes ( PizzaID, Price,Size) VALUES (@PizzaID, @Price,@Size)";
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@PizzaID", pizzaDropdown.SelectedValue);
                        cmd.Parameters.AddWithValue("@Price", decimal.Parse(priceTextbox.Text));
                        cmd.Parameters.AddWithValue("@Size", sizeDropdown.SelectedValue);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }


                // redirect to the pizza list page
                Response.Redirect("ListProducts.aspx");

            }
        }
    }
}