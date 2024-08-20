<%@ Page Language="C#" Debug="true" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="dummy.Home" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
    <link rel="stylesheet" href="ds.css"/>
    <style>
        .highcharts-container {
            border-radius: 10px; /* Adjust the value as needed */
            border:1px solid white;
        }
    </style>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                            <li class="active">
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
                <div class="col-md-9 card_div">
                    <!-- Main Content -->
                    <div class="main-content">
                        <div class="row">
                            <div class="col-md-4">
                                
                                    <div class="card-body">
                                        <span class="icon"><i class="fas fa-wallet"></i></span>
                                        <div class="card-content">
                                            <h5 class="card-title">Total Income</h5>
                                            <label class="card-text" runat="server" id="inc"></label>
                                        </div>
                                    </div>
                                 
                            </div>
                            <div class="col-md-4">
                                <div class="card-body">
       
                                        <span class="icon"><i class="fas fa-money-bill-wave"></i></span>
                                        <div class="card-content">
                                            <h5 class="card-title">Total Expense</h5>
                                            <label class="card-text" runat="server" id="exp"></label>
                                        </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                    <div class="card-body">
                                        <span class="icon"><i class="fas fa-balance-scale"></i></span>
                                        <div class="card-content">
                                            <h5 class="card-title">Total Balance</h5>
                                            <label class="card-text" runat="server" id="bal"></label>
                                    </div>
                                </div>
                            </div>
                            <div id="LineChart"></div>
                            <div id="DonutChart"></div>
                            <div id="IncomeExpenseLineChart"></div>
                        </div>
                    </div>
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
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/boost.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script>
        jQuery(document).ready(function () {
            jQuery('#LineChart').highcharts({
                chart: {
                    type: 'spline',
                    backgroundColor: 'rgba(255, 255, 255, 0.1)'  
                },
                title: {
                    text: 'Monthly Expense',
                    style: {
                        color: 'lightgrey'  
                    }
                },
                xAxis: {
                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    gridLineWidth: 0,  
                    labels: {
                        style: {
                            color: 'lightgrey' 
                        }
                    }
                },
                yAxis: {
                    title: {
                        text: '',
                        style: {
                            color: 'lightgrey'  
                        }
                    },
                    gridLineWidth: 0,  
                    labels: {
                        style: {
                            color: 'lightgrey'  
                        }
                    }
                },
                series: [{
                    type: 'spline',
                    name: 'Monthly Expense',
                    color: 'orange',  
                    data: <%=lineData%>,
            dataLabels: {
                style: {
                    color: 'lightgrey'  
                }
            }
        }],
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 500
                },
            }]
        }
    });
        });

        jQuery(document).ready(function () {
            jQuery('#DonutChart').highcharts({
                chart: {
                    type: 'pie',
                    backgroundColor: 'rgba(255, 255, 255, 0.1)' 
                },
                title: {
                    text: 'Expense Distribution by Category',
                    style: {
                        color: 'lightgrey'  
                    }
                },
                plotOptions: {
                    pie: {
                        innerSize: '65%',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            style: {
                                color: 'lightgrey',  
                                textOutline: 0  
                            }
                        },
                        borderWidth: 10,  
                        borderColor: 'transparent'  
                    }
                },
                series: [{
                    name: 'Total Expense',
                    colorByPoint: true,
                    data: <%= donutData %>,
            dataLabels: {
                style: {
                    color: 'lightgrey'
                }
            }
        }],
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 500
                },
            }]
        }
    });
});

jQuery(document).ready(function () {
    jQuery('#IncomeExpenseLineChart').highcharts({
        chart: {
            type: 'column',
            backgroundColor: 'rgba(255, 255, 255, 0.1)'  
        },
        title: {
            text: 'Monthly Income vs. Expense',
            style: {
                color: 'lightgrey'  
            }
        },
        xAxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            gridLineWidth: 0,  
            labels: {
                style: {
                    color: 'lightgrey' 
                }
            }
        },
        yAxis: {
            title: {
                text: '',
                style: {
                    color: 'lightgrey'  
                }
            },
            gridLineWidth: 0,  
            labels: {
                style: {
                    color: 'lightgrey'  
                }
            }
        },
        plotOptions: {
            column: {
                colorByPoint: true,  
                colors: ['#FFA500', '#FFD700', '#FF8C00', '#FF4500', '#D2691E', '#B8860B', '#CD853F', '#A0522D', '#8B4513', '#800000', '#B22222', '#DC143C'] // Custom colors for the bars
            }
        },
        series: [{
            name: 'Income',
            data: <%=incomeData%>,
            dataLabels: {
                style: {
                    color: 'lightgrey'  
                }
            }
        }, {
            name: 'Expense',
                data: <%=expenseData%>,
                dataLabels: {
                    style: {
                        color: 'lightgrey'  
                    }
                }
            }]
    });
});

    </script>        
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
