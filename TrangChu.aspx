<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="BTL_PTUD.TrangChu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trang Chủ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }
        .container {
            width: 80%;
            margin: 0 auto;
        }
        .product-item {
            background-color: #ffffff;
            border: 1px solid #ddd;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            padding: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .product-item img {
            width: 200px;
            height: 200px;
            object-fit: cover;
            object-position: center;
        }
        .product-name {
            font-weight: bold;
            margin: 5px 0;
        }
        .product-price {
            color: #cc3300;
            font-size: 18px;
        }
        .btn-detail, .btn-add-to-cart {
            margin-top: 10px;
            padding: 5px 10px;
            background-color: #337ab7;
            color: #ffffff;
            border: none;
            cursor: pointer;
        }
        .btn-add-to-cart {
            background-color: #5cb85c;
        }
        .btn-show, .btn-home, .btn-cart, .btn-order {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #ffffff;
            border: none;
            cursor: pointer;
            display: inline-block;
            transition: background-color 0.3s ease;
        }
        .btn-show:hover, .btn-home:hover, .btn-cart:hover, .btn-order:hover {
            background-color: chartreuse;
        }
        .message {
            color: green;
            font-weight: bold;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination button {
            padding: 10px 20px;
            margin: 0 5px;
            background-color: #007bff;
            color: #ffffff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .pagination button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .pagination button:hover:not(:disabled) {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1 class="auto-style1"><strong>TRANG GIỚI THIỆU SẢN PHẨM</strong></h1>
            <div class="search-bar">
                <asp:TextBox ID="txtSearch" runat="server" Width="300px" placeholder="Nhập tên sản phẩm..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" CssClass="btn-show" Text="Tìm kiếm" OnClick="btnSearch_Click" />
                <asp:DropDownList ID="ddlPriceRange" runat="server">
                    <asp:ListItem Text="Chọn khoảng giá" Value=""></asp:ListItem>
                    <asp:ListItem Text="100,000 - 300,000" Value="100000-300000"></asp:ListItem>
                    <asp:ListItem Text="300,000 - 500,000" Value="300000-500000"></asp:ListItem>
                    <asp:ListItem Text="Trên 500,000" Value="500000-"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnFilterPrice" runat="server" CssClass="btn-show" Text="Lọc theo giá" OnClick="btnFilterPrice_Click" />
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
            <asp:Button ID="btnShowBestSellers" runat="server" CssClass="btn-show" Text="Top 5 Sản Phẩm Bán Chạy" OnClick="btnShowBestSellers_Click" />
            <asp:Button ID="btnShowNewProducts" runat="server" CssClass="btn-show" Text="Top 5 Sản Phẩm Mới Nhất" OnClick="btnShowNewProducts_Click" />
            <asp:Button ID="btnHome" runat="server" CssClass="btn-home" Text="Trở về Trang Chủ" OnClick="btnHome_Click" />
            <asp:Button ID="btnViewCart" runat="server" CssClass="btn-cart" Text="Xem Giỏ Hàng" OnClick="btnViewCart_Click" />
            <asp:Button ID="btnViewOrder" runat="server" CssClass="btn-order" Text="Đơn hàng đã mua" OnClick="btnViewOrder_Click" />

            <asp:DataList ID="DataListProducts" runat="server" DataKeyField="product_id" RepeatColumns="4" OnItemCommand="DataListProducts_ItemCommand" Width="100%">
                <ItemTemplate>
                    <div class="product-item">
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# "images/" + Eval("image") %>' />
                        <div>
                            <asp:Label ID="Label1" runat="server" CssClass="product-name" Text='<%# Eval("name") %>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" CssClass="product-price" Text='<%# Eval("price", "{0:N0} VNĐ") %>'></asp:Label><br />
                            <asp:Button ID="btnDetail" runat="server" CssClass="btn-detail" Text="Chi tiết" CommandName="Detail" CommandArgument='<%# Eval("product_id") %>' />
                            <asp:Button ID="btnAddToCart" runat="server" CssClass="btn-add-to-cart" Text="Thêm vào giỏ hàng" CommandName="AddToCart" CommandArgument='<%# Eval("product_id") %>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <div class="pagination">
                <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" />
                <asp:Label ID="lblCurrentPage" runat="server" Text="1"></asp:Label>
                <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" />
            </div>
        </div>
    </form>
</body>
</html>
