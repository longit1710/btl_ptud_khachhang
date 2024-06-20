<%@ Page Title="" Language="C#" MasterPageFile="~/dashboard.Master" AutoEventWireup="true" CodeBehind="QL_User.aspx.cs" Inherits="BTL_PTUD.QL_User" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
QL User
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="text-2xl font-bold m-2">Quản lý User</h1>
    <a href="Add_User.aspx" class="bg-red-500 text-white px-3 rounded-sm">ADD User</a>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="user_id" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
    <Columns>
        <asp:BoundField DataField="user_id" HeaderText="User ID" InsertVisible="False" ReadOnly="True" SortExpression="user_id" />
        <asp:BoundField DataField="first_name" HeaderText="First Name" SortExpression="first_name" />
        <asp:BoundField DataField="last_name" HeaderText="Last Name" SortExpression="last_name" />
        <asp:BoundField DataField="email" HeaderText="Email" />
        <asp:BoundField DataField="address" HeaderText="Address" SortExpression="address" />
        <asp:BoundField DataField="phone_number" HeaderText="Phone Number" SortExpression="phone_number" />
        <asp:BoundField DataField="role" HeaderText="Role" SortExpression="role" />
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ptudConnectionString %>" DeleteCommand="DELETE FROM [user] WHERE [user_id] = @user_id" InsertCommand="INSERT INTO [user] ([first_name], [last_name], [email], [address], [phone_number], [role]) VALUES (@first_name, @last_name, @email, @address, @phone_number, @role)" SelectCommand="SELECT [user_id], [first_name], [last_name], [email], [address], [phone_number], [role] FROM [user]" UpdateCommand="UPDATE [user] SET [first_name] = @first_name, [last_name] = @last_name, [email] = @email, [address] = @address, [phone_number] = @phone_number, [role] = @role WHERE [user_id] = @user_id">
    <DeleteParameters>
        <asp:Parameter Name="user_id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="first_name" Type="String" />
        <asp:Parameter Name="last_name" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="address" Type="String" />
        <asp:Parameter Name="phone_number" Type="String" />
        <asp:Parameter Name="role" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="first_name" Type="String" />
        <asp:Parameter Name="last_name" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="address" Type="String" />
        <asp:Parameter Name="phone_number" Type="String" />
        <asp:Parameter Name="role" Type="String" />
        <asp:Parameter Name="user_id" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
