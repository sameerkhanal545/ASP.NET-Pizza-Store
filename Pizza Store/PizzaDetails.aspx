<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PizzaDetails.aspx.cs" Inherits="Pizza_Store.PizzaDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container my-5">
        <div id="success-alert" class="alert alert-success alert-dismissible fade show" role="alert" style="display: none;">
            Success! Imte added to Cart.
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="card details-card p-0">
            <div class="row">

                <div class="col-md-6 col-sm-12">
                    <img class="img-fluid details-img" src="<%: Pizza.ImagePath %>" alt="<%: Pizza.Name %>">
                </div>
                <div class="col-md-6 col-sm-12 description-container p-5">
                    <div class="main-description">

                        <h3 id="lblName"><%: Pizza.Name %></h3>
                        <hr>
                        <p id="lblprice" class="product-price">$<%: Pizza.Price %></p>
                        <div class="add-inputs" method="post">
                            <asp:TextBox ID="cart_quantity" runat="server" CssClass="form-control" Type="Number" value="1" min="1"></asp:TextBox>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Invalid Quantity" Type="Integer" Display="Dynamic" MinimumValue="1" ControlToValidate="cart_quantity" ForeColor="#990000" MaximumValue="10"></asp:RangeValidator>
                            <asp:DropDownList ID="SizeDropDown" AutoPostBack="True" runat="server" OnSelectedIndexChanged="SizeDropDown_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <% if(!Context.User.IsInRole("Admin")){  %>
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add To Cart" CssClass="btn btn-primary btn-lg" CommandArgument='<%# Eval("Pizza.ProductID") %>' OnClick="btnAddToCart_Click" />
                        <%}  %>
                        <div style="clear: both"></div>

                        <hr>


                        <p class="product-title mt-4 mb-1">About this product</p>
                        <p class="product-description mb-4">
                            <%: Pizza.Description %>
                        </p>

                        <hr>
                    </div>




                </div>
            </div>
            <!-- End row -->
        </div>

    </div>
    <script>
        window.setTimeout(function () {
            $(".alert").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 4000);
    </script>
</asp:Content>
