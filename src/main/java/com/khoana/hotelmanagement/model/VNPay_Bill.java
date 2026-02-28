/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.khoana.hotelmanagement.model;

/**
 *
 * @author Huyb
 */
public class VNPay_Bill {
    private String vnpTxnRef;
    private float vnpAmount;
    private String vnpPayDate;
    private String vnpTransactionStatus;
    private int bookingID;

    public VNPay_Bill() {}

    public VNPay_Bill(String vnpTxnRef, float vnpAmount, String vnpPayDate, String vnpTransactionStatus, int bookingID) {
        this.vnpTxnRef = vnpTxnRef;
        this.vnpAmount = vnpAmount;
        this.vnpPayDate = vnpPayDate;
        this.vnpTransactionStatus = vnpTransactionStatus;
        this.bookingID = bookingID;
    }

    public String getVnpTxnRef() { return vnpTxnRef; }
    public void setVnpTxnRef(String vnpTxnRef) { this.vnpTxnRef = vnpTxnRef; }
    public float getVnpAmount() { return vnpAmount; }
    public void setVnpAmount(float vnpAmount) { this.vnpAmount = vnpAmount; }
    public String getVnpPayDate() { return vnpPayDate; }
    public void setVnpPayDate(String vnpPayDate) { this.vnpPayDate = vnpPayDate; }
    public String getVnpTransactionStatus() { return vnpTransactionStatus; }
    public void setVnpTransactionStatus(String vnpTransactionStatus) { this.vnpTransactionStatus = vnpTransactionStatus; }
    public int getBookingID() { return bookingID; }
    public void setBookingID(int bookingID) { this.bookingID = bookingID; }
}
