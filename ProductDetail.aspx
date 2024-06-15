<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="BTL_PTUD.ProductDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chi tiết sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }
        .container {
            width: 60%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
        }
        .product-image {
            width: 100%;
            max-width: 300px;
            height: auto;
            margin-right: 20px; /* Khoảng cách giữa ảnh và nút */
        }
        .product-name {
            font-size: 24px;
            font-weight: bold;
            margin-top: 0;
        }
        .product-price {
            color: #cc3300;
            font-size: 20px;
            margin-top: 10px;
        }
        .product-description {
            margin-top: 20px;
        }
        .btn-add-to-cart, .btn-home {
            padding: 10px 20px;
            background-color: #337ab7;
            color: #ffffff;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .btn-add-to-cart {
            background-color: #d9534f;
        }
        .btn-home:hover {
            background-color: #5cb85c;
        }
        .related-products {
            margin-top: 30px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }
        .related-products h2 {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .related-product-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .related-product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            margin-right: 15px;
        }
        .related-product-name {
            font-size: 18px;
            font-weight: bold;
        }
        .related-product-price {
            color: #cc3300;
            font-size: 16px;
        }
        .related-product-btn {
            margin-left: auto;
            padding: 5px 10px;
            background-color: #337ab7;
            color: #ffffff;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .related-product-btn:hover {
            background-color: #5cb85c;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <asp:Image ID="ProductImage" runat="server" CssClass="product-image" />
            <div>
                <h1 class="product-name"><asp:Label ID="ProductName" runat="server"></asp:Label></h1>
                <div class="product-price"><asp:Label ID="ProductPrice" runat="server"></asp:Label></div>
                <div class="product-description"><asp:Label ID="ProductDescription" runat="server"></asp:Label></div>
                <asp:Button ID="btnAdd" runat="server" CssClass="btn-add-to-cart" Text="Thêm vào giỏ hàng" CommandName="AddToCart" CommandArgument='<%# Eval("product_id") %>' OnClick="btnAdd_Click" />
                <asp:Button ID="btnHome" runat="server" CssClass="btn-home" Text="Trở về Trang Chủ" OnClick="btnHome_Click" />
            </div>
        </div>

        <div class="related-products">
            <h2>Sản phẩm liên quan</h2>
            <asp:DataList ID="DataListRelatedProducts" runat="server" DataKeyField="product_id" RepeatColumns="4" OnItemCommand="DataListRelatedProducts_ItemCommand" Width="100%">
                <ItemTemplate>
                    <div class="related-product-item">
                        <asp:Image ID="Image1" runat="server" CssClass="related-product-image" ImageUrl='<%# "images/" + Eval("image") %>' />
                        <div>
                            <asp:Label ID="Label1" runat="server" CssClass="related-product-name" Text='<%# Eval("name") %>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" CssClass="related-product-price" Text='<%# Eval("price", "{0:N0} VNĐ") %>'></asp:Label><br />
                            <asp:Button ID="Button1" runat="server" CssClass="related-product-btn" Text="Xem chi tiết" CommandName="Detail" CommandArgument='<%# Eval("product_id") %>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </form>
</body>
</html>
