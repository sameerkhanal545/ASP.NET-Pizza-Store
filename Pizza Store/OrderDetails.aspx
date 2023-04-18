<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="Pizza_Store.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid my-5  d-flex  justify-content-center">
        <div class="card card-1">
            <div class="card-header bg-white">
                <div class="media flex-sm-row flex-column-reverse justify-content-between  ">
                    <div class="col my-auto">
                        <h4 class="mb-0">Your Order Details!</h4>
                    </div>
                    <div class="col-auto text-center  my-auto pl-0 pt-sm-4">
                        <p class="mb-4 pt-0">Ordered Pizza</p>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="row justify-content-between mb-3">
                    <div class="col-auto">
                        <h6 class="color-1 mb-0 change-color">Receipt</h6>
                    </div>
                    <div class="col-auto  "><small>Receipt Voucher : 1KAU9-84UIL</small> </div>
                </div>
                <asp:Repeater ID="OrderItemsRepeater" runat="server">
                    <ItemTemplate>
                        <div class="row">
                            <div class="col mt-2">
                                <div class="card card-2">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="sq align-self-center ">
                                                <img class="img-fluid  my-auto align-self-center mr-2 mr-md-4 pl-0 p-0 m-0" src="<%# Eval("pizza.ImagePath") %>" width="135" height="135" />
                                            </div>
                                            <div class="media-body my-auto text-right">
                                                <div class="row  my-auto flex-column flex-md-row">
                                                    <div class="col my-auto">
                                                        <h6 class="mb-0"><%# Eval("pizza.Name") %></h6>
                                                    </div>
                                                    <div class="col my-auto"><small>Qty : <%# Eval("Quantity") %></small></div>
                                                    <div class="col my-auto">
                                                        <h6 class="mb-0"><%# Eval("Price", "{0:c}") %></h6>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr class="my-3 ">
                                        <div class="row">
                                            <div class="col-md-3 mb-3"><small>Track Order <span><i class=" ml-2 fa fa-refresh" aria-hidden="true"></i></span></small></div>
                                            <div class="col mt-auto">
                                                <div class="progress my-auto">
                                                    <div class="progress-bar progress-bar  rounded" style="width: 62%" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                                <div class="media row justify-content-between ">
                                                    <div class="col-auto text-right"><span><small class="text-right mr-sm-2"></small><i class="fa fa-circle active"></i></span></div>
                                                    <div class="flex-col"><span><small class="text-right mr-sm-2">Out for delivary</small><i class="fa fa-circle active"></i></span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            
            </div>
            <div class="card-footer">
                <div class="jumbotron-fluid">
                    <div class="row justify-content-between ">
                        <div class="col-sm-auto col-auto my-auto">
                        </div>
                        <div class="col-auto my-auto ">
                            <h2 class="mb-0 font-weight-bold">TOTAL PAID</h2>
                        </div>
                        <div class="col-auto my-auto ml-auto">
                            <asp:Label CssClass="h1 display-3" ID="lblTotal" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
            
                </div>
            </div>
        </div>
    </div>

</asp:Content>
