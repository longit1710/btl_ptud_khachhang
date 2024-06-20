<%@ Page Title="" Language="C#" MasterPageFile="~/dashboard.Master" AutoEventWireup="true" CodeBehind="Add_User.aspx.cs" Inherits="BTL_PTUD.Add_User" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    ADD User
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="text-2xl font-bold m-2">Thêm User</h1>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="user_id" DataSourceID="SqlDataSource2" DefaultMode="Insert">
        <EditItemTemplate>
            user_id:
            <asp:Label ID="user_idLabel1" runat="server" Text='<%# Eval("user_id") %>' />
            <br />
            first_name:
            <asp:TextBox ID="first_nameTextBox" runat="server" Text='<%# Bind("first_name") %>' />
            <br />
            last_name:
            <asp:TextBox ID="last_nameTextBox" runat="server" Text='<%# Bind("last_name") %>' />
            <br />
            email:
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
            <br />
            password:
            <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>' />
            <br />
            address:
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' />
            <br />
            phone_number:
            <asp:TextBox ID="phone_numberTextBox" runat="server" Text='<%# Bind("phone_number") %>' />
            <br />
            role:
            <asp:TextBox ID="roleTextBox" runat="server" Text='<%# Bind("role") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"/>
        </EditItemTemplate>
        <InsertItemTemplate>
            first_name:
            <asp:TextBox ID="first_nameTextBox" runat="server" Text='<%# Bind("first_name") %>' />
            <br />
            last_name:
            <asp:TextBox ID="last_nameTextBox" runat="server" Text='<%# Bind("last_name") %>' />
            <br />
            email:
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
            <br />
            password:
            <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>' />
            <br />
            address:
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' />
            <br />
            phone_number:
            <asp:TextBox ID="phone_numberTextBox" runat="server" Text='<%# Bind("phone_number") %>' />
            <br />
            role:
            <asp:TextBox ID="roleTextBox" runat="server" Text='<%# Bind("role") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            user_id:
            <asp:Label ID="user_idLabel" runat="server" Text='<%# Eval("user_id") %>' />
            <br />
            first_name:
            <asp:Label ID="first_nameLabel" runat="server" Text='<%# Bind("first_name") %>' />
            <br />
            last_name:
            <asp:Label ID="last_nameLabel" runat="server" Text='<%# Bind("last_name") %>' />
            <br />
            email:
            <asp:Label ID="emailLabel" runat="server" Text='<%# Bind("email") %>' />
            <br />
            password:
            <asp:Label ID="passwordLabel" runat="server" Text='<%# Bind("password") %>' />
            <br />
            address:
            <asp:Label ID="addressLabel" runat="server" Text='<%# Bind("address") %>' />
            <br />
            phone_number:
            <asp:Label ID="phone_numberLabel" runat="server" Text='<%# Bind("phone_number") %>' />
            <br />
            role:
            <asp:Label ID="roleLabel" runat="server" Text='<%# Bind("role") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ptudConnectionString %>" DeleteCommand="DELETE FROM [user] WHERE [user_id] = @user_id" InsertCommand="INSERT INTO [user] ([first_name], [last_name], [email], [password], [address], [phone_number], [role]) VALUES (@first_name, @last_name, @email, @password, @address, @phone_number, @role)" SelectCommand="SELECT * FROM [user]" UpdateCommand="UPDATE [user] SET [first_name] = @first_name, [last_name] = @last_name, [email] = @email, [password] = @password, [address] = @address, [phone_number] = @phone_number, [role] = @role WHERE [user_id] = @user_id">
        <DeleteParameters>
            <asp:Parameter Name="user_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="first_name" Type="String" />
            <asp:Parameter Name="last_name" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="password" Type="String" />
            <asp:Parameter Name="address" Type="String" />
            <asp:Parameter Name="phone_number" Type="String" />
            <asp:Parameter Name="role" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="first_name" Type="String" />
            <asp:Parameter Name="last_name" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="password" Type="String" />
            <asp:Parameter Name="address" Type="String" />
            <asp:Parameter Name="phone_number" Type="String" />
            <asp:Parameter Name="role" Type="String" />
            <asp:Parameter Name="user_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ptudConnectionString %>" DeleteCommand="DELETE FROM [user] WHERE [user_id] = @user_id" InsertCommand="INSERT INTO [user] ([first_name], [last_name], [email], [password], [address], [phone_number], [role]) VALUES (@first_name, @last_name, @email, @password, @address, @phone_number, @role)" SelectCommand="SELECT * FROM [user]" UpdateCommand="UPDATE [user] SET [first_name] = @first_name, [last_name] = @last_name, [email] = @email, [password] = @password, [address] = @address, [phone_number] = @phone_number, [role] = @role WHERE [user_id] = @user_id">
        <DeleteParameters>
            <asp:Parameter Name="user_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="first_name" Type="Int32" />
            <asp:Parameter Name="last_name" Type="Int32" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="password" Type="String" />
            <asp:Parameter Name="address" Type="String" />
            <asp:Parameter Name="phone_number" Type="String" />
            <asp:Parameter Name="role" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="first_name" Type="Int32" />
            <asp:Parameter Name="last_name" Type="Int32" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="password" Type="String" />
            <asp:Parameter Name="address" Type="String" />
            <asp:Parameter Name="phone_number" Type="String" />
            <asp:Parameter Name="role" Type="String" />
            <asp:Parameter Name="user_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <a href="QL_User.aspx" class="text-rose-500 underline">Danh sach User</a>
</asp:Content>
