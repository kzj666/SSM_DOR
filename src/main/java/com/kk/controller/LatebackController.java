package com.kk.controller;

import com.kk.bean.Lateback;
import com.kk.service.LatebackService;
import com.kk.service.LatebackService;
import com.kk.util.JsonMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping(value = "/kk/lb")
public class LatebackController {

    @Autowired
    LatebackService latebackService;

    /**
     * 删除
     * @param lbNum
     * @return
     */
    @RequestMapping(value = "/delLb/{lbNum}", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonMsg deleteLb(@PathVariable("lbNum") String lbNum){
        int res = 0;
        if (lbNum != null){
            res = latebackService.deleteLbById(lbNum);
        }
        if (res != 1){
            return JsonMsg.fail().addInfo("del_lb_error", "删除异常");
        }
        return JsonMsg.success();
    }

    /**
     * 晚归更改
     * @param lbId
     * @param lateback
     * @return
     */
    @RequestMapping(value = "/updateLb/{lbId}", method = RequestMethod.PUT)
    @ResponseBody
    public JsonMsg updateLbById(@PathVariable("lbId") String lbId, Lateback lateback){

        int res = 0;
        if (lbId != null){
            res = latebackService.updateLbById(lbId, lateback);
        }
        if (res != 1){
            return JsonMsg.fail().addInfo("update_lb_error", "晚归更新失败");
        }
        return JsonMsg.success();
    }

    /**
     * 新增晚归
     * @param lateback
     * @return
     */
    @RequestMapping(value = "/addLb", method = RequestMethod.PUT)
    @ResponseBody
    public JsonMsg addLb(Lateback lateback){
//        System.out.println("6666666666666666666666666666666666"+lateback);
        int res = latebackService.addLb(lateback);
//        System.out.println("55555555555555555555555555555555555"+res);
        if (res != 1){
            return JsonMsg.fail().addInfo("add_lb_error", "添加异常！");
        }
        return JsonMsg.success();
    }

    /**
     * 查询晚归信息总页码数
     * @return
     */
    @RequestMapping(value = "/getTotalPages", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getTotalPages(){

        //每页显示的记录行数
        int limit = 5;
        //总记录数
        int totalItems = latebackService.getLbCount();
        int temp = totalItems / limit;
        int totalPages = (totalItems % limit== 0) ? temp : temp+1;

        return JsonMsg.success().addInfo("totalPages", totalPages);
    }

    /**
     *
     */

    @RequestMapping(value = "/getLbById/{lbId}", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getLbById(@PathVariable("lbId") String lbId){
        Lateback lateback = null;
        System.out.println("////////////////"+lbId);
        if (lbId != null){
            lateback = latebackService.getLbById(lbId);
            System.out.println("lateback"+lateback);
        }
        if (lateback != null){
            return JsonMsg.success().addInfo("lateback", lateback);
        }
        return JsonMsg.fail().addInfo("get_lb_error", "无晚归信息");
    }

    /**
     * 分页查询：返回指定页数对应的数据
     * @param pageNo
     * @return
     */
    @RequestMapping(value = "/getLbList", method = RequestMethod.GET)
    public ModelAndView getLbList(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo){
        ModelAndView mv = new ModelAndView("latebackPage");
        //每页显示的记录行数
        int limit = 5;
        //总记录数
        int totalItems = latebackService.getLbCount();
        int temp = totalItems / limit;
        int totalPages = (totalItems % limit== 0) ? temp : temp+1;
        //每页的起始行(offset+1)数据，如第一页(offset=0，从第1(offset+1)行数据开始)
        int offset = (pageNo - 1)*limit;
        List<Lateback> latebacks = latebackService.getLbList(offset, limit);

        mv.addObject("latebacks", latebacks)
                .addObject("totalItems", totalItems)
                .addObject("totalPages", totalPages)
                .addObject("curPageNo", pageNo);
        return mv;
    }

    /**
     * 查询所有晚归名称
     * @return
     */
    @RequestMapping(value = "/getLbName", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getLbName(){
        List<Lateback> latebackList = latebackService.getLbName();

        /*==============================================*/
//        System.out.println(latebackList);
        /*==============================================*/


        if (latebackList != null){
            return JsonMsg.success().addInfo("latebackList", latebackList);
        }
        return JsonMsg.fail();
    }


    @RequestMapping(value = "/checkLbExists", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg checkLbExists(@RequestParam("lbName") String lbName){
        Lateback lateback = latebackService.getLbByName(lbName);
        if (lateback != null){
            return JsonMsg.fail().addInfo("name_exit_error", "晚归名已存在");
        }else {
            return JsonMsg.success();
        }
    }

    @RequestMapping(value = "/checkLbIdExists", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg checkLbIdExists(@RequestParam("lbId") String lbId){
        int count = latebackService.selectIdExist(lbId);
        if (count > 0){
            return JsonMsg.fail().addInfo("lbid_exit_error", "该晚归已存在");
        }else {
            return JsonMsg.success();
        }
    }



}
