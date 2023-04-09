<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Pizza_Store.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="py-5 text-center">

            <h2>Checkout form</h2>
        </div>

        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Your cart</span>
                    <span class="badge badge-secondary badge-pill">3</span>
                </h4>
                <ul class="list-group mb-3">

                    <asp:Repeater ID="cartRepeater" runat="server">
                        <ItemTemplate>
                            <li class="list-group-item d-flex justify-content-between lh-condensed">
                                <div>
                                    <h6 class="my-0"><%# Eval("pizza.Name") %></h6>
                                    <small class="text-muted">Quantity: <%# Eval("Quantity") %></small>
                                </div>
                                <span class="text-muted"><%# Eval("Price", "{0:c}") %></span>

                            </li>

                        </ItemTemplate>
                    </asp:Repeater>

                    <li class="list-group-item d-flex justify-content-between">
                        <span>Total (CAD)</span>
                        <strong>
                            <asp:Label ID="lblTotal" runat="server" Text="Label"></asp:Label>

                        </strong>
                    </li>

                </ul>


            </div>
            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Shippping address</h4>
                <div class="needs-validation" novalidate>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName">First name</label>
                            <asp:TextBox class="form-control" ID="firstName" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="validator" CssClass="invalid-feedback" runat="server" ErrorMessage="Last Name is Required" Display="Dynamic" ControlToValidate="firstName"></asp:RequiredFieldValidator>

                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName">Last name</label>
                            <asp:TextBox class="form-control" ID="lastName" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="invalid-feedback" runat="server" ErrorMessage="First Name is Required" Display="Dynamic" ControlToValidate="lastName"></asp:RequiredFieldValidator>

                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address">Address</label>
                        <asp:TextBox class="form-control" ID="address" runat="server" placeholder="1234 Main St"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="invalid-feedback" runat="server" ErrorMessage="Address is Required" Display="Dynamic" ControlToValidate="address"></asp:RequiredFieldValidator>

                    </div>

                    <div class="col-md-3 mb-3">
                        <label for="zip">Zip</label>
                        <asp:TextBox class="form-control" ID="zip" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="invalid-feedback" runat="server" ErrorMessage="Zip code is Required" Display="Dynamic" ControlToValidate="zip"></asp:RequiredFieldValidator>

                    </div>
                </div>

                <hr class="mb-4">

                <h4 class="mb-3">Payment</h4>
                <div class="d-block my-3">
                    <asp:RadioButtonList c ID="paymentMethod" runat="server">
                        <asp:ListItem CssClass="custom-control-input" Text="Credit Card" Value="Credit card" Selected="True"></asp:ListItem>
                        <asp:ListItem CssClass="custom-control-input" Text="Debit Card" Value="Debit card"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>


                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="cc-name">Name on card</label>
                        <asp:TextBox class="form-control" ID="ccName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="invalid-feedback" runat="server" ErrorMessage="Name is Required" Display="Dynamic" ControlToValidate="ccName"></asp:RequiredFieldValidator>

                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="cc-number">Credit card number</label>
                        <asp:TextBox class="form-control" ID="ccNumber" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" CssClass="invalid-feedback" runat="server" ErrorMessage="Card Number is Required" Display="Dynamic" ControlToValidate="ccNumber"></asp:RequiredFieldValidator>

                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="cc-expiration">Expiration</label>
                        <asp:TextBox class="form-control" ID="ccExpiration" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" CssClass="invalid-feedback" runat="server" ErrorMessage="Expire Date is Required" Display="Dynamic" ControlToValidate="ccExpiration"></asp:RequiredFieldValidator>

                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="cc-cvv">CVV</label>
                        <asp:TextBox class="form-control" ID="ccCvv" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" CssClass="invalid-feedback" runat="server" ErrorMessage="CVV is Required" Display="Dynamic" ControlToValidate="ccCvv"></asp:RequiredFieldValidator>

                    </div>
                </div>
                <hr class="mb-4">
                <asp:Button ID="btn_PlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-primary btn-lg btn-block" OnClick="btn_PlaceOrder_Click" />
            </div>
        </div>
    </div>


    </div>

</asp:Content>
