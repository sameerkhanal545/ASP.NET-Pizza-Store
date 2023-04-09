<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Pizza_Store.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <div class="emptyCart">
            <asp:Button ID="btnEmptyCart" runat="server" Text="Empty Cart" CssClass="btn btn-danger cart-button" OnClick="btnEmptyItem_Click" />
        </div>
        <table class="table table-hover">
            <tr class="table-info">
                <th>Product</th>
                <th>Name</th>
                <th>Quantity</th>
                <th class="text-center">Price</th>
                <th class="text-center">Action</th>

                <asp:Repeater ID="rptCartItems" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td class="col-sm-6 col-md-6 thumbnail">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("pizza.ImagePath") %>' Width="120px" Height="120px" /></td>

                            <td class="col-sm-1 col-md-1"><%# Eval("pizza.Name") %></td>
                            <td class="col-sm-1 col-md-1 text-center"><%# Eval("Quantity") %></td>
                            <td class="col-sm-1 col-md-1 text-center"><strong> <%# Eval("Price", "{0:c}") %></strong></td>
                            <td class="col-sm-1 col-md-1 text-center">
                                <asp:Button ID="btnRemoveItem" runat="server" Text="Remove" CssClass="btn btn-danger" OnClick="btnRemoveItem_Click" CommandArgument='<%# Eval("CartItemID") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>

        </table>

        <div class="cart-button">
            <asp:Button ID="btnContinueShoppping" runat="server" Text="Continue Shopping" PostBackUrl ="~/Products.aspx" CssClass="btn btn-primary" />
            <asp:Button ID="btnCheckoutCart" runat="server" Text="Checkout" CssClass="btn btn-primary" PostBackUrl="~/Checkout.aspx" />
        </div>
</asp:Content>
