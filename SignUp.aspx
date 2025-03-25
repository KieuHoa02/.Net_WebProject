﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="WebApplication1.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Sign Up to Food Paradise</title>
    <!-- Thêm FontAwesome để sử dụng icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #F9C6CF;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        form {
            background-color: #FFFFFF;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 320px;
            text-align: center;
        }

        p {
            color: #9111A5;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .input-container {
            position: relative;
            margin-bottom: 15px;
        }

        .input-container i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #9111A5;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px 10px 10px 35px;
            border: 2px solid #9111A5;
            border-radius: 15px;
            font-size: 16px;
            box-sizing: border-box;
            outline: none;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #7A0D8C;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .button-container .aspButton {
            background-color: #9111A5;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 15px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .button-container .aspButton:hover {
            background-color: #7A0D8C;
        }

        .logo {
    width: 100%; /* Chiều rộng 100% theo form */
    max-width: 1000px; /* Giữ ảnh không quá lớn */
    height: auto; /* Đảm bảo ảnh không bị méo */
    display: block;
    margin: 0 auto 15px; /* Canh giữa */
    border-radius: 10px; /* Bo góc nhẹ */
    object-fit: contain; /* Hiển thị ảnh đúng tỉ lệ */
}


    </style>
</head>

<body>
    <form id="form1" runat="server">
        <img src="KH.png" alt="Food Paradise Logo" class="logo">
        <p>SIGN UP HERE TO JOIN THE FOOD PARADISE</p>

        <!-- Username field với icon -->
        <div class="input-container">
    <i class="fas fa-user"></i>
    <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" CssClass="asp-input"></asp:TextBox>
</div>

<div class="input-container">
    <i class="fas fa-lock"></i>
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" CssClass="asp-input"></asp:TextBox>
</div>

        <!-- Nút bấm -->
       <div class="button-container">
    <asp:Button ID="Button1" runat="server" Text="SIGN UP" CssClass="aspButton" OnClick="Button1_Click" />
    <asp:Button ID="Button2" runat="server" Text="LOG IN" CssClass="aspButton" OnClick="Button2_Click" />
    <asp:Button ID="Button3" runat="server" Text="CANCEL" CssClass="aspButton" OnClick="Button3_Click"  />
</div>

    </form>
</body>

</html>