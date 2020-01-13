<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Add Page</title>
</head>
<body>
<div class="modal fade stu-add-modal" tabindex="-1" role="dialog" aria-labelledby="stu-add-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">学生新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal add_stu_form">
                    <div class="form-group">
                        <label for="add_inputName" class="col-sm-2 control-label">学号</label>
                        <div class="col-sm-8">
                            <input type="text" name="stuId" class="form-control" id="add_inputId" placeholder="学籍号">
                            <span id="helpBlock_add_inputId" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_inputName" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="stuName" class="form-control" id="add_inputName" placeholder="如：张三">
                            <span id="helpBlock_add_inputName" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_inputTel" class="col-sm-2 control-label">联系方式</label>
                        <div class="col-sm-8">
                            <input type="text" name="stuTel" class="form-control" id="add_inputTel" placeholder="11位手机号码">
                            <span id="helpBlock_add_inputTel" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" checked="checked" name="gender" id="add_inputGender1" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="add_inputGender2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_dormitory" class="col-sm-2 control-label">宿舍</label>
                        <div class="col-sm-8">
                            <div class="checkbox">
                                <select class="form-control" name="sdorId" id="add_dormitory">
                                   <%-- <option value="1">CEO</option>--%>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary stu_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">

    <!-------------------------------------学生新增操作-------------------------------------->
    //=======0 点击 学生新增按钮，发送AJAX请求查询宿舍列表信息，弹出模态框，
    // 将查询得到的宿舍列表信息显示在对应模态框中宿舍信息处。=============================
    $(".stu_add_btn").click(function () {
        $.ajax({
            url:"/kk/dor/getDorName",
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    $.each(result.extendInfo.dormitoryList, function () {
                        var optionEle = $("<option></option>").append(this.dorName).attr("value", this.dorId);
                        optionEle.appendTo("#add_dormitory");
                    });
                }
            }
        });

        $('.stu-add-modal').modal({
            backdrop:static,
            keyboard:true
        });
    });

    //=========1 当鼠标从姓名输入框移开的时候，判断姓名输入框内的姓名是否符合格式 ============
    $("#add_inputName").change(function () {
        var stuName = $("#add_inputName").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(stuName)){
            $("#add_inputName").parent().parent().removeClass("has-sucess");
            $("#add_inputName").parent().parent().addClass("has-error");
            $("#helpBlock_add_inputName").text("姓名格式不正确！需为2-5位中文或6-16位英文和数字组合");
            $(".stu_save_btn").attr("btn_name_format", "error");
            return false;
        }else {
            $("#add_inputName").parent().parent().removeClass("has-error");
            $("#add_inputName").parent().parent().addClass("has-success");
            $("#helpBlock_add_inputName").text("");
            $(".stu_save_btn").attr("btn_name_format", "success");
        }

    });


    //=========1 当鼠标从学号输入框移开的时候，判断学号输入框内的学号是否重复 ============
    $("#add_inputId").change(function () {
        var stuId = $("#add_inputId").val();
        $.ajax({
            url:"/kk/stu/checkStuIdExists",
            type:"GET",
            data:"stuId="+stuId,
            success:function (result) {
                if (result.code == 100){
                    $("#add_inputId").parent().parent().removeClass("has-error");
                    $("#add_inputId").parent().parent().addClass("has-success");
                    $("#helpBlock_add_inputId").text("学号可用");
                    $(".stu_save_btn").attr("btn_stuid_exists", "success");
                }else {
                    $("#add_inputId").parent().parent().removeClass("has-success");
                    $("#add_inputId").parent().parent().addClass("has-error");
                    $("#helpBlock_add_inputId").text(result.extendInfo.stuid_exist);
                    $(".stu_save_btn").attr("btn_stuid_exists", "error");
                }
            }
        });

    });




    //当鼠标从联系方式输入框移开的时候验证11位手机号
    $("#add_inputTel").change(function () {
        var inputstuTel = $("#add_inputTel").val();
        var regTel = /^[1][3,4,5,7,8][0-9]{9}$/;
        if (!regTel.test(inputstuTel)){
            $("#add_inputTel").parent().parent().removeClass("has-sucess");
            $("#add_inputTel").parent().parent().addClass("has-error");
            $("#helpBlock_add_inputTel").text("手机格式不正确！");
            $(".stu_save_btn").attr("btn_tel_test", "error");
            return false;
        }else {
            $("#add_inputTel").parent().parent().removeClass("has-error");
            $("#add_inputTel").parent().parent().addClass("has-success");
            $("#helpBlock_add_inputTel").text("");
            $(".stu_save_btn").attr("btn_tel_test", "success");
        }

    });


    //3 保存

    $(".stu_save_btn").click(function () {

        //1 获取到第3步：$(".stu_save_btn").attr("btn_name_exists", "success");中btn_name_exists的值
        // btn_name_exists = error，就是姓名重复
        if($(".stu_save_btn").attr("btn_name_format") == "error"){
            return false;
        }
        //学号
        if($(".stu_save_btn").attr("btn_stuid_exists") == "error"){
            return false;
        }
        //手机号码
        if($(".stu_save_btn").attr("btn_tel_test") == "error"){
            return false;
        }

        // //================2 对输入的姓名和手机格式进行验证===============
        // // var inputId = $("#add_inputId").val();
        // var inputName = $("#add_inputName").val();
        // //验证格式。姓名：2-5位中文或6-16位英文和数字组合；
        // var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        //
        //
        // if (!regName.test(inputName)){
        //     alert("测试：输入姓名格式不正确！");
        //     //输入框变红
        //     $("#add_inputName").parent().parent().addClass("has-error");
        //     //输入框下面显示红色提示信息
        //     $("#helpBlock_add_inputName").text("输入姓名为2-5位中文或6-16位英文和数字组合");
        //     return false;
        // } else {
        //     //移除格式
        //     $("#add_inputName").parent().parent().removeClass("has-error");
        //     $("#add_inputName").parent().parent().addClass("has-success");
        //     $("#helpBlock_add_inputName").hide();
        //
        //     $("#add_inputId").parent().parent().removeClass("has-error");
        //     $("#add_inputId").parent().parent().addClass("has-success");
        //     $("#helpBlock_add_inputId").hide();
        // }



        // //手机验证
        // var inputTel = $("#add_inputTel").val();
        // var regTel = /^[1][3,4,5,7,8][0-9]{9}$/;
        // if (!regTel.test(inputTel)){
        //     //输入框变红
        //     $("#add_inputTel").parent().parent().addClass("has-error");
        //     //输入框下面显示红色提示信息
        //     $("#helpBlock_add_inputTel").text("手机号码格式不正确！");
        //     return false;
        // }else {
        //     //移除格式
        //     $("#add_inputTel").parent().parent().removeClass("has-error");
        //     $("#add_inputTel").parent().parent().addClass("has-success");
        //     $("#helpBlock_add_inputTel").hide();
        // }



        $.ajax({
            url:"/kk/stu/addStu",
            type:"POST",
            data:$(".add_stu_form").serialize(),
            success:function (result) {
                if (result.code == 100){
                    alert("学生新增成功");
                    $('#stu-add-modal').modal("hide");
                    //跳往最后一页，由于新增记录，所以要重新查询总页数
                    $.ajax({
                        url:"/kk/stu/getTotalPages",
                        type:"GET",
                        success:function (result) {
                            var totalPage = result.extendInfo.totalPages;
                            window.location.href="/kk/stu/getStuList?pageNo="+totalPage;
                        }
                    })
                } else {
                    alert("学生新增失败！");
                }
            }

        });





    });



</script>
</body>
</html>
