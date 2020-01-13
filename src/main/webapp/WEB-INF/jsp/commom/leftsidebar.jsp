<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="panel-group col-sm-2" id="hrms_sidebar_left" role="tablist" aria-multiselectable="true">

    <ul class="nav nav-pills nav-stacked dor_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_dor">
                <span class="glyphicon glyphicon-cloud" aria-hidden="true">宿舍管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dor">
                <li role="presentation"><a href="#" class="dor_info">宿舍信息</a></li>
                <li role="presentation"><a href="#" class="dor_add_btn" data-toggle="modal" data-target=".dor-add-modal">宿舍新增</a></li>
                <li role="presentation"><a href="#" class="dor_clearall_btn">宿舍清零</a></li>
            </ul>
        </li>
    </ul>

    <ul class="nav nav-pills nav-stacked stu_sidebar">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_stu">
                <span class="glyphicon glyphicon-user" aria-hidden="true">学生管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_stu">
                <li role="presentation"><a href="#" class="stu_info">学生信息</a></li>
                <li role="presentation"><a href="#" role="button" class="stu_add_btn" data-toggle="modal" data-target=".stu-add-modal">学生新增</a></li>
                <li role="presentation"><a href="#" class="stu_clearall_btn">学生清零</a></li>
            </ul>
        </li>
    </ul>

    <ul class="nav nav-pills nav-stacked lb_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_lb">
                <span class="glyphicon glyphicon-cloud" aria-hidden="true">晚归情况</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_lb">
                <li role="presentation"><a href="#" class="lb_info">晚归名单</a></li>
                <li role="presentation"><a href="#" class="lb_add_btn" data-toggle="modal" data-target=".lb-add-modal">登记晚归</a></li>
            </ul>
        </li>
    </ul>

    <ul class="nav nav-pills nav-stacked vtr_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_vtr">
                <span class="glyphicon glyphicon-cloud" aria-hidden="true">来访登记</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_vtr">
                <li role="presentation"><a href="#" class="vtr_info">来访记录表</a></li>
                <li role="presentation"><a href="#" class="vtr_add_btn" data-toggle="modal" data-target=".vtr-add-modal">来访登记</a></li>
            </ul>
        </li>
    </ul>

    <ul class="nav nav-pills nav-stacked stay_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_stay">
                <span class="glyphicon glyphicon-cloud" aria-hidden="true">留宿情况</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_stay">
                <li role="presentation"><a href="#" class="stay_info">留宿名单</a></li>
                <li role="presentation"><a href="#" class="stay_add_btn" data-toggle="modal" data-target=".stay-add-modal">添加留宿人员</a></li>
            </ul>
        </li>
    </ul>


</div>

<script type="text/javascript">
    //跳转到学生页面
    $(".stu_info").click(function () {
        $(this).attr("href", "/kk/stu/getStuList");
    });
    //跳转到宿舍页面
    $(".dor_info").click(function () {
        $(this).attr("href", "/kk/dor/getDorList");
    });
    //跳转到晚归页面
    $(".lb_info").click(function () {
        $(this).attr("href", "/kk/lb/getLbList");
    });
    //跳转到来访登记页面
    $(".vtr_info").click(function () {
        $(this).attr("href", "/kk/vtr/getVtrList");
    });






    //学生清零这个功能暂未实现
    $(".stu_clearall_btn").click(function () {
        alert("你想干嘛？？？我劝你善良！！！");
    });
    //宿舍清零这个功能暂未实现
    $(".dor_clearall_btn").click(function () {
        alert("你想干嘛？？？我劝你善良！！！");
    });
</script>
</body>
</html>
