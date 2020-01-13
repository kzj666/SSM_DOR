package com.kk.service;

import com.kk.bean.Visitor;
import com.kk.mapper.VisitorMapper;
import com.kk.mapper.VisitorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VisitorService {
    @Autowired
    VisitorMapper visitorMapper;

    public int deleteVtrById(String vtrId){
        return visitorMapper.deleteVtrById(vtrId);
    }
    public int updateVtrById(String vtrId, Visitor visitor){
        return visitorMapper.updateVtrById(vtrId, visitor);
    }
    public int addVtr(Visitor visitor){
        return visitorMapper.insertVtr(visitor);
    }
    public int getVtrCount(){
        return visitorMapper.countVtrs();
    }
    public List<Visitor> getVtrList(Integer offset, Integer limit){
        return visitorMapper.selectVtrsByLimitAndOffset(offset, limit);
    };
    public Visitor getVtrById(String vtrId){
        return visitorMapper.selectOneById(vtrId);
    }
    public Visitor getVtrByName(String vtrName){
        return visitorMapper.selectOneByName(vtrName);
    }
    public int selectIdExist(String vtrId){
        return visitorMapper.selectIdExist(vtrId);
    }


    public List<Visitor> getVtrName(){
        return visitorMapper.selectVtrList();
    }

}
