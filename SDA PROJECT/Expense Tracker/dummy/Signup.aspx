<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="dummy.Signup" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="s.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

</head>
<body>
    <div class="container">
        <div class="pic"></div>
        <form class="signup-form" runat="server">
            <h2>Sign Up</h2>
            <input type="text" placeholder="Username" required runat="server" id="uname">
            <input type="email" placeholder="Email" required runat="server" id="email">
            <input type="password" placeholder="Password" required runat="server" id="pass">
            <input type="Date" placeholder="Date of Birth" required runat="server" id="dob"  max="2006-06-30">
            <button type="submit" runat="server" onserverclick="Sub_btn">Sign Up</button>
            <p class="login-link">Already have an account? <a href="login.aspx">Login</a></p>
        </form>
    </div>
</body>
</html>
