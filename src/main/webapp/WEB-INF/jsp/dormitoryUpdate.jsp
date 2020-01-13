<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>宿舍更改页面</title>
</head>
<body>
<div class="modal fade dor-update-modal" tabindex="-1" role="dialog" aria-labelledby="dor-update-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">宿舍更改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal update_dor_form">
                    <div class="form-group">
                        <label for="update_dorName" class="col-sm-2 control-label">宿舍名称</label>
                        <div class="col-sm-8">
                            <input type="text" name="dorName" class="form-control" id="update_dorName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_dorMaster" class="col-sm-2 control-label">宿舍长</label>
                        <div class="col-sm-8">
                            <input type="text" name="dorMaster" class="form-control" id="update_dorMaster">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary dor_update_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    <!-- ==========================宿舍新增操作=================================== -->
    //1 点击编辑按钮，发送AJAX请求查询对应id的宿舍信息，进行回显；
    //2 进行修改，点击更新按钮发送AJAX请求，将更改后的信息保存到数据库中；
    //3 跳转到当前更改页；
    var edit_dorId = 0;
    var curPageNo = ${curPageNo};

    $(".dor_edit_btn").click(function () {
        edit_dorId = $(this).parent().parent().find("td:eq(0)").text();
        alert("id"+edit_dorId);
        //查询对应dorId的宿舍信息
        $.ajax({
            url:"/kk/dor/getDorById/"+edit_dorId,
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    var dorData = result.extendInfo.dormitory;
                    //回显
                    $("#update_dorName").val(dorData.dorName);
                    $("#update_dorMaster").val(dorData.dorMaster);
                }else {
                    alert(result.extendInfo.get_dor_error);
                }
            }
        });
    });

    $(".dor_update_btn").click(function () {
        $.ajax({
            url:"/kk/dor/updateDor/"+edit_dorId,
            type:"PUT",
            data:$(".update_dor_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("更新成功！");
                    window.location.href = "/kk/dor/getDorList?pageNo="+curPageNo;
                } else {
                    alert(result.extendInfo.update_dor_error);
                }
            }

        });
    });


</script>
</body>
</html>
