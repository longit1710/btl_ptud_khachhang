<%@ Page Title="" Language="C#" MasterPageFile="~/dashboard.Master" AutoEventWireup="true" CodeBehind="thongKe.aspx.cs" Inherits="BTL_PTUD.thongKe" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Thống kê
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="data mt-8 flex justify-center text-center gap-5 *:bg-slate-300 *:w-[200px] *:px-8 *:py-4 *:rounded-xl">
        <div class="data-item">
            <h1>Product</h1>
            <asp:Label ID="productCount" Font-Size="30px" runat="server" Text="Label"></asp:Label>
        </div>
        <div class="data-item">
            <h1>Cart</h1>
            <asp:Label ID="cartCount" Font-Size="30px" runat="server" Text="Label"></asp:Label>
        </div>
        <div class="data-item">
            <h1>Order</h1>
            <asp:Label ID="orderCount" Font-Size="30px" runat="server" Text="Label"></asp:Label>
        </div>
        <div class="data-item">
            <h1>User</h1>
            <asp:Label ID="userCount" Font-Size="30px" runat="server" Text="Label"></asp:Label>
        </div>
    </div>
    <h1 class="text-2xl font-bold m-2 text-center">Thống Kê Doanh Thu</h1>
    <asp:Label ID="Label1" runat="server" Text="Nhập năm: "></asp:Label>
    <asp:TextBox ID="txtYear" runat="server" AutoPostBack="true" OnTextChanged="txtYear_TextChanged"></asp:TextBox>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="OrderYear" HeaderText="Year" SortExpression="OrderYear" />
            <%--<asp:BoundField DataField="OrderMonth" HeaderText="Month" SortExpression="OrderMonth" />
            <asp:BoundField DataField="OrderDay" HeaderText="Day" SortExpression="OrderDay" />--%>
            <asp:BoundField DataField="TotalRevenue" HeaderText="Total Revenue" DataFormatString="{0:C}" SortExpression="TotalRevenue" />
        </Columns>
    </asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ptudConnectionString %>"
    SelectCommand="SELECT YEAR(o.order_date) AS OrderYear, 
                          MONTH(o.order_date) AS OrderMonth, 
                          DAY(o.order_date) AS OrderDay, 
                          SUM(oi.quantity * oi.price) AS TotalRevenue
                   FROM [order] o
                   INNER JOIN order_item oi ON o.order_id = oi.order_id
                   WHERE YEAR(o.order_date) = @Year OR @Year IS NULL
                   GROUP BY YEAR(o.order_date), MONTH(o.order_date), DAY(o.order_date)">
    <SelectParameters>
        <asp:Parameter Name="Year" Type="Int32" DefaultValue="" />
    </SelectParameters>
</asp:SqlDataSource>

<h1 class="text-xl font-bold mt-3">Top 5 Products Best Seller</h1>
<table>
    <thead>
        <th>Tên SP</th>
        <th>SL bán</th>
    </thead>
    <tbody>
    <asp:Repeater ID="rptTopProducts" runat="server">
        <ItemTemplate>
        <tr>
            <td><%# Eval("productName") %></td>
            <td><%# Eval("TotalQuantity") %></td>
        </tr>
        </ItemTemplate>
    </asp:Repeater>
    </tbody>
</table>


<h1 class="text-xl font-bold mt-3">Top 5 Products Bán Không Chạy</h1>
<table>
    <thead>
        <th>Tên SP</th>
        <th>SL bán</th>
    </thead>
    <tbody>
    <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
        <tr>
            <td><%# Eval("Name") %></td>
            <td><%# Eval("Total") %></td>
        </tr>
        </ItemTemplate>
    </asp:Repeater>
    </tbody>
</table>
</asp:Content>
