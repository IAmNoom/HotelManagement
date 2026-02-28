/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.khoana.hotelmanagement.model;

/**
 *
 * @author Huyb
 */
import java.sql.Date;
import java.sql.Timestamp;

public class Booking {
    private int bookingID;
    private int userID;
    private int roomID;
    private Date checkInDate;
    private Date checkOutDate;
    private double totalPrice;
    private String status; // Pending, Confirmed, Cancelled
    private Timestamp bookingDate;//thuộc tính chứa ngày book phòng
    private String roomNumber;
    private String typeName;
    
    public Booking() {
    }

    public Booking(int bookingID, int userID, int roomID, Date checkInDate, Date checkOutDate, double totalPrice, String status) {
        this.bookingID = bookingID;
        this.userID = userID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.totalPrice = totalPrice;
        this.status = status;
    }
    
    public int getBookingID() { return bookingID; }
    public void setBookingID(int bookingID) { this.bookingID = bookingID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public int getRoomID() { return roomID; }
    public void setRoomID(int roomID) { this.roomID = roomID; }

    public Date getCheckInDate() { return checkInDate; }
    public void setCheckInDate(Date checkInDate) { this.checkInDate = checkInDate; }

    public Date getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(Date checkOutDate) { this.checkOutDate = checkOutDate; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }
    
    public String getRoomNumber(){ return roomNumber;}
    public void setRoomNumber(String roomNumber){ this.roomNumber = roomNumber;}
    
    public String getTypeName(){ return typeName;}
    public void setTypeName(String typeName){ this.typeName = typeName;}
}
