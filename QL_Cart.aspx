<%@ Page Title="" Language="C#" MasterPageFile="~/dashboard.Master" AutoEventWireup="true" CodeBehind="QL_Cart.aspx.cs" Inherits="BTL_PTUD.QL_Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    QL Cart
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="text-2xl font-bold m-2">Quản lý Cart</h1>
    <asp:TextBox ID="txtSearch" placeholder="User ID..." runat="server" />
    <asp:Button ID="cmdSearch" runat="server" Text="Search" OnClick="cmdSearch_Click" />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="cart_id" DataSourceID="SqlDataSource1">
    <Columns>
        <asp:BoundField DataField="cart_id" HeaderText="Cart ID" InsertVisible="False" ReadOnly="True" SortExpression="cart_id" />
        <asp:BoundField DataField="user_id" HeaderText="User ID" SortExpression="user_id" />
        <asp:BoundField DataField="product_id" HeaderText="Product ID" SortExpression="product_id" />
        <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
        <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
        <asp:BoundField DataField="created_date" HeaderText="Created date" SortExpression="created_date" />
        <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ptudConnectionString %>" 
        DeleteCommand="DELETE FROM [cart] WHERE [cart_id] = @cart_id" 
        InsertCommand="INSERT INTO [cart] ([user_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (@user_id, @product_id, @quantity, @price, @created_date, @status)" 
        SelectCommand="SELECT * FROM [cart]" 
        UpdateCommand="UPDATE [cart] SET [user_id] = @user_id, [product_id] = @product_id, [quantity] = @quantity, [price] = @price, [created_date] = @created_date, [status] = @status WHERE [cart_id] = @cart_id">
        
        <DeleteParameters>
            <asp:Parameter Name="cart_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="user_id" Type="Int32" />
            <asp:Parameter Name="product_id" Type="Int32" />
            <asp:Parameter Name="quantity" Type="Int32" />
            <asp:Parameter Name="price" Type="Decimal" />
            <asp:Parameter Name="created_date" Type="DateTime" />
            <asp:Parameter Name="status" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="user_id" Type="Int32" />
            <asp:Parameter Name="product_id" Type="Int32" />
            <asp:Parameter Name="quantity" Type="Int32" />
            <asp:Parameter Name="price" Type="Decimal" />
            <asp:Parameter Name="created_date" Type="DateTime" />
            <asp:Parameter Name="status" Type="String" />
            <asp:Parameter Name="cart_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
