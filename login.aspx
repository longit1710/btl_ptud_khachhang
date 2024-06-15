<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="BTL_PTUD.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trang đăng nhập</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        #container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h1 {
            margin-bottom: 20px;
            font-size: 32px;
            color: #ff0000; /* Màu đỏ */
        }
        #login {
            margin-bottom: 20px;
        }
        #login label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #555;
            text-align: left;
        }
        #login input[type="text"], 
        #login input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        #btn {
            margin-top: 20px;
        }
        #btn .btn {
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        #btn .btn:hover {
            background-color: #0056b3;
        }
        footer {
            margin-top: 20px;
            font-size: 12px;
            color: #777;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="container">
            <h1>TRANG ĐĂNG NHẬP</h1>
            <div id="login">
                <asp:Label ID="email" runat="server" Text="Email"></asp:Label>
                <asp:TextBox ID="txtemail" runat="server" Height="30px" Width="100%" style="margin-left: 0px"></asp:TextBox>
                <asp:Label ID="mk" runat="server" Text="Mật khẩu"></asp:Label>
                <asp:TextBox ID="txtmk" runat="server" TextMode="Password" Height="30px" Width="100%" style="margin-left: 0px"></asp:TextBox>
            </div>
            <div id="btn">
                <asp:LinkButton ID="btndky" runat="server" CssClass="btn" OnClick="btndky_Click">Đăng ký</asp:LinkButton>
                <asp:Button ID="btnok" runat="server" CssClass="btn" Text="Đăng nhập" OnClick="btnok_Click" />
            </div>
            <footer>
                Fit_Haui - 05/2024
            </footer>
        </div>
    </form>
</body>
</html>
