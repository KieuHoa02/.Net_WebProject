<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewDetail.aspx.cs" Inherits="WebApplication1.MenuItemDetail" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dish Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="card shadow p-4">
                <h2 class="text-center text-primary">Dish information</h2>
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label"><strong>Name of dish:</strong></label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ReadOnly="true" />

                        </div>
                        <div class="mb-3">
                            <label class="form-label"><strong>Price:</strong></label>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" ReadOnly="true" />

                        </div>
                        <div class="mb-3">
                            <label class="form-label"><strong>Describe:</strong></label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" ReadOnly="true" TextMode="MultiLine" />

                        </div>
                        <div class="mb-3">
                            <label class="form-label"><strong>Category:</strong></label>
                            <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" ReadOnly="true" />

                        </div>
                        <div class="mb-3">
                            <label class="form-label"><strong>Type:</strong></label>
                            <asp:TextBox ID="txtType" runat="server" CssClass="form-control" ReadOnly="true" />

                        </div>
                    </div>
                    <div class="col-md-6 text-center">
                        <asp:Image ID="imgFood" runat="server" Width="300px" Height="300px" CssClass="img-thumbnail mt-2" />
                    </div>
                </div>
                <div class="text-center mt-4">
                    <a href="MenuItem.aspx" class="btn btn-secondary">Back</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
