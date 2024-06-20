<%@ Page Title="" Language="C#" MasterPageFile="~/dashboard.Master" AutoEventWireup="true" CodeBehind="QL_Product.aspx.cs" Inherits="BTL_PTUD.QL_Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
QL Product
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="text-2xl font-bold m-2">Quản lý Product</h1>
    <a href="Add_Product.aspx" class="bg-red-500 text-white px-3 rounded-sm">ADD Product</a>
    <asp:TextBox ID="txtSearch" runat="server" />
    <asp:Button ID="cmdSearch" runat="server" Text="Search" OnClick="cmdSearch_Click" />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="product_id" DataSourceID="SqlDataSource1" Width="1280px" style="margin-right: 0px" Height="272px" OnRowUpdating="GridView1_RowUpdating">
        <Columns>
            <asp:BoundField DataField="product_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="product_id" />
            <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                    <img src='<%# "/images/" + Eval("image") %>' width="50" height="50" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                    <asp:HiddenField ID="HiddenImageField" runat="server" Value='<%# Bind("image") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
            <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
            <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
            <asp:BoundField DataField="salecount" HeaderText="Salecount" SortExpression="salecount" />
            <asp:BoundField DataField="category_id" HeaderText="Category ID" SortExpression="category_id" />
            <asp:BoundField DataField="date_added" HeaderText="Date Added" SortExpression="date_added" />
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" OnClick="LinkButton1_Click"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Ban co chac muon xoa?')"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ptudConnectionString %>" 
        DeleteCommand="DELETE FROM [product] WHERE [product_id] = @product_id" 
        InsertCommand="INSERT INTO [product] ([image], [name], [description], [price], [salecount], [category_id], [date_added]) VALUES (@image, @name, @description, @price, @salecount, @category_id, @date_added)" 
        SelectCommand="SELECT [product_id], [image], [name], [description], [price], [salecount], [category_id], [date_added] FROM [product]" 
        UpdateCommand="UPDATE [product] SET [image] = @image, [name] = @name, [description] = @description, [price] = @price, [salecount] = @salecount, [category_id] = @category_id, [date_added] = @date_added WHERE [product_id] = @product_id">
        
        <DeleteParameters>
            <asp:Parameter Name="product_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="image" Type="String" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="price" Type="Decimal" />
            <asp:Parameter Name="salecount" Type="Int32" />
            <asp:Parameter Name="category_id" Type="Int32" />
            <asp:Parameter DbType="Date" Name="date_added" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="image" Type="String" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="price" Type="Decimal" />
            <asp:Parameter Name="salecount" Type="Int32" />
            <asp:Parameter Name="category_id" Type="Int32" />
            <asp:Parameter DbType="Date" Name="date_added" />
            <asp:Parameter Name="product_id" Type="Int32" />
        </UpdateParameters>
        <FilterParameters>
            <asp:Parameter Name="searchTerm" Type="String" />
        </FilterParameters>
    </asp:SqlDataSource>
</asp:Content>
