<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuItemDetail.aspx.cs" Inherits="WebApplication1.MenuItemDetail" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cập nhật sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h2 class="text-center text-primary">Update dishes</h2>
            <div class="card p-3">
                <div class="mb-3">
                    <label class="form-label"><strong>Dish name:</strong></label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Price:</strong></label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Describe:</strong></label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" />
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Category:</strong></label>
                    <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Type:</strong></label>
                    <asp:TextBox ID="txtType" runat="server" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Image:</strong></label>
                    <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" />
                    <asp:Image ID="imgFood" runat="server" Width="300px" Height="300px" CssClass="img-thumbnail mt-2" />
                </div>
                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                <a href="MenuItem.aspx" class="btn btn-secondary mt-3">Back</a>
            </div>
        </div>
    </form>
</body>
</html>
