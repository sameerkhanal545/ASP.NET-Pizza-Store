<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pizza.aspx.cs" Inherits="Pizza_Store.Pizza" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
  <img class="card-img-top" src="product-image.jpg" alt="Product Image">
  <div class="card-body">
    <h5 class="card-title">Product Name</h5>
    <p class="card-text">Product Description</p>
    <p class="card-text">$10.00</p>
    <asp:Button ID="AddToCartButton" runat="server" Text="Add to Cart" CssClass="btn btn-primary" CommandName="AddToCart" CommandArgument='<%# Eval("ProductId") %>' />
  </div>
</div>
</asp:Content>
