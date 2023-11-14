package com.doan.model;

import java.sql.Timestamp;

public class PostComment {
    private String postID;
    private int commentID;
    private String userID;
    private String comment;
    private Timestamp date;
    private int likeCount;
    public PostComment(String postID, int commentID, String userID, String comment, Timestamp date, int likeCount) {
        this.postID = postID;
        this.commentID = commentID;
        this.userID = userID;
        this.comment = comment;
        this.date = date;
        this.likeCount = likeCount;
    }
    public String getPostID() {
        return postID;
    }
    public void setPostID(String postID) {
        this.postID = postID;
    }
    public int getCommentID() {
        return commentID;
    }
    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }
    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }
    public String getComment() {
        return comment;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }
    public Timestamp getDate() {
        return date;
    }
    public void setDate(Timestamp date) {
        this.date = date;
    }
    public int getLikeCount() {
        return likeCount;
    }
    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public static class PostCommentData{
        private AccountDetails userDetails;
        private PostComment comment;
        boolean isLikedByUser;

        public PostCommentData(AccountDetails userDetails, PostComment comment, boolean isLikedByUser) {
            this.userDetails = userDetails;
            this.comment = comment;
            this.isLikedByUser = isLikedByUser;
        }
        
        public AccountDetails getUserDetails() {
            return userDetails;
        }
        public void setUserDetails(AccountDetails userDetails) {
            this.userDetails = userDetails;
        }
        public PostComment getComment() {
            return comment;
        }
        public void setComment(PostComment comment) {
            this.comment = comment;
        }
        public boolean getIsLikedByUser() {
            return isLikedByUser;
        }
        public void setLikeByUser(boolean isLikedByUser) {
            this.isLikedByUser = isLikedByUser;
        }

    }
}
