package com.kk.controller;

import com.kk.bean.Visitor;
import com.kk.service.VisitorService;
import com.kk.service.VisitorService;
import com.kk.util.JsonMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping(value = "/kk/vtr")
public class VisitorController {

    @Autowired
    VisitorService visitorService;

    /**
     * 删除
     * @param vtrId
     * @return
     */
    @RequestMapping(value = "/delVtr/{vtrId}", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonMsg deleteVtr(@PathVariable("vtrId") String vtrId){
        int res = 0;
        if (vtrId != null){
            res = visitorService.deleteVtrById(vtrId);
        }
        if (res != 1){
            return JsonMsg.fail().addInfo("del_vtr_error", "删除异常");
        }
        return JsonMsg.success();
    }

    /**
     * 来访更改
     * @param vtrId
     * @param visitor
     * @return
     */
    @RequestMapping(value = "/updateVtr/{vtrId}", method = RequestMethod.PUT)
    @ResponseBody
    public JsonMsg updateVtrById(@PathVariable("vtrId") String vtrId, Visitor visitor){

        int res = 0;
        if (vtrId != null){
            res = visitorService.updateVtrById(vtrId, visitor);
        }
        if (res != 1){
            return JsonMsg.fail().addInfo("update_vtr_error", "来访更新失败");
        }
        return JsonMsg.success();
    }

    /**
     * 新增来访
     * @param visitor
     * @return
     */
    @RequestMapping(value = "/addVtr", method = RequestMethod.PUT)
    @ResponseBody
    public JsonMsg addVtr(Visitor visitor){
        System.out.println("6666666666666666666666666666666666"+visitor);
        int res = visitorService.addVtr(visitor);
        System.out.println("55555555555555555555555555555555555"+res);
        if (res != 1){
            return JsonMsg.fail().addInfo("add_vtr_error", "添加异常！");
        }
        return JsonMsg.success();
    }

    /**
     * 查询来访信息总页码数
     * @return
     */
    @RequestMapping(value = "/getTotalPages", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getTotalPages(){

        //每页显示的记录行数
        int limit = 5;
        //总记录数
        int totalItems = visitorService.getVtrCount();
        int temp = totalItems / limit;
        int totalPages = (totalItems % limit== 0) ? temp : temp+1;

        return JsonMsg.success().addInfo("totalPages", totalPages);
    }

    /**
     *
     */

    @RequestMapping(value = "/getVtrById/{vtrId}", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getVtrById(@PathVariable("vtrId") String vtrId){
        Visitor visitor = null;
//        System.out.println("////////getVtrById////////"+vtrId);
        if (vtrId != null){
            visitor = visitorService.getVtrById(vtrId);
            System.out.println("visitor"+visitor);
        }
        if (visitor != null){
            return JsonMsg.success().addInfo("visitor", visitor);
        }
        return JsonMsg.fail().addInfo("get_vtr_error", "无来访信息");
    }

    /**
     * 分页查询：返回指定页数对应的数据
     * @param pageNo
     * @return
     */
    @RequestMapping(value = "/getVtrList", method = RequestMethod.GET)
    public ModelAndView getVtrList(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo){
        ModelAndView mv = new ModelAndView("visitorPage");
        //每页显示的记录行数
        int limit = 5;
        //总记录数
        int totalItems = visitorService.getVtrCount();
        int temp = totalItems / limit;
        int totalPages = (totalItems % limit== 0) ? temp : temp+1;
        //每页的起始行(offset+1)数据，如第一页(offset=0，从第1(offset+1)行数据开始)
        int offset = (pageNo - 1)*limit;
        List<Visitor> visitors = visitorService.getVtrList(offset, limit);
//        System.out.println("*//////////////getVtrList/////////////////"+visitors);
        mv.addObject("visitors", visitors)
                .addObject("totalItems", totalItems)
                .addObject("totalPages", totalPages)
                .addObject("curPageNo", pageNo);
        return mv;
    }

    /**
     * 查询所有来访名称
     * @return
     */
    @RequestMapping(value = "/getVtrName", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getVtrName(){
        List<Visitor> visitorList = visitorService.getVtrName();

        /*==============================================*/
//        System.out.println(visitorList);
        /*==============================================*/


        if (visitorList != null){
            return JsonMsg.success().addInfo("visitorList", visitorList);
        }
        return JsonMsg.fail();
    }


    @RequestMapping(value = "/checkVtrExists", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg checkVtrExists(@RequestParam("vtrName") String vtrName){
        Visitor visitor = visitorService.getVtrByName(vtrName);
        if (visitor != null){
            return JsonMsg.fail().addInfo("name_exit_error", "来访名已存在");
        }else {
            return JsonMsg.success();
        }
    }

    @RequestMapping(value = "/checkVtrIdExists", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg checkVtrIdExists(@RequestParam("vtrId") String vtrId){
        int count = visitorService.selectIdExist(vtrId);
        if (count > 0){
            return JsonMsg.fail().addInfo("vtrid_exit_error", "该来访者已存在");
        }else {
            return JsonMsg.success();
        }
    }



}
