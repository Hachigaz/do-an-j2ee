package com.doan.model;

import java.sql.Timestamp;
import java.util.ArrayList;

public class ChatObject {
    public static class Message{

        public Message(String userID, int index, String message, Timestamp dateSent) {
            this.userID = userID;
            this.index = index;
            this.message = message;
            this.dateSent = dateSent;
        }
        protected String userID;
        protected int index;
        protected String message;
        protected Timestamp dateSent;
        
        public String getUserID() {
            return userID;
        }
        public void setUserID(String userID) {
            this.userID = userID;
        }
        public String getMessage() {
            return message;
        }
        public void setMessage(String message) {
            this.message = message;
        }

        public int getIndex() {
            return index;
        }

        public void setIndex(int index) {
            this.index = index;
        }
        public Timestamp getDateSent() {
            return dateSent;
        }
        public void setDateSent(Timestamp dateSent) {
            this.dateSent = dateSent;
        }
    }

    public static class MessageWithImage extends Message{

        private ArrayList<String> images;

        public MessageWithImage(String userID, int index, String message,Timestamp dateSent, ArrayList<String> images) {
            super(userID, index, message, dateSent);
            this.images = images;
        }

        public ArrayList<String> getImages() {
            return images;
        }

        public void setImages(ArrayList<String> images) {
            this.images = images;
        }
    }
}
