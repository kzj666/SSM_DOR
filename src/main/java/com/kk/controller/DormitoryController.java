package com.kk.controller;

import com.kk.bean.Dormitory;
import com.kk.service.DormitoryService;
import com.kk.util.JsonMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping(value = "/kk/dor")
public class DormitoryController {

    @Autowired
    DormitoryService dormitoryService;

    /**
     * 删除
     * @param dorId
     * @return
     */
    @RequestMapping(value = "/delDor/{dorId}", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonMsg deleteDor(@PathVariable("dorId") String dorId){
        int res = 0;
        if (dorId != null){
            res = dormitoryService.deleteDorById(dorId);
        }
        if (res != 1){
            return JsonMsg.fail().addInfo("del_dor_error", "删除异常");
        }
        return JsonMsg.success();
    }

    /**
     * 宿舍更改
     * @param dorId
     * @param dormitory
     * @return
     */
    @RequestMapping(value = "/updateDor/{dorId}", method = RequestMethod.PUT)
    @ResponseBody
    public JsonMsg updateDorById(@PathVariable("dorId") String dorId, Dormitory dormitory){

        int res = 0;
        if (dorId != null){
            res = dormitoryService.updateDorById(dorId, dormitory);
        }
        if (res != 1){
            return JsonMsg.fail().addInfo("update_dor_error", "宿舍更新失败");
        }
        return JsonMsg.success();
    }

    /**
     * 新增宿舍
     * @param dormitory
     * @return
     */
    @RequestMapping(value = "/addDor", method = RequestMethod.PUT)
    @ResponseBody
    public JsonMsg addDor(Dormitory dormitory){
//        System.out.println("6666666666666666666666666666666666"+dormitory);
        int res = dormitoryService.addDor(dormitory);
//        System.out.println("55555555555555555555555555555555555"+res);
        if (res != 1){
            return JsonMsg.fail().addInfo("add_dor_error", "添加异常！");
        }
        return JsonMsg.success();
    }

    /**
     * 查询宿舍信息总页码数
     * @return
     */
    @RequestMapping(value = "/getTotalPages", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getTotalPages(){

        //每页显示的记录行数
        int limit = 5;
        //总记录数
        int totalItems = dormitoryService.getDorCount();
        int temp = totalItems / limit;
        int totalPages = (totalItems % limit== 0) ? temp : temp+1;

        return JsonMsg.success().addInfo("totalPages", totalPages);
    }

    /**
     *
     */

    @RequestMapping(value = "/getDorById/{dorId}", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getDorById(@PathVariable("dorId") String dorId){
        Dormitory dormitory = null;
//        System.out.println("////////////////"+dorId);
        if (dorId != null){
            dormitory = dormitoryService.getDorById(dorId);
//            System.out.println("dormitory"+dormitory);
        }
        if (dormitory != null){
            return JsonMsg.success().addInfo("dormitory", dormitory);
        }
        return JsonMsg.fail().addInfo("get_dor_error", "无宿舍信息");
    }

    /**
     * 分页查询：返回指定页数对应的数据
     * @param pageNo
     * @return
     */
    @RequestMapping(value = "/getDorList", method = RequestMethod.GET)
    public ModelAndView getDorList(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo){
        ModelAndView mv = new ModelAndView("dormitoryPage");
        //每页显示的记录行数
        int limit = 5;
        //总记录数
        int totalItems = dormitoryService.getDorCount();
        int temp = totalItems / limit;
        int totalPages = (totalItems % limit== 0) ? temp : temp+1;
        //每页的起始行(offset+1)数据，如第一页(offset=0，从第1(offset+1)行数据开始)
        int offset = (pageNo - 1)*limit;
        List<Dormitory> dormitorys = dormitoryService.getDorList(offset, limit);

        mv.addObject("dormitorys", dormitorys)
                .addObject("totalItems", totalItems)
                .addObject("totalPages", totalPages)
                .addObject("curPageNo", pageNo);
        return mv;
    }

    /**
     * 查询所有宿舍名称
     * @return
     */
    @RequestMapping(value = "/getDorName", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getDorName(){
        List<Dormitory> dormitoryList = dormitoryService.getDorName();

        /*==============================================*/
//        System.out.println(dormitoryList);
        /*==============================================*/


        if (dormitoryList != null){
            return JsonMsg.success().addInfo("dormitoryList", dormitoryList);
        }
        return JsonMsg.fail();
    }


    @RequestMapping(value = "/checkDorExists", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg checkDorExists(@RequestParam("dorName") String dorName){
        Dormitory dormitory = dormitoryService.getDorByName(dorName);
        if (dormitory != null){
            return JsonMsg.fail().addInfo("name_exit_error", "宿舍名已存在");
        }else {
            return JsonMsg.success();
        }
    }

    @RequestMapping(value = "/checkDorIdExists", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg checkDorIdExists(@RequestParam("dorId") String dorId){
        int count = dormitoryService.selectIdExist(dorId);
        if (count > 0){
            return JsonMsg.fail().addInfo("dorid_exit_error", "该宿舍已存在");
        }else {
            return JsonMsg.success();
        }
    }



}
