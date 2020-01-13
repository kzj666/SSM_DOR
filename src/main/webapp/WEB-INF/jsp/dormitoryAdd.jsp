<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>宿舍新增页面</title>
</head>
<body>
<div class="modal fade dor-add-modal" tabindex="-1" role="dialog" aria-labelledby="dor-add-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">宿舍新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal add_dor_form">
                    <div class="form-group">
                        <label for="add_dorName" class="col-sm-2 control-label">宿舍编号</label>
                        <div class="col-sm-8">
                            <input type="text" name="dorId" class="form-control" id="add_dorId" placeholder="如:13-908">
                            <span id="helpBlock_add_inputDorId" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_dorName" class="col-sm-2 control-label">宿舍名称</label>
                        <div class="col-sm-8">
                            <input type="text" name="dorName" class="form-control" id="add_dorName" placeholder="如:南苑13栋908宿舍">
                            <span id="helpBlock_add_inputDorName" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_dorMaster" class="col-sm-2 control-label">宿舍老大</label>
                        <div class="col-sm-8">
                            <input type="text" name="dorMaster" class="form-control" id="add_dorMaster" placeholder="XXX">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary dor_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
    <!-- ==========================宿舍新增操作=================================== -->
    // 为简单操作，省去了输入名称的验证、错误信息提示等操作
    //1 点击宿舍新增按钮，弹出模态框；
    //2 输入新增宿舍信息，点击保存按钮，发送AJAX请求到后台进行保存；
    //3 保存成功跳转最后一页
    $(".dor_add_btn").click(function () {

        $('.dor-add-modal').modal({
            keyboard:true,
            backdrop:static
        });

    });




    $("#add_dorId").change(function () {
        var dorId = $("#add_dorId").val();
        $.ajax({
            url:"/kk/dor/checkDorIdExists",
            type:"GET",
            data:"dorId="+dorId,
            success:function (result) {
                if (result.code == 100){
                    $("#add_dorId").parent().parent().removeClass("has-error");
                    $("#add_dorId").parent().parent().addClass("has-success");
                    $("#helpBlock_add_inputDorId").text(" ");
                    $(".dor_save_btn").attr("btn_DorId_exists", "success");
                }else {
                    $("#add_dorId").parent().parent().removeClass("has-success");
                    $("#add_dorId").parent().parent().addClass("has-error");
                    $("#helpBlock_add_inputDorId").text(result.extendInfo.dorid_exit_error);
                    $(".dor_save_btn").attr("btn_DorId_exists", "error");
                }
            }
        });

    });






    // $("#add_dorName").change(function () {
    //     var dorName = $("#add_dorName").val();
    //     $.ajax({
    //         url:"/kk/dor/checkDorExists",
    //         type:"GET",
    //         data:"dorName="+dorName,
    //         success:function (result) {
    //             if (result.code == 100){
    //                 $("#add_dorName").parent().parent().removeClass("has-error");
    //                 $("#add_dorName").parent().parent().addClass("has-success");
    //                 $("#helpBlock_add_inputDorName").text("宿舍名可用！");
    //                 $(".dor_save_btn").attr("btn_Dorname_exists", "success");
    //             }else {
    //                 $("#add_dorName").parent().parent().removeClass("has-success");
    //                 $("#add_dorName").parent().parent().addClass("has-error");
    //                 $("#helpBlock_add_inputDorName").text(result.extendInfo.name_exit_error);
    //                 $(".dor_save_btn").attr("btn_Dorname_exists", "error");
    //             }
    //         }
    //     });
    //
    // });


    $(".dor_save_btn").click(function () {

        //dorId
        if($(".dor_save_btn").attr("btn_DorId_exists") == "error"){
            return false;
        }
        //dorName
        if($(".dor_save_btn").attr("btn_Dorname_exists") == "error"){
            return false;
        }

        var dorName = $("#add_dorName").val();
        var dorMaster = $("#add_dorMaster").val();
        //验证省略...
        $.ajax({
            url:"/kk/dor/addDor",
            type:"PUT",
            data:$(".add_dor_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("新增成功");
                    $('.dor-add-modal').modal("hide");
                    $.ajax({
                        url:"/kk/dor/getTotalPages",
                        type:"GET",
                        success:function (result) {
                            if (result.code == 100){
                                var totalPage = result.extendInfo.totalPages;
                                window.location.href="/kk/dor/getDorList?pageNo="+totalPage;
                            }
                        }
                    });
                }else {
                    alert(result.extendInfo.add_dor_error);
                }
            }
        });



    });



</script>
</body>
</html>
