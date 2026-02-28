/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.khoana.hotelmanagement.dal;

/**
 *
 * @author Huyb
 */

import java.sql.PreparedStatement;
import com.khoana.hotelmanagement.model.VNPay_Bill;

public class VNPayBillDAO extends DBContext {
    public boolean createVNPayBill(VNPay_Bill bill) {
        String query = "INSERT INTO VNPay_Bill (vnpTxnRef, vnpAmount, vnpPayDate, vnpTransactionStatus, bookingID) VALUES (?, ?, ?, ?, ?)";
        try {
            if(connection == null) return false;
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, bill.getVnpTxnRef()); 
            ps.setFloat(2, bill.getVnpAmount());   
            ps.setString(3, bill.getVnpPayDate());
            ps.setString(4, bill.getVnpTransactionStatus());
            ps.setInt(5, bill.getBookingID());
            return ps.executeUpdate() > 0; 
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
