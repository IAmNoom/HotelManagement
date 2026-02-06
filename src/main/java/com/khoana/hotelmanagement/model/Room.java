package com.khoana.hotelmanagement.model;

public class Room {

    
    private int roomID;   
    private String roomNumber;  
    private String roomType;    
    private double price;
    private String status;      
    private String description; 
    private String image;

    public Room() {
    }

    public Room(int roomID, String roomNumber, String roomType, double price, String status, String description, String image) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.price = price;
        this.status = status;
        this.description = description;
        this.image = image;
    }

    // --- GETTERS AND SETTERS ---
    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Room{" + "roomID=" + roomID + ", roomNumber=" + roomNumber + ", roomType=" + roomType + ", price=" + price + ", status=" + status + '}';
    }
}
