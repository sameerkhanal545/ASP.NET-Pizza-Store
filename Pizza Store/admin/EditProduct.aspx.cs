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
    public partial class EditProduct : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        public PizzaModel Pizza { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Request.QueryString["PizzaID"] != null)
                {
                    EditProduct page = (EditProduct)this.Page;

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
                            PizzaID.Value = reader["PizzaID"].ToString();
                            txtName.Text = reader["Name"].ToString();
                            txtDescription.Text = reader["Description"].ToString();
                            txtShortDescription.Text = reader["ShortDescription"].ToString();

                            Session["Pizza"] = pizza;

                        }
                        reader.Close();
                    }
                }


            }
        }

        protected void btnEditPizza_Click(object sender, EventArgs e)
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
                bool success = UpdatePizza(pizza);

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

        private bool UpdatePizza(PizzaModel pizza)
        {
            string query;
            if (ImageUpload.HasFile)
                query = "UPDATE Pizza SET Name = @Name, ImagePath =@ImageUrl ,ShortDescription = @ShortDescription, Description =@Description WHERE PizzaID = @PizzaID";
            else
                query = "UPDATE Pizza SET Name = @Name ,ShortDescription = @ShortDescription, Description =@Description WHERE PizzaID = @PizzaID";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", pizza.Name);
                    cmd.Parameters.AddWithValue("@ShortDescription", pizza.ShortDescription);
                    cmd.Parameters.AddWithValue("@Description", pizza.Description);
                    cmd.Parameters.AddWithValue("@PizzaID", PizzaID.Value);
                    if (ImageUpload.HasFile)
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