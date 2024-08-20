<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Income.aspx.cs" Inherits="dummy.Income" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Income</title>
    <link rel="stylesheet" type="text/css" href="IE.css" />
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
                        <li class="active">
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
                                <li class="submenu-item-spacing "><a href="Income Categories"><i class="fas fa-wallet"></i> Income Categories</a></li>
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
    <h1 style="font-size:2rem">Income Reports</h1>
</div>
<div class="main-content">
    <div class="buttons">
        <button class="btn btn-new-transaction" runat="server" onserverclick="NewTR">+ New Transaction</button>
        <button class="btn btn-download-reports" runat="server" onserverclick="Btn_PDF">Download Expense Reports</button>
        <button class="btn btn-download-csv" runat="server" onserverclick="Btn_CSV">Download Expense CSV</button>
        <div class="form-group">
            <select class="form-control" id="icategory" name="category" runat="server" ></select>
            <button class="btn btn-filter" runat="server" onserverclick="Filter">Filter</button>
            <button class="btn btn-Clear" runat="server" onserverclick="Clear">Clear</button>
        </div>
    </div>

    <div class="history">
        <h3>History of Income</h3>
        <div class="auto-style1">
             <asp:GridView ID="GD" runat="server" AutoGenerateColumns="False" CssClass="gridview table" OnRowDeleting="Del_INC" DataKeyNames="Name"  OnRowCancelingEdit="Cancel_Up_INC" OnRowEditing="Edit_Income" OnRowUpdating="Up_Income">
                 <Columns>
                      <asp:TemplateField HeaderText="S.No" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lbl_id" runat="server" Text='<%#Eval("id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Name" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_Name" runat="server" Text='<%#Eval("Name") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Amount" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_Amount" runat="server" Text='<%#Eval("Amount") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                      <asp:TemplateField HeaderText="Category">
                         <ItemTemplate>
                             <asp:Label ID="lbl_Cat" runat="server" Text='<%#Eval("Category") %>'></asp:Label>
                         </ItemTemplate>
                     </asp:TemplateField>
                      <asp:TemplateField HeaderText="Income User" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lbl_IncUser" runat="server" Text='<%#Eval("IncUser") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Date" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Date", "{0:yyyy-MM-dd}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                      <asp:TemplateField HeaderText="Description">
                         <ItemTemplate>
                             <asp:Label ID="lbl_Desc" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txt_Desc" runat="server" Text='<%#Eval("Description") %>'></asp:TextBox>
                         </EditItemTemplate>
                     </asp:TemplateField>
                      <asp:CommandField ShowDeleteButton="true" ControlStyle-CssClass="btn btn-danger" />
                      <asp:TemplateField>
                 <ItemTemplate>
                     <asp:Button ID="btn_Edit" runat="server" Text="Edit" CommandName="Edit" ControlStyle-CssClass="btn btn-primary"/>
                 </ItemTemplate>
                 <EditItemTemplate>
                     <asp:Button ID="btn_Update" runat="server" Text="Update" CommandName="Update" ControlStyle-CssClass="btn btn-primary"/>
                     <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" CommandName="Cancel" ControlStyle-CssClass="btn btn-danger"/>
                 </EditItemTemplate>
                     </asp:TemplateField>
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
</body>
</html>
