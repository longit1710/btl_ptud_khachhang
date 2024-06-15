<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="BTL_PTUD.Order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đơn Hàng của Tôi</title>
    <style>
        /* CSS styles for order items */
        /* Include any styles you need */
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Đơn Hàng của Tôi</h1>
            <asp:Repeater ID="rptOrders" runat="server">
                <ItemTemplate>
                    <div class="order-item">
                        <div class="order-details">
                            <h3>Mã đơn hàng: <%# Eval("OrderID") %></h3>
                            <div>
                                Ngày đặt hàng: <%# Eval("OrderDate", "{0:dd/MM/yyyy}") %>
                            </div>
                            <div>
                                Tổng tiền: <%# Eval("TotalAmount", "{0:C}") %>
                            </div>
                            <div>
                                Trạng thái: <%# Eval("Status") %>
                            </div>
                        </div>
                        <div class="order-items">
                            <asp:Repeater ID="rptOrderItems" runat="server">
                                <ItemTemplate>
                                    <div class="order-item">
                                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# "images/" + Eval("Image") %>' />
                                        <div class="item-details">
                                            <div class="item-name"><%# Eval("ProductName") %></div>
                                            <div class="item-quantity">Số lượng: <%# Eval("Quantity") %></div>
                                            <div class="item-price">Giá: <%# Eval("Price", "{0:C}") %></div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
