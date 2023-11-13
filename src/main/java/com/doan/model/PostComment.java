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
        AccountDetails userDetails;
        PostComment comment;
    }
}
