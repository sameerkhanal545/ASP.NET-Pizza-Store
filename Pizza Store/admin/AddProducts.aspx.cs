using Pizza_Store.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pizza_Store.admin
{
    public partial class AddProducts : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddPizza_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // check if the page is valid based on the validation controls
            {
                // create a new Pizza object with the form data
                PizzaModel pizza = new PizzaModel()
                {
                    Name = txtName.Text.Trim(),
                    Description = txtDescription.Text.Trim(),
                    ShortDescription = txtShortDescription.Text.Trim(),
                    ImagePath = UploadImage()
                };

                // call a method to insert the pizza into the database
                bool success = InsertPizza(pizza);

                if (success)
                {
                    // redirect to the pizza list page
                    Response.Redirect("ListProducts.aspx");
                }
                else
                {
                    // display an error message
                    //lblErrorMessage.Text = "Error: Could not add pizza to database.";
                }
            }
        }

        private bool InsertPizza(PizzaModel pizza)
        {
            string query = "INSERT INTO Pizza ( Name, ImagePath,ShortDescription,Description) VALUES (@Name, @ImageUrl,@ShortDescription,@Description)";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", pizza.Name);
                    cmd.Parameters.AddWithValue("@ShortDescription", pizza.ShortDescription);
                    cmd.Parameters.AddWithValue("@Description", pizza.Description);
                    cmd.Parameters.AddWithValue("@ImageUrl", pizza.ImagePath);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            return true;
        }

        protected string UploadImage()
        {
            string filePath = string.Empty;

            if (ImageUpload.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(ImageUpload.FileName);
                    string fileExtension = Path.GetExtension(fileName);
                    string uploadFolder = Server.MapPath("~/img/");
                    string uniqueFileName = Guid.NewGuid().ToString() + fileExtension;
                    string savePath = Path.Combine(uploadFolder, uniqueFileName);
                    ImageUpload.SaveAs(savePath);
                    filePath = "img/" + uniqueFileName;
                }
                catch (Exception ex)
                {

                }
            }

            return filePath;
        }
    }
}
