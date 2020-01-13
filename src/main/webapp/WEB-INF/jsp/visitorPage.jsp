<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>来访管理页面</title>

    <style type="text/css">
        .table th, .table td {
            text-align: center;
            vertical-align:middle;
        }
    </style>

</head>
<body>
<div class="kk_vtr_container">
    <!-- 导航栏-->
    <%@ include file="./commom/head.jsp"%>


    <!-- 中间部分（左侧栏+表格内容） -->
    <div class="kk_vtr_body">
        <!-- 左侧栏 -->
        <%@ include file="./commom/leftsidebar.jsp"%>

        <!-- 来访表格内容 -->
        <div class="vtr_info col-sm-10">
            <div class="panel panel-success">
                <!-- 路径导航 -->
                <div class="panel-heading">
                    <ol class="breadcrumb">
                        <li><a href="#">来访管理</a></li>
                        <li class="active">来访信息</li>
                    </ol>
                </div>
                <!-- Table -->
                <table class="table table-bordered table-hover" id="vtr_table">
                    <thead>
                        <th>来访者身份证</th>
                        <th>姓名</th>
                        <th>来访时间</th>
                        <th>来访原因</th>
                        <th>操作</th>
                    </thead>
                    <tbody>
                        <c:forEach items="${visitors}" var="vtr">
                            <tr>
                                <td>${vtr.vtrId}</td>
                                <td>${vtr.vtrName}</td>
                                <td>${vtr.vtrTime}</td>
                                <td>${vtr.vtrReason}</td>
                                <td>
                                    <a href="#" role="button" class="btn btn-primary vtr_edit_btn" data-toggle="modal" data-target=".vtr-update-modal">编辑</a>
                                    <a href="#" role="button" class="btn btn-danger vtr_delete_btn">删除</a>
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
                            <li><a href="/kk/vtr/getVtrList?pageNo=1">首页</a></li>
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
                                    <li class="active"><a href="/kk/vtr/getVtrList?pageNo=${itemPage}">${itemPage}</a></li>
                                </c:if>
                                <c:if test="${curPageNo != itemPage}">
                                    <li><a href="/kk/vtr/getVtrList?pageNo=${itemPage}">${itemPage}</a></li>
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
                            <li><a href="/kk/vtr/getVtrList?pageNo=${totalPages}">尾页</a></li>
                        </ul>
                    </nav>
                </div>
            </div><!-- /.panel panel-success -->
        </div><!-- /.vtr_info -->
    </div><!-- /.kk_vtr_body -->

    <%@ include file="visitorAdd.jsp"%>
    <%@ include file="visitorUpdate.jsp"%>

    <!-- 尾部-->
    <%@ include file="./commom/foot.jsp"%>

</div><!-- /.kk_vtr_container -->

<script type="text/javascript">
    var curPageNo = ${curPageNo};
    var totalPages = ${totalPages};
    //上一页
    $(".prePage").click(function () {
         if (curPageNo > 1){
             var pageNo = curPageNo - 1;
             $(this).attr("href", "/kk/vtr/getVtrList?pageNo="+pageNo);
         }
    });
    //下一页
    $(".nextPage").click(function () {
        if (curPageNo < totalPages){
            var pageNo = curPageNo + 1;
            $(this).attr("href", "/kk/vtr/getVtrList?pageNo="+pageNo);
        }
    });


    <!-- ==========================来访删除操作=================================== -->
    $(".vtr_delete_btn").click(function () {
        var delVtrId = $(this).parent().parent().find("td:eq(0)").text();
        var delVtrName = $(this).parent().parent().find("td:eq(1)").text();
        var delVtrTime = $(this).parent().parent().find("td:eq(2)").text();
        var curPageNo = ${curPageNo};
        if (confirm("确认删除【"+ delVtrName +"】在["+delVtrTime+"]的来访信息吗？")){
            $.ajax({
                url:"/kk/vtr/delVtr/"+delVtrId,
                type:"DELETE",
                success:function (result) {
                    if (result.code == 100){
                        alert("删除成功！");
                        window.location.href = "/kk/vtr/getVtrList?pageNo="+curPageNo;
                    }else {
                        alert(result.extendInfo.del_vtr_error);
                    }
                }
            });
        }
    });
</script>
</body>
</html>
