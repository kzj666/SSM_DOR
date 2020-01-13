package com.kk.service;

import com.kk.bean.Dormitory;
import com.kk.mapper.DormitoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DormitoryService {
    @Autowired
    DormitoryMapper dormitoryMapper;

    public int deleteDorById(String dorId){
        return dormitoryMapper.deleteDorById(dorId);
    }
    public int updateDorById(String dorId, Dormitory dormitory){
        return dormitoryMapper.updateDorById(dorId, dormitory);
    }
    public int addDor(Dormitory dormitory){
        return dormitoryMapper.insertDor(dormitory);
    }
    public int getDorCount(){
        return dormitoryMapper.countDors();
    }
    public List<Dormitory> getDorList(Integer offset, Integer limit){
        return dormitoryMapper.selectDorsByLimitAndOffset(offset, limit);
    };
    public Dormitory getDorById(String dorId){
        return dormitoryMapper.selectOneById(dorId);
    }
    public Dormitory getDorByName(String dorName){
        return dormitoryMapper.selectOneByName(dorName);
    }
    public int selectIdExist(String dorId){
        return dormitoryMapper.selectIdExist(dorId);
    }


    public List<Dormitory> getDorName(){
        return dormitoryMapper.selectDorList();
    }

}
