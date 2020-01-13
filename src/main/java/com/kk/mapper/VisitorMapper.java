package com.kk.mapper;

import com.kk.bean.Visitor;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface VisitorMapper {

    String TABLE_NAME = "tbl_vtr";
    String INSERT_FIELDS = "vtr_id, vtr_name, vtr_time,vtr_reason";
    String SELECT_FIELDS = "vtr_id as 'vtrId', " +
            "vtr_name as 'vtrName', " +
            "vtr_time as 'vtrTime', " +
            "vtr_reason as vtrReason";


    //=================================删除============================================
    @Delete({"DELETE FROM", TABLE_NAME, "WHERE vtr_id=#{vtrId}"})
    int deleteVtrById(@Param("vtrId") String vtrId);

    //=================================更改============================================

    int updateVtrById(@Param("vtrId") String vtrId,
                     @Param("visitor") Visitor visitor);

    //=================================新增============================================
    @Insert({"INSERT INTO tbl_vtr (vtr_id, vtr_name, vtr_time, vtr_reason) "+
            "VALUES(#{visitor.vtrId}, #{visitor.vtrName}, #{visitor.vtrTime}, #{visitor.vtrReason})"})
    int insertVtr(@Param("visitor") Visitor visitor);

    //=================================查询============================================
    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE vtr_id=#{vtrId}"})
    Visitor selectOneById(@Param("vtrId") String vtrId);

    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE vtr_time=#{vtrTime}"})
    Visitor selectOneByTime(@Param("vtrTime") String vtrTime);

    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE vtr_name=#{vtrName}"})
    Visitor selectOneByName(@Param("vtrName") String vtrName);


    @Select({"SELECT COUNT(*) FROM", TABLE_NAME, "WHERE vtr_id=#{vtrId}"})
    int selectIdExist(@Param("vtrId") String vtrId);


    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME})
    List<Visitor> selectVtrList();

    List<Visitor> selectVtrsByLimitAndOffset(@Param("offset") Integer offset,
                                             @Param("limit") Integer limit);

    @Select({"SELECT COUNT(vtr_id) FROM", TABLE_NAME,
            "WHERE vtrTime = #{vtrTime} OR vtrName = #{vtrName}"})
    int checkVtrsExistsByNameAndtime(@Param("vtrTime") String vtrTime,
                                    @Param("vtrName") String vtrName);

    @Select({"SELECT COUNT(*) FROM", TABLE_NAME})
    int countVtrs();


}
