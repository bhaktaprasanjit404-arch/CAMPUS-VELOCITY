/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.capacityconnect.model;

public class Teacher {

    private int id;
    private int userId;
    private String name;
    private String email;

    private String qualification;
    private String specialization;
    private String phone;
    private String bio;

    public Teacher() {
    }

    public Teacher(int id, int userId,
                   String qualification,
                   String specialization,
                   String phone,
                   String bio) {

        this.id = id;
        this.userId = userId;
        this.qualification = qualification;
        this.specialization = specialization;
        this.phone = phone;
        this.bio = bio;
    }

    public Teacher(int id, int userId,
                   String name,
                   String email,
                   String qualification,
                   String specialization,
                   String phone,
                   String bio) {

        this.id = id;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.qualification = qualification;
        this.specialization = specialization;
        this.phone = phone;
        this.bio = bio;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name != null ? name : "Teacher";
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email != null ? email : "";
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }
}