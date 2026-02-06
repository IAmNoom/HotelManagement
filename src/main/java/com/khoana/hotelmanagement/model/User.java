package com.khoana.hotelmanagement.model;

public class User {

    private int id;
    private String fullName;
    private String email;
    private String password;
    private int roleID;

    public User() {
    }

    public User(int id, String fullName, String email, String password, int roleID) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.roleID = roleID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }
}
