package com.kk.service;

import com.kk.bean.Lateback;
import com.kk.mapper.LatebackMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LatebackService {
    @Autowired
    LatebackMapper latebackMapper;

    public int deleteLbById(String lbNum){
        return latebackMapper.deleteLbById(lbNum);
    }
    public int updateLbById(String lbId, Lateback lateback){
        return latebackMapper.updateLbById(lbId, lateback);
    }
    public int addLb(Lateback lateback){
        return latebackMapper.insertLb(lateback);
    }
    public int getLbCount(){
        return latebackMapper.countLbs();
    }
    public List<Lateback> getLbList(Integer offset, Integer limit){
        return latebackMapper.selectLbsByLimitAndOffset(offset, limit);
    };
    public Lateback getLbById(String lbId){
        return latebackMapper.selectOneById(lbId);
    }
    public Lateback getLbByName(String lbName){
        return latebackMapper.selectOneByName(lbName);
    }
    public int selectIdExist(String lbId){
        return latebackMapper.selectIdExist(lbId);
    }


    public List<Lateback> getLbName(){
        return latebackMapper.selectLbList();
    }

}
