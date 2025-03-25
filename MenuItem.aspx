<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuItem.aspx.cs" Inherits="WebApplication1.MenuItem" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Menu Items</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Giữ nguyên các phần khác */
    .GridViewStyle th, .GridViewStyle td {
        text-align: center;
        vertical-align: middle;
    }

    
    .GridViewStyle input[type="text"] {
        width: 100px !important;
        font-size: 14px;
        padding: 4px;
    }

    
    .GridViewStyle .btn {
        padding: 5px 10px;
        font-size: 14px;
    }

        body {
            background-color: #fce4ec;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .gridview-container {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0px 0px 20px rgba(138, 43, 226, 0.3);
        }
        h2 {
            text-align: center;
            color: #8A2BE2;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .add-form {
            display: none;
            background: #fff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(138, 43, 226, 0.2);
            margin-bottom: 20px;
        }
        .btn-add {
            background-color: #8A2BE2;
            color: white;
            border-radius: 8px;
            padding: 10px;
        }
        .btn-add:hover {
            background-color: #FF69B4;

        }
        .GridViewStyle th {           
            text-align: center;
            padding: 12px;
            font-size: 16px;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="gridview-container">
                <h2>
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="BACK" />
                </h2>
                <h2>Menu Management</h2>

                <div class="d-flex justify-content-end align-items-center mb-3">
                    <div class="me-2">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter dish name..."></asp:TextBox>
                    </div>
                    <div class="me-3">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                    </div>
                    <div>
                        <asp:Button ID="btnShowAddForm" runat="server" CssClass="btn btn-success" Text="Add dishes" OnClientClick="showAddForm(); return false;" />
                    </div>
                </div>


                <div class="add-form" id="addForm">
                    <h4 class="text-center text-primary">Add new dishes</h4>
                    <div class="row">
                        <div class="col-md-4">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name of dish"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Price"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Describe"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-4">
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select category" Value="" Selected="True" Disabled="True"></asp:ListItem>
                                <asp:ListItem Text="Appetizer" Value="Appetizer"></asp:ListItem>
                                <asp:ListItem Text="Main course" Value="Main Course"></asp:ListItem>
                                <asp:ListItem Text="Dessert" Value="Dessert"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-4">
                            <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" />
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Type:</label>
                            <div>
                                <asp:RadioButton ID="rbFood" runat="server" GroupName="TypeGroup" Text="Food" CssClass="form-check-input" />
                                <label for="rbFood" class="form-check-label"></label>
                            </div>
                            <div>
                                <asp:RadioButton ID="rbDrink" runat="server" GroupName="TypeGroup" Text="Drink" CssClass="form-check-input" />
                                <label for="rbDrink" class="form-check-label"></label>
                            </div>
                        </div>

                    </div>
                    <div class="text-center mt-3">
                        <asp:Button ID="btnAdd" runat="server" Text="Add dishes" CssClass="btn btn-add" OnClick="btnAdd_Click" />
                    </div>
                </div>
                
               <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-bordered GridViewStyle"
                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                    DataKeyNames="ItemID" 
                    PageSize="5"
                    OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowCommand="GridView1_RowCommand"
                    OnRowEditing="GridView1_RowEditing"
                    OnRowUpdating="GridView1_RowUpdating"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowDeleting="GridView1_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="ItemID" HeaderText="ID" ReadOnly="True" SortExpression="ItemID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" 
                    DataFormatString="{0:#,0}" HtmlEncode="False" />

                    <asp:BoundField DataField="Description" HeaderText="Describe" SortExpression="Description" />
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />

        
        <asp:TemplateField HeaderText="Update">
            <ItemTemplate>
                <asp:HyperLink ID="lnkUpdate" runat="server" CssClass="btn btn-info" 
                    NavigateUrl='<%# "MenuItemDetail.aspx?ItemID=" + Eval("ItemID") %>' 
                    Text="Update" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="View Detail">
            <ItemTemplate>
                <asp:HyperLink ID="lnkViewDetail" runat="server" CssClass="btn btn-info" 
                    NavigateUrl='<%# "ViewDetail.aspx?ItemID=" + Eval("ItemID") %>' 
                    Text="View Detail" />
            </ItemTemplate>
        </asp:TemplateField>
     

        <%-- Cột chức năng Delete --%>
        <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("ItemID") %>' CssClass="btn btn-danger" OnClientClick="return confirm('Are you sure you want to delete this product?');" />
            </ItemTemplate>
        </asp:TemplateField>


    </Columns>
</asp:GridView>

                
                
            </div>
        </div>
    </form>

<script>
    function showAddForm() {
        document.getElementById("addForm").style.display = "block";
    }
    function hideDetailForm() {
        document.getElementById("detailForm").style.display = "none";
    }
    function showDetailForm() {
        document.getElementById("detailForm").style.display = "block";
    }
</script>

</body>
</html>
