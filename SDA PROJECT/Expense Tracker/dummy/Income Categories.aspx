<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Income Categories.aspx.cs" Inherits="dummy.Income_Categories" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Income Categories</title>
    <link rel="stylesheet" type="text/css" href="IE.css" />
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
             <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

    <style type="text/css">
        .auto-style1 {
            height: 463px;
        }
    </style>
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
                        <li>
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
                                <li class="submenu-item-spacing active"><a href="Income Categories.aspx"><i class="fas fa-wallet"></i> Income Categories</a></li>
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
        </div>
    </div>
      <div class="header">
    <h1 style="font-size:2rem">Manage Income Categories</h1>
</div>
<div class="main-content">
    <div class="buttons">
        <input name="add_icat" type="text" id="add_icat" class="form-control" style="width: 210px;" runat="server"/>
        <button type="button" class="btn btn-new-transaction" runat="server" onserverclick="Add_INC_Category">Add New Category</button> 
    </div>
    <div class="history">
        <h3>History of Income Categories</h3>
        <div class="auto-style1">
             <asp:GridView ID="GD" runat="server" AutoGenerateColumns="False" CssClass="table gridview" OnRowDeleting="Del_INC_Cat" DataKeyNames="Category"
     EnableViewState="true">
    <Columns>
        <asp:TemplateField HeaderText="Category">
           <ItemTemplate>
               <%# Eval("Category") %>
           </ItemTemplate>
           <EditItemTemplate>
               <asp:TextBox ID="txtCat" runat="server" Text='<%# Bind("Category") %>' ></asp:TextBox>
           </EditItemTemplate>
       </asp:TemplateField>
        <asp:CommandField ShowDeleteButton="true" ControlStyle-CssClass="btn btn-danger" />
        
    </Columns>
</asp:GridView>

        </div>
    </div>
</div>
    </form>
  <script>
      document.addEventListener('DOMContentLoaded', function () {
          const collapsibleElements = document.querySelectorAll('.collapsible');

          collapsibleElements.forEach(function (collapsible) {
              collapsible.addEventListener('click', function () {
                  this.classList.toggle('active');
                  const submenu = this.querySelector('.submenu');
                  const indicator = this.querySelector('.indicator i');

                  if (submenu.style.maxHeight) {
                      submenu.style.maxHeight = null;
                      indicator.style.transform = 'rotate(0deg)';
                  } else {
                      submenu.style.maxHeight = submenu.scrollHeight + 'px';
                      indicator.style.transform = 'rotate(180deg)';
                  }
              });
          });
      });

 </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
