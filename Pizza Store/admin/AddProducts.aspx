﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddProducts.aspx.cs" Inherits="Pizza_Store.admin.AddProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <h2>Add Pizza</h2>
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" />
        <div class="form-group">
            <label for="txtName">Name:</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Bind("Name") %>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtDescription">Description:</label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Text='<%# Bind("Description") %>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ErrorMessage="Description is required" CssClass="text-danger"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtShortDescription">Short Description:</label>
            <asp:TextBox ID="txtShortDescription" runat="server" CssClass="form-control" Text='<%# Bind("ShortDescription") %>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvShortDescription" runat="server" ControlToValidate="txtShortDescription" ErrorMessage="Short Description is required" CssClass="text-danger"></asp:RequiredFieldValidator>

        </div>
        <div class="form-group">
            <label for="txtImagePath">Image Path:</label>
            <asp:FileUpload ssClass="form-control" ID="ImageUpload" runat="server" />
        </div>
        <%--  <div class="form-group">
            <label for="txtPrice">Price:</label>
            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" Text='<%# Bind("Price") %>'></asp:TextBox>
            <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price must be a number" ValidationExpression="^\d+(\.\d{1,2})?$" CssClass="text-danger"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price is required" CssClass="text-danger"></asp:RequiredFieldValidator>
        </div>--%>
        <asp:Button ID="btnAddPizza" runat="server" Text="Add Pizza" CssClass="btn btn-primary" OnClick="btnAddPizza_Click" />


    </div>

</asp:Content>
