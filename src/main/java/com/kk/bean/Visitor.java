package com.kk.bean;

/*
@author kzj
@date 2020/1/8 - 14:18
*/

public class Visitor {
    private String vtrId;
    private String vtrName;
    private String vtrTime;
    private String vtrReason;

    public String getVtrId() {
        return vtrId;
    }

    public void setVtrId(String vtrId) {
        this.vtrId = vtrId;
    }

    public String getVtrName() {
        return vtrName;
    }

    public void setVtrName(String vtrName) {
        this.vtrName = vtrName;
    }

    public String getVtrTime() {
        return vtrTime;
    }

    public void setVtrTime(String vtrTime) {
        this.vtrTime = vtrTime;
    }

    public String getVtrReason() {
        return vtrReason;
    }

    public void setVtrReason(String vtrReason) {
        this.vtrReason = vtrReason;
    }

    public Visitor() {
    }

    public Visitor(String vtrId, String vtrName, String vtrTime, String vtrReason) {
        this.vtrId = vtrId;
        this.vtrName = vtrName;
        this.vtrTime = vtrTime;
        this.vtrReason = vtrReason;
    }

    @Override
    public String toString() {
        return "Visitor{" +
                "vtrId='" + vtrId + '\'' +
                ", vtrName='" + vtrName + '\'' +
                ", vtrTime='" + vtrTime + '\'' +
                ", vtrReason='" + vtrReason + '\'' +
                '}';
    }
}
