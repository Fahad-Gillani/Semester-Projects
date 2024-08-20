<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="dummy.Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="l.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="pic">
        </div>
        <form class="login-form" runat="server">
            <h2>Login</h2>
            <input type="text" placeholder="Username" required runat="server" id="us">
            <input type="password" placeholder="Password" required runat="server" id="pass">
            <button type="submit" runat="server" onserverclick="Sub_Btn">Login</button>
            <center><p class="signup-link"><a href="Forgot.aspx">Forgot Password?</a></p></center>
            <p class="signup-link">Don't have an account? <a href="Signup.aspx">Sign up</a></p>
        </form>
    </div>
</body>
</html>
