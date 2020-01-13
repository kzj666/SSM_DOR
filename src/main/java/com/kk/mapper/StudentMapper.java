package com.kk.mapper;

import com.kk.bean.Student;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;


public interface StudentMapper {

    String TABLE_NAME = "tbl_stu";
    String INSERT_FIELDS = "stu_name, stu_tel, gender, sdor_id";
    String SELECT_FIELDS = "stu_id, " + INSERT_FIELDS;


    //================================= 删除 ============================================
    @Delete({"DELETE FROM", TABLE_NAME, "WHERE stu_id = #{stuId}"})
    int deleteOneById(@Param("stuId") Integer stuId);


    //================================= 修改 ============================================
    int updateOneById(@Param("stuId") Integer stuId,
                      @Param("student") Student student);


    //=================================新增============================================

    @Insert({"INSERT INTO", TABLE_NAME, "(",SELECT_FIELDS,") " +
            "VALUES(#{stuId}, " +
            "#{stuName}, " +
            "#{stuTel}, " +
            "#{gender}, " +
            "#{sdorId})"})
    int insertOne(Student student);


    //=================================查询============================================

    Student selectOneById(@Param("stuId") int stuId);

    Student selectOneByName(@Param("stuName") String stuName);

    //查询带有宿舍信息的Student
    Student selectWithDorById(@Param("stuId") String stuId);


    /**
     * 分页查询
     *
     * @param limit  返回记录最大行数
     * @param offset 返回记录行的偏移量
     * @return 如offset=10，limit=5的时候，就会从数据库第11行记录开始返回5条查询结果，即范围从(offset+1)---(offset+limit)
     */
    List<Student> selectByLimitAndOffset(@Param("offset") Integer offset,
                                         @Param("limit") Integer limit);


    //=================================查询总记录数============================================
    @Select({"select count(*) from", TABLE_NAME})
    int countStus();


    //-------------------------------------查询学号是否存在---------------------------------------
    @Select({"select count(*) from", TABLE_NAME, "WHERE stu_id = #{stuId}"})
    int stuIdCount(@Param("stuId") String stuId);

}
