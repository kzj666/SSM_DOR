package com.kk.service;

import com.kk.bean.Student;
import com.kk.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    StudentMapper studentMapper;

    public int getStuCount(){
        return studentMapper.countStus();
    }
    public List<Student> getStuList(Integer offser, Integer limit){
        return studentMapper.selectByLimitAndOffset(offser, limit);
    }
    public Student getStuById(Integer stuId){
        return studentMapper.selectOneById(stuId);
    }
    public Student getStuByName(String stuName){
        return studentMapper.selectOneByName(stuName);
    };
    public int updateStuById(Integer stuId, Student student){
        return studentMapper.updateOneById(stuId, student);
    }
    public int deleteStuById(Integer stuId){
        return studentMapper.deleteOneById(stuId);
    }
    public int addStu(Student student){
        return studentMapper.insertOne(student);
    }
    public int stuisexist(String stuId){
        return studentMapper.stuIdCount(stuId);
    }

}
