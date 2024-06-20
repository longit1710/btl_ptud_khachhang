<%@ Page Title="" Language="C#" MasterPageFile="~/dashboard.Master" AutoEventWireup="true" CodeBehind="QL_Order.aspx.cs" Inherits="BTL_PTUD.QL_Order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    QL Order
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="text-2xl font-bold m-2">Quản lý Order</h1>
    <asp:TextBox ID="txtSearch" placeholder="User ID" runat="server" />
    <asp:Button ID="cmdSearch" runat="server" Text="Search" OnClick="cmdSearch_Click" />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="order_item_id" DataSourceID="SqlDataSource1">
    <Columns>
        <asp:BoundField DataField="order_item_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="order_item_id" />
        <asp:BoundField DataField="order_id" HeaderText="Order ID" SortExpression="order_id" />
        <asp:BoundField DataField="product_id" HeaderText="Product ID" SortExpression="product_id" />
        <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
        <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
        <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />

        <asp:TemplateField HeaderText="User ID">
            <ItemTemplate>
                <%# Eval("user_id") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Order Date">
            <ItemTemplate>
                <%# Eval("order_date", "{0:dd/MM/yyyy}") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Payment Method">
            <ItemTemplate>
                <%# Eval("payment_method") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Payment Amount">
            <ItemTemplate>
                <%# Eval("payment_amount", "{0:C}") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Payment Date">
            <ItemTemplate>
                <%# Eval("payment_date", "{0:dd/MM/yyyy}") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ShowHeader="False">
            <EditItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" OnClick="LinkButton1_Click" Text="Update"></asp:LinkButton>
                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ptudConnectionString %>"
    SelectCommand="SELECT oi.order_item_id, oi.order_id, oi.product_id, oi.quantity, oi.price, oi.status, o.user_id, o.order_date, o.payment_method, o.payment_amount, o.payment_date 
                   FROM order_item oi
                   INNER JOIN [order] o ON oi.order_id = o.order_id"
    DeleteCommand="DELETE FROM [order_item] WHERE [order_item_id] = @order_item_id"
    UpdateCommand="UPDATE [order_item] SET order_id = @order_id, product_id = @product_id, quantity = @quantity, price = @price, status = @status WHERE [order_item_id] = @order_item_id">
    <DeleteParameters>
        <asp:Parameter Name="order_item_id" Type="Int32" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="order_id" Type="Int32" />
        <asp:Parameter Name="product_id" Type="Int32" />
        <asp:Parameter Name="quantity" Type="Int32" />
        <asp:Parameter Name="price" Type="Decimal" />
        <asp:Parameter Name="status" Type="String" />
        <asp:Parameter Name="order_item_id" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>


</asp:Content>
