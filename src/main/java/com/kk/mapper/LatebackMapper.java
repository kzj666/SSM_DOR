package com.kk.mapper;

import com.kk.bean.Lateback;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface LatebackMapper {

    String TABLE_NAME = "tbl_lb";
    String INSERT_FIELDS = "lb_id, lb_name, lb_time";
    String SELECT_FIELDS = "lb_id as 'lbId', " +
            "lb_name as 'lbName', " +
            "lb_time as 'lbTime'";


    //=================================删除============================================
    @Delete({"DELETE FROM", TABLE_NAME, "WHERE lb_num=#{lbNum}"})
    int deleteLbById(@Param("lbNum") String lbNum);

    //=================================更改============================================

    int updateLbById(@Param("lbId") String lbId,
                      @Param("lateback") Lateback lateback);

    //=================================新增============================================
    @Insert({"INSERT INTO", TABLE_NAME, "(", "lb_id, lb_name, lb_time",") " +
            "VALUES(#{lateback.lbId}, #{lateback.lbName}, #{lateback.lbTime})"})
    int insertLb(@Param("lateback") Lateback lateback);

    //=================================查询============================================
    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE lb_id=#{lbId}"})
    Lateback selectOneById(@Param("lbId") String lbId);

    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE lb_time=#{lbTime}"})
    Lateback selectOneByTime(@Param("lbTime") String lbTime);

    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE lb_name=#{lbName}"})
    Lateback selectOneByName(@Param("lbName") String lbName);


    @Select({"SELECT COUNT(*) FROM", TABLE_NAME, "WHERE lb_id=#{lbId}"})
    int selectIdExist(@Param("lbId") String lbId);


    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME})
    List<Lateback> selectLbList();

    List<Lateback> selectLbsByLimitAndOffset(@Param("offset") Integer offset,
                                               @Param("limit") Integer limit);

    @Select({"SELECT COUNT(lb_id) FROM", TABLE_NAME,
            "WHERE lbTime = #{lbTime} OR lbName = #{lbName}"})
    int checkLbsExistsByNameAndtime(@Param("lbTime") String lbTime,
                                       @Param("lbName") String lbName);

    @Select({"SELECT COUNT(*) FROM", TABLE_NAME})
    int countLbs();


}
