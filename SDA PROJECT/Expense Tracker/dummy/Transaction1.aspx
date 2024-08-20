<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transaction1.aspx.cs" Inherits="dummy.Transaction1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Transaction</title>
    <link rel="stylesheet" type="text/css" href="transaction.css" />
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <!-- Sidebar -->
                    <div class="sidebar">
                        <div class="sidebar-header">
                            <h3>Expense Tracker</h3>
                        </div>
                        <ul class="sidebar-menu">
                            <li>
                                <a href="Home.aspx">
                                    <span class="icon"><i class="fas fa-tachometer-alt"></i></span>
                                    <span class="text">Dashboard</span>
                                </a>
                            </li>
                            <li class="active">
                                <a href="Transaction1.aspx">
                                    <span class="icon"><i class="fas fa-file-invoice"></i></span>
                                    <span class="text">Transaction</span>
                                </a>
                            </li>
                            <li>
                                <a href="Expense.aspx">
                                    <span class="icon"><i class="fas fa-briefcase"></i></span>
                                    <span class="text">Expense</span>
                                </a>
                            </li>
                            <li>
                                <a href="Income.aspx">
                                    <span class="icon"><i class="fas fa-money-bill-wave"></i></span>
                                    <span class="text">Income</span>
                                </a>
                            </li>
                            <li class="collapsible">
                                <a href="#">
                                    <span class="icon"><i class="fas fa-cogs"></i></span>
                                    <span class="text">Manage Categories</span>
                                    <span><i class="fas fa-chevron-down"></i></span>
                                </a>
                                <ul class="submenu">
                                    <li><a href="Expense Categories.aspx"><i class="fas fa-tags"></i> Expense Categories</a></li>
                                    <li class="submenu-item-spacing"><a href="Income Categories.aspx"><i class="fas fa-wallet"></i> Income Categories</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="Login.aspx" runat="server" onserverclick="Logout">
    <span class="icon"><i class="fas fa-sign-out-alt"></i></span>
     <span class="text" runat="server">Logout</span>
</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6">
                    <!-- Transaction Form -->
                    <div class="transaction-form">
                        <div class="transaction-header">
                            <h3>Income</h3>
                        </div>
                        <div class="form-group">
                            <label for="name"><i class="fas fa-user"></i> Name</label>
                            <input type="text" class="form-control" id="iname" name="name" runat="server"/>
                        </div>
                        <div class="form-group">
                            <label for="amount"><i class="fas fa-dollar-sign"></i> Amount</label>
                            <input type="number" class="form-control" id="iamount" name="amount" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="category"><i class="fas fa-list"></i> Category</label>
                            <select class="form-control" id="icategory" name="category" runat="server"></select>
                        </div>
                        <div class="form-group">
                            <label for="date"><i class="fas fa-calendar"></i> Date</label>
                            <input type="date" class="form-control" id="idate" name="date" runat="server" max="2024-06-30"/>
                        </div>
                        <div class="form-group">
                            <label for="description"><i class="fas fa-comment"></i> Description</label>
                            <textarea class="form-control" id="idescription" name="description" runat="server" style="grid-column:span 2"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary" id="isub" runat="server" onserverclick="IButton">Submit</button>
                    </div>
                </div>
                <div class="col-md-6">
                    <!-- Expense Form -->
                    <div class="transaction-form2">
                        <div class="transaction-header">
                            <h3>Expense</h3>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Name</label>
                            <input type="text" class="form-control" id="ename" name="name" runat="server" />
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-dollar-sign"></i> Amount</label>
                            <input type="number" class="form-control" id="eamount" name="amount" runat="server" />
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-list"></i> Category</label>
                            <select class="form-control" id="ecategory" name="category" runat="server" ></select>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-calendar"></i> Date</label>
                            <input type="date" class="form-control" id="edate" name="date" runat="server" max="2024-06-30"/>
                        </div>
                        <div class="form-group">
                            <label for="description"><i class="fas fa-comment"></i> Description</label>
                            <textarea class="form-control" id="edescription" name="description" runat="server"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary" runat="server" onserverclick="EButton">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <h2 class="theader">Transaction</h2>
    <script>
        document.querySelectorAll('.sidebar-menu li a').forEach(function (element) {
            element.addEventListener('click', function (event) {
                console.log("Link clicked!");
                // Remove active class from all items
                document.querySelectorAll('.sidebar-menu li').forEach(function (el) {
                    el.classList.remove('active');
                });
                // Add active class to clicked item's parent <li>
                element.parentElement.classList.add('active');
            });
        });
    </script>
</body>
</html>
