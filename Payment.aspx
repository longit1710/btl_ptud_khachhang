<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="BTL_PTUD.Payment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Payment Information</h2>

            <!-- Hiển thị danh sách sản phẩm trong giỏ hàng -->
            <asp:Repeater ID="rptCart" runat="server" OnItemDataBound="rptCart_ItemDataBound">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Amount</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("name") %></td>
                        <td><%# Eval("quantity") %></td>
                        <td><%# Eval("price", "{0:C}") %></td>
                        <td><%# Convert.ToDecimal(Eval("quantity")) * Convert.ToDecimal(Eval("price")) %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <!-- Hiển thị tổng số tiền cần thanh toán -->
            <div>
                Total Amount: <asp:Label ID="lblTotalAmount" runat="server" Text="0"></asp:Label>
            </div>

            <!-- Form thanh toán -->
            <div>
                <h3>Payment Details</h3>
                <asp:DropDownList ID="ddlPaymentMethod" runat="server">
                    <asp:ListItem Text="Credit Card" Value="CreditCard"></asp:ListItem>
                    <asp:ListItem Text="Debit Card" Value="DebitCard"></asp:ListItem>
                    <asp:ListItem Text="Cash on Delivery" Value="COD"></asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:Button ID="btnPay" runat="server" Text="Pay Now" OnClick="btnPay_Click" />
            </div>
        </div>
    </form>
</body>
</html>
