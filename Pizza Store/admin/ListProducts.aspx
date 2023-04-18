<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListProducts.aspx.cs" Inherits="Pizza_Store.AddProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridView1" CssClass="mt-4" runat="server" AutoGenerateColumns="False" DataKeyNames="PizzaID" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="GridView1_RowCommand">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="PizzaID" HeaderText="PizzaID" ReadOnly="True" InsertVisible="False" SortExpression="PizzaID"></asp:BoundField>
            <asp:TemplateField HeaderText="Name" SortExpression="Name">
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="TextBox1"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%# Bind("Name") %>' ID="Label1"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%# Bind("Description") %>' ID="TextBox2"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%# Bind("Description") %>' ID="Label2"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ImagePath" SortExpression="ImagePath">
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%# Bind("ImagePath") %>' ID="TextBox3"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%# Bind("ImagePath") %>' ID="Label3"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ShortDescription" SortExpression="ShortDescription">
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%# Bind("ShortDescription") %>' ID="TextBox4"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%# Bind("ShortDescription") %>' ID="Label4"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pricing">
                <ItemTemplate>
                    <asp:Button ID="btnAddPrice" runat="server" Text="Add Price" CssClass="btn btn-info" CommandName="AddPrice" CommandArgument='<%# Eval("PizzaID") %>' />
                </ItemTemplate>

            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-warning" CommandName="Edit" CommandArgument='<%# Eval("PizzaID") %>' />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' DeleteCommand="DELETE FROM [Pizza] WHERE [PizzaID] = @PizzaID" InsertCommand="INSERT INTO [Pizza] ([Name], [Description], [ImagePath], [ShortDescription]) VALUES (@Name, @Description, @ImagePath, @ShortDescription)" SelectCommand="SELECT * FROM [Pizza]" UpdateCommand="UPDATE [Pizza] SET [Name] = @Name, [Description] = @Description, [ImagePath] = @ImagePath, [ShortDescription] = @ShortDescription WHERE [PizzaID] = @PizzaID">
        <DeleteParameters>
            <asp:Parameter Name="PizzaID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String"></asp:Parameter>
            <asp:Parameter Name="Description" Type="String"></asp:Parameter>
            <asp:Parameter Name="ImagePath" Type="String"></asp:Parameter>
            <asp:Parameter Name="ShortDescription" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String"></asp:Parameter>
            <asp:Parameter Name="Description" Type="String"></asp:Parameter>
            <asp:Parameter Name="ImagePath" Type="String"></asp:Parameter>
            <asp:Parameter Name="ShortDescription" Type="String"></asp:Parameter>
            <asp:Parameter Name="PizzaID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
