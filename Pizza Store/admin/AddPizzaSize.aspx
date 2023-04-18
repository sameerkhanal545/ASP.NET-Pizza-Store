<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddPizzaSize.aspx.cs" Inherits="Pizza_Store.admin.AddPizzaSize" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h2>Add Pizza Size and Price</h2>
        <hr />
        <div class="form-group">
            <label for="pizzaDropdown">Pizza:</label>
            <asp:DropDownList ID="pizzaDropdown" CssClass="form-control" runat="server" DataSourceID="pizzaDataSource" DataTextField="Name" DataValueField="PizzaID" AppendDataBoundItems="True">
                <asp:ListItem Value="" Text="Select a pizza"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="pizzaDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                SelectCommand="SELECT * FROM Pizza"></asp:SqlDataSource>
            <asp:RequiredFieldValidator CssClass="text-danger" ControlToValidate="pizzaDropdown" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Pizza"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="sizeDropdown">Size:</label>
            <asp:DropDownList ID="sizeDropdown" CssClass="form-control" runat="server">
                <asp:ListItem Value="">Select a size</asp:ListItem>
                <asp:ListItem Value="Small">Small</asp:ListItem>
                <asp:ListItem Value="Medium">Medium</asp:ListItem>
                <asp:ListItem Value="Large">Large</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator CssClass="text-danger" ControlToValidate="sizeDropdown" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Select Size"></asp:RequiredFieldValidator>

        </div>
        <div class="form-group">
            <label for="priceTextbox">Price:</label>
            <asp:TextBox ID="priceTextbox" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="priceValidator" runat="server" CssClass="text-danger" ControlToValidate="priceTextbox" ErrorMessage="Please enter valid Price" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="text-danger" runat="server" ControlToValidate="priceTextbox" ErrorMessage="Please enter valid Price" Display="Dynamic" ValidationExpression="^-?\d+(\.\d+)?$"></asp:RegularExpressionValidator>
        </div>
        <asp:Button ID="submitButton" runat="server" Text="Add" CssClass="btn btn-primary mt-3" OnClick="addPizzaButton_Click" />
    </div>
</asp:Content>
