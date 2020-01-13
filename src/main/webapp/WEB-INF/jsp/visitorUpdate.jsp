<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>来访更改页面</title>
</head>
<body>
<div class="modal fade vtr-update-modal" tabindex="-1" role="dialog" aria-labelledby="vtr-update-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">来访更改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal update_vtr_form">
                    <div class="form-group">
                        <label for="update_vtrId" class="col-sm-2 control-label">身份证</label>
                        <div class="col-sm-8">
                            <input type="text" name="vtrId" class="form-control" id="update_vtrId">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_vtrName" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="vtrName" class="form-control" id="update_vtrName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_vtrTime" class="col-sm-2 control-label">来访时间</label>
                        <div class="col-sm-8">
                            <input type="text" name="vtrTime" class="form-control" id="update_vtrTime">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_vtrReason" class="col-sm-2 control-label">来访原因</label>
                        <div class="col-sm-8">
                            <input type="text" name="vtrReason" class="form-control" id="update_vtrReason">
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary vtr_update_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    <!-- ==========================来访新增操作=================================== -->
    //1 点击编辑按钮，发送AJAX请求查询对应id的来访信息，进行回显；
    //2 进行修改，点击更新按钮发送AJAX请求，将更改后的信息保存到数据库中；
    //3 跳转到当前更改页；
    var edit_vtrId = 0;
    var curPageNo = ${curPageNo};

    $(".vtr_edit_btn").click(function () {
        edit_vtrId = $(this).parent().parent().find("td:eq(0)").text();
        alert("id=="+edit_vtrId);
        //查询对应vtrId的来访信息
        $.ajax({
            url:"/kk/vtr/getVtrById/"+edit_vtrId,
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    var vtrData = result.extendInfo.visitor;
                    //回显
                    $("#update_vtrId").val(vtrData.vtrId);
                    $("#update_vtrName").val(vtrData.vtrName);
                    $("#update_vtrTime").val(vtrData.vtrTime);
                    $("#update_vtrReason").val(vtrData.vtrReason);
                }else {
                    alert(result.extendInfo.get_vtr_error);
                }
            }
        });
    });

    $(".vtr_update_btn").click(function () {
        $.ajax({
            url:"/kk/vtr/updateVtr/"+edit_vtrId,
            type:"PUT",
            data:$(".update_vtr_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("更新成功！");
                    window.location.href = "/kk/vtr/getVtrList?pageNo="+curPageNo;
                } else {
                    alert(result.extendInfo.update_vtr_error);
                }
            }

        });
    });


</script>
</body>
</html>
