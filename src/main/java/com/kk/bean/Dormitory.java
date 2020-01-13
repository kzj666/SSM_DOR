package com.kk.bean;



public class Dormitory {
    private String dorId;
    private String dorName;
    private String dorMaster;

    public String getDorId() {
        return dorId;
    }

    public void setDorId(String dorId) {
        this.dorId = dorId;
    }

    public String getDorName() {
        return dorName;
    }

    public void setDorName(String dorName) {
        this.dorName = dorName;
    }

    public String getDorMaster() {
        return dorMaster;
    }

    public void setDorMaster(String dorMaster) {
        this.dorMaster = dorMaster;
    }

    public Dormitory() {
    }

    public Dormitory(String dorId, String dorName, String dorMaster) {
        this.dorId = dorId;
        this.dorName = dorName;
        this.dorMaster = dorMaster;
    }

    @Override
    public String toString() {
        return "Dormitory{" +
                "dorId='" + dorId + '\'' +
                ", dorName='" + dorName + '\'' +
                ", dorMaster='" + dorMaster + '\'' +
                '}';
    }
}
