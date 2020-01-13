<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>晚归登记页面</title>
</head>
<body>
<div class="modal fade lb-add-modal" tabindex="-1" role="dialog" aria-labelledby="lb-add-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">晚归登记</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal add_lb_form">
                    <div class="form-group">
                        <label for="add_lbId" class="col-sm-2 control-label">晚归学号</label>
                        <div class="col-sm-8">
                            <input type="text" name="lbId" class="form-control" id="add_lbId" placeholder="如:171549419">
                            <span id="helpBlock_add_inputLbId" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_lbName" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="lbName" class="form-control" id="add_lbName" placeholder="姓名">
                            <span id="helpBlock_add_inputLbName" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_lbTime" class="col-sm-2 control-label">晚归时间</label>
                        <div class="col-sm-8">
                            <input type="text" name="lbTime" class="form-control" id="add_lbTime" value="" placeholder="XXX">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary lb_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
    <!-- ==========================晚归新增操作=================================== -->
    // 为简单操作，省去了输入名称的验证、错误信息提示等操作
    //1 点击晚归新增按钮，弹出模态框；
    //2 输入新增晚归信息，点击保存按钮，发送AJAX请求到后台进行保存；
    //3 保存成功跳转最后一页
    $(".lb_add_btn").click(function () {
        $('.lb-add-modal').modal({
            keyboard:true,
            backdrop:static
        });

    });




    $("#add_lbId").change(function () {
        var lbId = $("#add_lbId").val();
        var regId = /^[0-9a-zA-Z]+$/;
        if(!regId.test(lbId)){
            $("#add_lbId").parent().parent().removeClass("has-sucess");
            $("#add_lbId").parent().parent().addClass("has-error");
            $("#helpBlock_add_inputLbId").text("学号需为数字或数字与字母的组合");
            $(".lb_save_btn").attr("btn_LbId_exists", "error");
        }else {
            $("#add_lbId").parent().parent().removeClass("has-error");
            $("#add_lbId").parent().parent().addClass("has-success");
            $("#helpBlock_add_inputLbId").text("");
            $(".lb_save_btn").attr("btn_LbId_exists", "success");
        }
    });



    $("#add_lbName").change(function () {
        var lbName = $("#add_lbName").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(lbName)){
            $("#add_lbName").parent().parent().removeClass("has-sucess");
            $("#add_lbName").parent().parent().addClass("has-error");
            $("#helpBlock_add_inputLbName").text("姓名格式不正确！需为2-5位中文或6-16位英文和数字组合");
            $(".lb_save_btn").attr("btn_Lbname_exists", "error");
            return false;
        }else {
            $("#add_lbName").parent().parent().removeClass("has-error");
            $("#add_lbName").parent().parent().addClass("has-success");
            $("#helpBlock_add_inputLbName").text("");
            $(".lb_save_btn").attr("btn_Lbname_exists", "success");
        }

    });




    // $("#add_lbName").change(function () {
    //     var lbName = $("#add_lbName").val();
    //     $.ajax({
    //         url:"/kk/lb/checkLbExists",
    //         type:"GET",
    //         data:"lbName="+lbName,
    //         success:function (result) {
    //             if (result.code == 100){
    //                 $("#add_lbName").parent().parent().removeClass("has-error");
    //                 $("#add_lbName").parent().parent().addClass("has-success");
    //                 $("#helpBlock_add_inputLbName").text("姓名名可用！");
    //                 $(".lb_save_btn").attr("btn_Lbname_exists", "success");
    //             }else {
    //                 $("#add_lbName").parent().parent().removeClass("has-success");
    //                 $("#add_lbName").parent().parent().addClass("has-error");
    //                 $("#helpBlock_add_inputLbName").text(result.extendInfo.name_exit_error);
    //                 $(".lb_save_btn").attr("btn_Lbname_exists", "error");
    //             }
    //         }
    //     });
    //
    // });


    $(".lb_save_btn").click(function () {

        //lbId
        if($(".lb_save_btn").attr("btn_LbId_exists") == "error"){
            return false;
        }
        //lbName
        if($(".lb_save_btn").attr("btn_Lbname_exists") == "error"){
            return false;
        }

        var lbName = $("#add_lbName").val();
        var lbTime = $("#add_lbTime").val();
        //验证省略...
        $.ajax({
            url:"/kk/lb/addLb",
            type:"PUT",
            data:$(".add_lb_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("新增成功");
                    $('.lb-add-modal').modal("hide");
                    $.ajax({
                        url:"/kk/lb/getTotalPages",
                        type:"GET",
                        success:function (result) {
                            if (result.code == 100){
                                var totalPage = result.extendInfo.totalPages;
                                window.location.href="/kk/lb/getLbList?pageNo="+totalPage;
                            }
                        }
                    });
                }else {
                    alert(result.extendInfo.add_lb_error);
                }
            }
        });



    });



</script>
</body>
</html>
