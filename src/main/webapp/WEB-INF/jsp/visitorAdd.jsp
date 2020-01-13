<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>来访新增页面</title>
</head>
<body>
<div class="modal fade vtr-add-modal" tabindex="-1" role="dialog" aria-labelledby="vtr-add-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">来访新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal add_vtr_form">
                    <div class="form-group">
                        <label for="add_vtrName" class="col-sm-2 control-label">身份证</label>
                        <div class="col-sm-8">
                            <input type="text" name="vtrId" class="form-control" id="add_vtrId" placeholder="18位身份证号码">
                            <span id="helpBlock_add_inputVtrId" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_vtrName" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="vtrName" class="form-control" id="add_vtrName" placeholder="姓名">
                            <span id="helpBlock_add_inputVtrName" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_vtrTime" class="col-sm-2 control-label">来访时间</label>
                        <div class="col-sm-8">
                            <input type="text" name="vtrTime" class="form-control" id="add_vtrTime" placeholder="来访时间">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_vtrReason" class="col-sm-2 control-label">来访原因</label>
                        <div class="col-sm-8">
                            <input type="text" name="vtrReason" class="form-control" id="add_vtrReason" placeholder="来访原因">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary vtr_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
    <!-- ==========================来访新增操作=================================== -->
    // 为简单操作，省去了输入名称的验证、错误信息提示等操作
    //1 点击来访新增按钮，弹出模态框；
    //2 输入新增来访信息，点击保存按钮，发送AJAX请求到后台进行保存；
    //3 保存成功跳转最后一页
    $(".vtr_add_btn").click(function () {

        $('.vtr-add-modal').modal({
            keyboard:true,
            backdrop:static
        });
    });



    //验证身份证格式
    $("#add_vtrId").change(function () {
        var vtrId = $("#add_vtrId").val();
        var regId = /^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
        if (!regId.test(vtrId)){
            $("#add_vtrId").parent().parent().removeClass("has-sucess");
            $("#add_vtrId").parent().parent().addClass("has-error");
            $("#helpBlock_add_inputVtrId").text("身份证格式不正确");
            $(".vtr_save_btn").attr("btn_VtrId_format", "error");
            return false;
        }else {
            $("#add_vtrId").parent().parent().removeClass("has-error");
            $("#add_vtrId").parent().parent().addClass("has-success");
            $("#helpBlock_add_inputVtrId").text("");
            $(".vtr_save_btn").attr("btn_VtrId_format", "success");
        }
    });

    //=========1 当鼠标从姓名输入框移开的时候，判断姓名输入框内的姓名是否符合格式 ============
    $("#add_vtrName").change(function () {
        var vtrName = $("#add_vtrName").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(vtrName)){
            $("#add_vtrName").parent().parent().removeClass("has-sucess");
            $("#add_vtrName").parent().parent().addClass("has-error");
            $("#helpBlock_add_inputVtrName").text("姓名格式不正确！需为2-5位中文或6-16位英文和数字组合");
            $(".vtr_save_btn").attr("btn_Vtrname_format", "error");
            return false;
        }else {
            $("#add_vtrName").parent().parent().removeClass("has-error");
            $("#add_vtrName").parent().parent().addClass("has-success");
            $("#helpBlock_add_inputVtrName").text("");
            $(".vtr_save_btn").attr("btn_Vtrname_format", "success");
        }

    });



    $(".vtr_save_btn").click(function () {

        //vtrId
        if($(".vtr_save_btn").attr("btn_VtrId_format") == "error"){
            return false;
        }
        //vtrName
        if($(".vtr_save_btn").attr("btn_Vtrname_format") == "error"){
            return false;
        }

        var vtrName = $("#add_vtrName").val();
        var vtrTime = $("#add_vtrTime").val();
        //验证省略...
        $.ajax({
            url:"/kk/vtr/addVtr",
            type:"PUT",
            data:$(".add_vtr_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("新增成功");
                    $('.vtr-add-modal').modal("hide");
                    $.ajax({
                        url:"/kk/vtr/getTotalPages",
                        type:"GET",
                        success:function (result) {
                            if (result.code == 100){
                                var totalPage = result.extendInfo.totalPages;
                                window.location.href="/kk/vtr/getVtrList?pageNo="+totalPage;
                            }
                        }
                    });
                }else {
                    alert(result.extendInfo.add_vtr_error);
                }
            }
        });



    });



</script>
</body>
</html>
