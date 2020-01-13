<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>宿舍管理页面</title>

    <style type="text/css">
        .table th, .table td {
            text-align: center;
            vertical-align:middle;
        }
    </style>

</head>
<body>
<div class="kk_dor_container">
    <!-- 导航栏-->
    <%@ include file="./commom/head.jsp"%>


    <!-- 中间部分（左侧栏+表格内容） -->
    <div class="kk_dor_body">
        <!-- 左侧栏 -->
        <%@ include file="./commom/leftsidebar.jsp"%>

        <!-- 宿舍表格内容 -->
        <div class="dor_info col-sm-10">
            <div class="panel panel-success">
                <!-- 路径导航 -->
                <div class="panel-heading">
                    <ol class="breadcrumb">
                        <li><a href="#">宿舍管理</a></li>
                        <li class="active">宿舍信息</li>
                    </ol>
                </div>
                <!-- Table -->
                <table class="table table-bordered table-hover" id="dor_table">
                    <thead>
                        <th>宿舍编号</th>
                        <th>宿舍名称</th>
                        <th>宿舍长</th>
                        <th>操作</th>
                    </thead>
                    <tbody>
                        <c:forEach items="${dormitorys}" var="dor">
                            <tr>
                                <td>${dor.dorId}</td>
                                <td>${dor.dorName}</td>
                                <td>${dor.dorMaster}</td>
                                <td>
                                    <a href="#" role="button" class="btn btn-primary dor_edit_btn" data-toggle="modal" data-target=".dor-update-modal">编辑</a>
                                    <a href="#" role="button" class="btn btn-danger dor_delete_btn">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="panel-body">
                    <div class="table_items">
                        当前第<span class="badge">${curPageNo}</span>页，共有<span class="badge">${totalPages}</span>页，总记录数<span class="badge">${totalItems}</span>条。
                    </div>
                    <nav aria-label="Page navigation" class="pull-right">
                        <ul class="pagination">
                            <li><a href="/kk/dor/getDorList?pageNo=1">首页</a></li>
                            <c:if test="${curPageNo==1}">
                                <li class="disabled">
                                    <a href="#" aria-label="Previous" class="prePage">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${curPageNo!=1}">
                                <li>
                                    <a href="#" aria-label="Previous" class="prePage">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages<5?totalPages:5}" step="1" var="itemPage">
                                <c:if test="${curPageNo == itemPage}">
                                    <li class="active"><a href="/kk/dor/getDorList?pageNo=${itemPage}">${itemPage}</a></li>
                                </c:if>
                                <c:if test="${curPageNo != itemPage}">
                                    <li><a href="/kk/dor/getDorList?pageNo=${itemPage}">${itemPage}</a></li>
                                </c:if>
                            </c:forEach>

                            <c:if test="${curPageNo==totalPages}">
                                <li class="disabled" class="nextPage">
                                    <a href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${curPageNo!=totalPages}">
                                <li>
                                    <a href="#" aria-label="Next" class="nextPage">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <li><a href="/kk/dor/getDorList?pageNo=${totalPages}">尾页</a></li>
                        </ul>
                    </nav>
                </div>
            </div><!-- /.panel panel-success -->
        </div><!-- /.dor_info -->
    </div><!-- /.kk_dor_body -->

    <%@ include file="dormitoryAdd.jsp"%>
    <%@ include file="dormitoryUpdate.jsp"%>

    <!-- 尾部-->
    <%@ include file="./commom/foot.jsp"%>

</div><!-- /.kk_dor_container -->

<script type="text/javascript">
    var curPageNo = ${curPageNo};
    var totalPages = ${totalPages};
    //上一页
    $(".prePage").click(function () {
         if (curPageNo > 1){
             var pageNo = curPageNo - 1;
             $(this).attr("href", "/kk/dor/getDorList?pageNo="+pageNo);
         }
    });
    //下一页
    $(".nextPage").click(function () {
        if (curPageNo < totalPages){
            var pageNo = curPageNo + 1;
            $(this).attr("href", "/kk/dor/getDorList?pageNo="+pageNo);
        }
    });


    <!-- ==========================宿舍删除操作=================================== -->
    $(".dor_delete_btn").click(function () {
        var delDorId = $(this).parent().parent().find("td:eq(0)").text();
        var delDorName = $(this).parent().parent().find("td:eq(1)").text();
        var curPageNo = ${curPageNo};
        if (confirm("确认删除【"+ delDorName +"】的信息吗？")){
            $.ajax({
                url:"/kk/dor/delDor/"+delDorId,
                type:"DELETE",
                success:function (result) {
                    if (result.code == 100){
                        alert("删除成功！");
                        window.location.href = "/kk/dor/getDorList?pageNo="+curPageNo;
                    }else {
                        alert(result.extendInfo.del_dor_error);
                    }
                }
            });
        }
    });
</script>
</body>
</html>
