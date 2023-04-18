<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="Pizza_Store.admin.EditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <h2>Add Pizza</h2>
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" />
        <asp:HiddenField  ID="PizzaID" runat="server" Value='<%: Pizza.PizzaID %>'></asp:HiddenField>

        <div class="form-group">
            <label for="txtName">Name:</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text=""></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtDescription">Description:</label>
            <asp:TextBox ID="txtDescription" TextMode="MultiLine" runat="server" CssClass="form-control" Text='<%: Pizza.Desription %>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ErrorMessage="Description is required" CssClass="text-danger"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtShortDescription">Short Description:</label>
            <asp:TextBox ID="txtShortDescription" TextMode="MultiLine" runat="server" CssClass="form-control" Text='<%: Pizza.ShortDescription %>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvShortDescription" runat="server" ControlToValidate="txtShortDescription" ErrorMessage="Short Description is required" CssClass="text-danger"></asp:RequiredFieldValidator>

        </div>
        <div class="form-group">
            <label for="txtImagePath">Image Path:</label>
            <asp:FileUpload CssClass="form-control" ID="ImageUpload" runat="server" />
        </div>
        <%--  <div class="form-group">
            <label for="txtPrice">Price:</label>
            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" Text='<%# Bind("Price") %>'></asp:TextBox>
            <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price must be a number" ValidationExpression="^\d+(\.\d{1,2})?$" CssClass="text-danger"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price is required" CssClass="text-danger"></asp:RequiredFieldValidator>
        </div>--%>
        <asp:Button ID="btnEditPizza" runat="server" Text="Edit Pizza" CssClass="btn btn-primary mt-3" OnClick="btnEditPizza_Click" />


    </div>

</asp:Content>
