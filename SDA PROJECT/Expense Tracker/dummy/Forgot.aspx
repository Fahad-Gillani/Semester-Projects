<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forgot.aspx.cs" Inherits="dummy.Forgot" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="f.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="pic">
        </div>
        <form class="login-form" runat="server">
            <h2>Reset Password</h2>
            <input type="email" placeholder="Enter Email" required runat="server" id="us">
            <input type="number" placeholder="Enter OTP" runat="server" id="otptxt" visible="false">
            <input type="password" placeholder="Enter New Password" runat="server" id="pass" visible="false">
             <button type="submit" runat="server" onserverclick="Gen_Btn" id="otp_btn">Generate OTP</button>
             <button type="submit" runat="server" onserverclick="Sub_Btn" id="sb_btn" visible="false">Submit</button>
            <button type="submit" runat="server" onserverclick="Upd_Btn" id="up_btn" visible="false">Update Password</button>
            <p class="signup-link"><a href="Login.aspx">Go back to Login</a></p>
        </form>
    </div>
</body>
</html>
