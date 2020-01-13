package com.kk.bean;



public class Student {

    private Integer stuId;
    private String stuName;
    private String stuTel;
    private String gender;
    private String sdorId;

    private Dormitory dormitory;

    public Dormitory getDormitory() {
        return dormitory;
    }

    public void setDormitory(Dormitory dormitory) {
        this.dormitory = dormitory;
    }

    public Integer getStuId() {
        return stuId;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getStuTel() {
        return stuTel;
    }

    public void setStuTel(String stuTel) {
        this.stuTel = stuTel;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getSdorId() {
        return sdorId;
    }

    public void setSdorId(String sdorId) {
        this.sdorId = sdorId;
    }

    public Student() {
    }

    public Student(Integer stuId, String stuName, String stuTel, String gender, String sdorId, Dormitory dormitory) {
        this.stuId = stuId;
        this.stuName = stuName;
        this.stuTel = stuTel;
        this.gender = gender;
        this.sdorId = sdorId;
        this.dormitory = dormitory;
    }

    @Override
    public String toString() {
        return "Student{" +
                "stuId=" + stuId +
                ", stuName='" + stuName + '\'' +
                ", stuTel='" + stuTel + '\'' +
                ", gender='" + gender + '\'' +
                ", sdorId='" + sdorId + '\'' +
                ", dormitory=" + dormitory +
                '}';
    }
}
