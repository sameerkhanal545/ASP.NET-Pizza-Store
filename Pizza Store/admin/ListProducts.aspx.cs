using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pizza_Store
{
    public partial class AddProducts : System.Web.UI.Page
    {
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddPrice")
            {
                // Get the ProductID from the CommandArgument
                int productID = Convert.ToInt32(e.CommandArgument);

                // Redirect to the product details page
                Response.Redirect("AddPizzaSize.aspx?PizzaID=" + productID);
            }
            else if (e.CommandName == "Edit")
            {
                // Get the ProductID from the CommandArgument
                int productID = Convert.ToInt32(e.CommandArgument);

                // Redirect to the product details page
                Response.Redirect("EditProduct.aspx?PizzaID=" + productID);
            }

        }
    }
}