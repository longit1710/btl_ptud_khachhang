<%@ Page Title="" Language="C#" MasterPageFile="~/dashboard.Master" AutoEventWireup="true" CodeBehind="Add_Product.aspx.cs" Inherits="BTL_PTUD.Add_Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Add product
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="text-2xl font-bold m-2">Thêm Sản phẩm</h1>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="product_id" DataSourceID="SqlDataSource1" DefaultMode="Insert" OnItemInserting="ItemInserting">
        <EditItemTemplate>
            product_id:
            <asp:Label ID="product_idLabel1" runat="server" Text='<%# Eval("product_id") %>' />
            <br />
            name:
            <asp:TextBox ID="nameTextBox" runat="server" Text='<%# Bind("name") %>' />
            <br />
            description:
            <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' />
            <br />
            price:
            <asp:TextBox ID="priceTextBox" runat="server" Text='<%# Bind("price") %>' />
            <br />
            salecount:
            <asp:TextBox ID="salecountTextBox" runat="server" Text='<%# Bind("salecount") %>' />
            <br />
            category_id:
            <asp:TextBox ID="category_idTextBox" runat="server" Text='<%# Bind("category_id") %>' />
            <br />
            image:
            <asp:TextBox ID="imageTextBox" runat="server" Text='<%# Bind("image") %>' />
            <br />
            date_added:
            <asp:TextBox ID="date_addedTextBox" runat="server" Text='<%# Bind("date_added") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            name:
            <asp:TextBox ID="nameTextBox" runat="server" Text='<%# Bind("name") %>' />
            <br />
            description:
            <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' />
            <br />
            price:
            <asp:TextBox ID="priceTextBox" runat="server" Text='<%# Bind("price") %>' />
            <br />
            salecount:
            <asp:TextBox ID="salecountTextBox" runat="server" Text='<%# Bind("salecount") %>' />
            <br />
            category_id:
            <asp:TextBox ID="category_idTextBox" runat="server" Text='<%# Bind("category_id") %>' />
            <br />
            image:
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <br />
            date_added:
            <asp:TextBox ID="date_addedTextBox" runat="server" Text='<%# Bind("date_added") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            product_id:
            <asp:Label ID="product_idLabel" runat="server" Text='<%# Eval("product_id") %>' />
            <br />
            name:
            <asp:Label ID="nameLabel" runat="server" Text='<%# Bind("name") %>' />
            <br />
            description:
            <asp:Label ID="descriptionLabel" runat="server" Text='<%# Bind("description") %>' />
            <br />
            price:
            <asp:Label ID="priceLabel" runat="server" Text='<%# Bind("price") %>' />
            <br />
            salecount:
            <asp:Label ID="salecountLabel" runat="server" Text='<%# Bind("salecount") %>' />
            <br />
            category_id:
            <asp:Label ID="category_idLabel" runat="server" Text='<%# Bind("category_id") %>' />
            <br />
            image:
            <asp:Label ID="imageLabel" runat="server" Text='<%# Bind("image") %>' />
            <br />
            date_added:
            <asp:Label ID="date_addedLabel" runat="server" Text='<%# Bind("date_added") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ptudConnectionString %>" DeleteCommand="DELETE FROM [product] WHERE [product_id] = @product_id" InsertCommand="INSERT INTO [product] ([name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (@name, @description, @price, @salecount, @category_id, @image, @date_added)" SelectCommand="SELECT * FROM [product]" UpdateCommand="UPDATE [product] SET [name] = @name, [description] = @description, [price] = @price, [salecount] = @salecount, [category_id] = @category_id, [image] = @image, [date_added] = @date_added WHERE [product_id] = @product_id">
        <DeleteParameters>
            <asp:Parameter Name="product_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="price" Type="Decimal" />
            <asp:Parameter Name="salecount" Type="Int32" />
            <asp:Parameter Name="category_id" Type="Int32" />
            <asp:Parameter Name="image" Type="String" />
            <asp:Parameter DbType="Date" Name="date_added" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="price" Type="Decimal" />
            <asp:Parameter Name="salecount" Type="Int32" />
            <asp:Parameter Name="category_id" Type="Int32" />
            <asp:Parameter Name="image" Type="String" />
            <asp:Parameter DbType="Date" Name="date_added" />
            <asp:Parameter Name="product_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <a href="QL_Product.aspx" class="text-rose-500 underline">Danh sách sản phẩm</a>
</asp:Content>
