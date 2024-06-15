<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="BTL_PTUD.Cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Giỏ Hàng</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        padding: 20px;
    }
    .container {
        width: 80%;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .cart-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }
    .cart-item img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        object-position: center;
    }
    .item-details {
        flex: 1;
        padding: 0 20px;
    }
    .item-name {
        font-weight: bold;
        margin-bottom: 5px;
    }
    .item-quantity {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .item-quantity input {
        width: 40px;
        text-align: center;
    }
    .item-price {
        color: #cc3300;
    }
    .btn-update {
        padding: 5px 10px;
        background-color: #5bc0de;
        color: #ffffff;
        border: none;
        cursor: pointer;
    }
    .total-price {
        font-size: 20px;
        font-weight: bold;
        color: #cc3300;
        text-align: right;
        margin-top: 20px;
    }
    .btn-home, .btn-checkout {
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #337ab7;
        color: #ffffff;
        border: none;
        cursor: pointer;
        text-align: center;
        transition: background-color 0.3s ease;
    }
    .btn-home:hover {
        background-color: #d9534f; /* Màu đỏ khi hover vào nút btn-home */
    }
    .btn-checkout:hover {
        background-color: #5cb85c; /* Màu xanh khi hover vào nút btn-checkout */
    }
</style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Giỏ Hàng Của Bạn</h1>
            <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                <ItemTemplate>
                    <div class="cart-item">
                        <asp:HiddenField ID="hfCartId" runat="server" Value='<%# Eval("cart_id") %>' />
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# "images/" + Eval("image") %>' />
                        <div class="item-details">
                            <div class="item-name"><%# Eval("name") %></div>
                            <div class="item-quantity">
                                Số lượng: 
                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("quantity") %>' Width="40px" CssClass="quantity-input" AutoPostBack="true" OnTextChanged="txtQuantity_TextChanged" />
                                <asp:Button ID="btnIncrease" runat="server" CssClass="btn-update" Text="+" CommandName="Increase" CommandArgument='<%# Eval("cart_id") %>' />
                                <asp:Button ID="btnDecrease" runat="server" CssClass="btn-update" Text="-" CommandName="Decrease" CommandArgument='<%# Eval("cart_id") %>' />
                            </div>
                            <div class="item-price">Giá: <%# Eval("price", "{0:N0} VNĐ") %></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="total-price">
                Tổng giá: <asp:Label ID="lblTotalPrice" runat="server" Text=""></asp:Label>
            </div>
            <asp:Button ID="btnCheckout" runat="server" CssClass="btn-checkout" Text="Thanh toán" OnClick="btnCheckout_Click" />
            <asp:Button ID="btnHome" runat="server" CssClass="btn-home" Text="Trở về Trang Chủ" OnClick="btnHome_Click" />
        </div>
    </form>
</body>
</html>
