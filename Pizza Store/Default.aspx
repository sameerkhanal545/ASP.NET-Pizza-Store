<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Pizza_Store._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron text-white jumbotron-image shadow" style="background-image: url('img/pizza-bg.jpg');">
        <div class="overlay">
            <div class="banner-body">
                <h1>Pizza Store</h1>
                <p class="lead">Your One stop shot for delecious Pizzas</p>
                <p><a href="#" class="btn btn-primary btn-lg">Order Now &raquo;</a></p>
            </div>
        </div>
    </div>
    <div class="row">
        <h2>Top Pick of the Day</h2>
        <asp:DataList ID="DataList1" runat="server" RepeatColumns="3" RepeatDirection="Horizontal">
            <ItemTemplate>
                <div class="card align-items-center text-white" style="width: 18rem;">
                    <img src='<%# Eval("ImagePath") %>' class=" card-img" alt='<%# Eval("Name") %>'>
                    <div class="card-body bg-dark">
                        <h5 class="card-title"><%# Eval("Name") %></h5>
                        <p class="card-text"><%# Eval("ShortDescription") %></p>
                        <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-primary" Text="View Details" CommandArgument='<%# Eval("PizzaID") %>'  OnClick="btnAddToCart_Click"/>
                    </div>
                </div>

            </ItemTemplate>
        </asp:DataList>
    </div>



</asp:Content>
