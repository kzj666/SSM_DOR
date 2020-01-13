package com.kk.mapper;

import com.kk.bean.Dormitory;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface DormitoryMapper {

    String TABLE_NAME = "tbl_dor";
    String INSERT_FIELDS = "dor_name, dor_master";
    String SELECT_FIELDS = "dor_id as 'dorId', " +
            "dor_name as 'dorName', " +
            "dor_master as 'dorMaster'";


    //=================================删除============================================
    @Delete({"DELETE FROM", TABLE_NAME, "WHERE dor_id=#{dorId}"})
    int deleteDorById(@Param("dorId") String dorId);

    //=================================更改============================================

    int updateDorById(@Param("dorId") String dorId,
                       @Param("dormitory") Dormitory dormitory);

    //=================================新增============================================
    @Insert({"INSERT INTO", TABLE_NAME, "(", "dor_id, dor_name, dor_master",") " +
            "VALUES(#{dormitory.dorId}, #{dormitory.dorName}, #{dormitory.dorMaster})"})
    int insertDor(@Param("dormitory") Dormitory dormitory);

    //=================================查询============================================
    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE dor_id=#{dorId}"})
    Dormitory selectOneById(@Param("dorId") String dorId);

    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE dor_master=#{dorMaster}"})
    Dormitory selectOneByMaster(@Param("dorMaster") String dorMaster);

    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME, "WHERE dor_name=#{dorName}"})
    Dormitory selectOneByName(@Param("dorName") String dorName);


    @Select({"SELECT COUNT(*) FROM", TABLE_NAME, "WHERE dor_id=#{dorId}"})
    int selectIdExist(@Param("dorId") String dorId);


    @Select({"SELECT", SELECT_FIELDS, "FROM", TABLE_NAME})
    List<Dormitory> selectDorList();

    List<Dormitory> selectDorsByLimitAndOffset(@Param("offset") Integer offset,
                                                @Param("limit") Integer limit);

    @Select({"SELECT COUNT(dor_id) FROM", TABLE_NAME,
            "WHERE dorMaster = #{dorMaster} OR dorName = #{dorName}"})
    int checkDorsExistsByNameAndmaster(@Param("dorMaster") String dorMaster,
                                        @Param("dorName") String dorName);

    @Select({"SELECT COUNT(*) FROM", TABLE_NAME})
    int countDors();


}
