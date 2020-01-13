<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Update Page</title>
</head>
<body>
<div class="modal fade stu-update-modal" tabindex="-1" role="dialog" aria-labelledby="stu-update-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">学生更改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal update_stu_form">

                    <div class="form-group">
                        <label for="update_static_stuId" class="col-sm-2 control-label">学号</label>
                        <div class="col-sm-8">
                            <p class="form-control-static" id="update_static_stuId"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_stuName" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="stuName" class="form-control" id="update_stuName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_stuTel" class="col-sm-2 control-label">联系方式</label>
                        <div class="col-sm-8">
                            <input type="text" name="stuTel" class="form-control" id="update_stuTel">
                            <span id="helpBlock_update_inputTel" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="update_stuGender1" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="update_stuGender2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_dormitory" class="col-sm-2 control-label">宿舍</label>
                        <div class="col-sm-8">
                            <div class="checkbox">
                                <select class="form-control" name="sdorId" id="update_dormitory">
                                     <%--<option value="1" selected >CEO1</option>--%>
                                     <%--<option value="2" id="2" >CEO2</option>--%>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary stu_update_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




<script type="text/javascript">
    <!-- ==========================学生修改操作=================================== -->

    /*
        点击编辑按钮，触发函数，拿到该编辑按钮的学生id，然后通过Ajax请求查询后台，将该学号的学生信息全部拿到并回调传到前端result中
    */


    $(".stu_edit_btn").click(function () {
        //1 获取点击修改学生的id;
        var updateStuId = $(this).parent().parent().find("td:eq(0)").text();

        //2 根据id或name查询出对应学生信息进行回显；
        $.ajax({
            url:"/kk/stu/getStuById/"+updateStuId,
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    var stu = result.extendInfo.student;
                    $("#update_static_stuId").text(stu.stuId);
                    $("#update_stuName").val(stu.stuName);
                    $("#update_stuTel").val(stu.stuTel);
                    $(".stu-update-modal input[name=gender]").val([stu.gender]);
                    $("#update_dormitory").val(stu.sdorId);
                }
            }
        });

        //2 宿舍回显列表；
        $.ajax({
            url:"/kk/dor/getDorName",
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    $.each(result.extendInfo.dormitoryList, function () {
                        //获取<option>标签，将dorName元素放入<option>标签中，<option>this.dorName</option>，并且设置value属性是宿舍id：dorId
                        var optEle = $("<option></option>").append(this.dorName).attr({"value":this.dorId});//所以显示的是宿舍名，后端数据是宿舍的id
                        //将<option>标签加入id为"update_dormitory"的select标签中
                        optEle.appendTo("#update_dormitory");
                    });
                }
            }
        });

        //将当前的学生学号放入id为stu_update_btn的标签的updateStuId属性中，供下面的验证使用
        $(".stu_update_btn").attr("updateStuId", updateStuId);
    });

    //当输入联系方式框失去焦点后。检测号码格式
    $("#update_stuTel").change(function () {
        //设置手机格式的正则表达式
        var regTel = /^[1][3,4,5,7,8][0-9]{9}$/;
        //4 进行修改，对修改的手机格式进行判断；
        var updateStuTel = $("#update_stuTel").val();

        if (!regTel.test(updateStuTel)){
            $("#update_stuTel").parent().parent().removeClass("has-sucess");
            $("#update_stuTel").parent().parent().addClass("has-error");
            $("#helpBlock_update_inputTel").text("手机格式不正确！");
            $(".stu_update_btn").attr("btn_tel_text", "error");
            return false;
        }else {
            $("#update_stuTel").parent().parent().removeClass("has-error");
            $("#update_stuTel").parent().parent().addClass("has-success");
            $("#helpBlock_update_inputTel").text("");
            $(".stu_update_btn").attr("btn_tel_text", "success");
        }
    });


    $(".stu_update_btn").click(function () {

        //拿到当前更新的学生的id
        var updateStuId = $(this).attr("updateStuId");

        if($(".stu_update_btn").attr("btn_tel_text") == "error"){
            return false;
        }

        //5 点击更新按钮，发送AJAX请求到后台进行保存。
        $.ajax({
            url:"/kk/stu/updateStu/"+updateStuId,
            type:"PUT",
            data:$(".update_stu_form").serialize(),
            success:function (result) {
                if (result.code==100){
                    alert("学生更改成功！");
                    $(".stu-update-modal").modal("hide");
                    //跳转到当前页
                    var curPage = ${curPage};
                    window.location.href="/kk/stu/getStuList?pageNo="+curPage;
                }else {
                    alert(result.extendInfo.stu_update_error);
                }
            }
        });
    });

</script>
</body>
</html>
