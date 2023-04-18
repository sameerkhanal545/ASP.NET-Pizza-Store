<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="Pizza_Store.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="text-center">Order History</h2>
    <table class="table table-hover table table-striped">
        <tr class ="table-primary">
            <th>OrderID</th>
            <th>OrderDate</th>
            <th>Address</th>
            <th class="text-center">Total</th>
            <th class="text-center">Action</th>

            <asp:Repeater ID="rptOrders" runat="server">
                <ItemTemplate>
                    <tr>
                        <td class="col-sm-1 col-md-1">#<%# Eval("OrderID") %></td>
                        <td class="col-sm-3 col-md-3"><%# Eval("OrderDate") %></td>
                        <td class="col-sm-3 col-md-3"><%# Eval("CustomerAddress") %></td>
                        <td class="col-sm-1 col-md-1 text-center"><strong><%# Eval("TotalAmount", "{0:c}") %></strong></td>
                        <td class="col-sm-1 col-md-1 text-center">
                            <asp:Button ID="btnViewOrder" runat="server" Text="Details" CssClass="btn btn-danger"  CommandArgument='<%# Eval("OrderID") %>' OnClick="btnOrderDetail_Click"/>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>

    </table>
</asp:Content>
