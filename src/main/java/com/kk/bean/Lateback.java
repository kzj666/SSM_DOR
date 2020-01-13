package com.kk.bean;

/*
@author kzj
@date 2020/1/8 - 10:19
*/

public class Lateback {
    private int lbNum;
    private String lbId;
    private String lbName;
    private String lbTime;

    public int getLbNum() {
        return lbNum;
    }

    public void setLbNum(int lbNum) {
        this.lbNum = lbNum;
    }

    public String getLbId() {
        return lbId;
    }

    public void setLbId(String lbId) {
        this.lbId = lbId;
    }

    public String getLbName() {
        return lbName;
    }

    public void setLbName(String lbName) {
        this.lbName = lbName;
    }

    public String getLbTime() {
        return lbTime;
    }

    public void setLbTime(String lbTime) {
        this.lbTime = lbTime;
    }

    public Lateback() {
    }

    public Lateback(int lbNum, String lbId, String lbName, String lbTime) {
        this.lbNum = lbNum;
        this.lbId = lbId;
        this.lbName = lbName;
        this.lbTime = lbTime;
    }

    @Override
    public String toString() {
        return "Lateback{" +
                "lbNum=" + lbNum +
                ", lbId='" + lbId + '\'' +
                ", lbName='" + lbName + '\'' +
                ", lbTime='" + lbTime + '\'' +
                '}';
    }
}
