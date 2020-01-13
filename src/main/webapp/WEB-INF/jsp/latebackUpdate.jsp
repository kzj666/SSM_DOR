<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>晚归信息页面</title>
</head>
<body>
<div class="modal fade lb-update-modal" tabindex="-1" role="dialog" aria-labelledby="lb-update-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">晚归信息更改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal update_lb_form">
                    <div class="form-group">
                        <label for="update_lbId" class="col-sm-2 control-label">晚归者学号</label>
                        <div class="col-sm-8">
                            <input type="text" name="lbId" class="form-control" id="update_lbId">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_lbName" class="col-sm-2 control-label">晚归者姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="lbName" class="form-control" id="update_lbName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_lbTime" class="col-sm-2 control-label">晚归时间</label>
                        <div class="col-sm-8">
                            <input type="text" name="lbTime" class="form-control" id="update_lbTime">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary lb_update_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    <!-- ==========================晚归信息新增操作=================================== -->
    //1 点击编辑按钮，发送AJAX请求查询对应id的晚归信息信息，进行回显；
    //2 进行修改，点击更新按钮发送AJAX请求，将更改后的信息保存到数据库中；
    //3 跳转到当前更改页；
    var edit_lbId = 0;
    var curPageNo = ${curPageNo};

    $(".lb_edit_btn").click(function () {
        edit_lbId = $(this).parent().parent().find("td:eq(1)").text();
        alert("id"+edit_lbId);
        //查询对应lbId的晚归信息信息
        $.ajax({
            url:"/kk/lb/getLbById/"+edit_lbId,
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    var lbData = result.extendInfo.lateback;
                    //回显
                    $("#update_lbId").val(lbData.lbId);
                    $("#update_lbName").val(lbData.lbName);
                    $("#update_lbTime").val(lbData.lbTime);
                }else {
                    alert(result.extendInfo.get_lb_error);
                }
            }
        });
    });

    $(".lb_update_btn").click(function () {
        $.ajax({
            url:"/kk/lb/updateLb/"+edit_lbId,
            type:"PUT",
            data:$(".update_lb_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("更新成功！");
                    window.location.href = "/kk/lb/getLbList?pageNo="+curPageNo;
                } else {
                    alert(result.extendInfo.update_lb_error);
                }
            }

        });
    });


</script>
</body>
</html>
