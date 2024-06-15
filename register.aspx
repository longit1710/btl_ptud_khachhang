<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="BTL_PTUD.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng ký</title>
    <link href="style.css" type="text/css" rel="stylesheet" />
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

        #registration {
            margin-bottom: 20px;
        }

        #registration table {
            width: 100%;
        }

        #registration td {
            padding: 10px 0;
            text-align: left;
            font-weight: bold;
            color: #555;
        }

        #registration input[type="text"], 
        #registration input[type="password"] {
            width: calc(100% - 20px);
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        #registration .btn {
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

        #registration .btn:hover {
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
            <h1>Đăng ký tài khoản</h1>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <div id="registration">
                <table>
                    <tr>
                        <td>Họ:</td>
                        <td><asp:TextBox ID="txtFirstName" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Tên:</td>
                        <td><asp:TextBox ID="txtLastName" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td><asp:TextBox ID="txtEmail" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Mật khẩu:</td>
                        <td><asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Xác nhận mật khẩu:</td>
                        <td><asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Địa chỉ:</td>
                        <td><asp:TextBox ID="txtAddress" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Số điện thoại:</td>
                        <td><asp:TextBox ID="txtPhoneNumber" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnRegister" runat="server" Text="Đăng ký" OnClick="btnRegister_Click" CssClass="btn" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
</html>
