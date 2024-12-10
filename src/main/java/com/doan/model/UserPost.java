package com.doan.model;

import java.sql.Timestamp;
import java.util.List;

public class UserPost {
    private String postID;
    private String userID;
    private String description;
    private Timestamp datePosted;
    private int likeCount;
    private int commentCount;

    public UserPost(String postID, String userID,
            String description, Timestamp datePosted,
            int likeCount, int commentCount) {
        this.postID = postID;
        this.userID = userID;
        this.description = description;
        this.datePosted = datePosted;
        this.likeCount = likeCount;
        this.commentCount = commentCount;
    }

    public String getPostID() {
        return postID;
    }

    public void setPostID(String postID) {
        this.postID = postID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getDatePosted() {
        return datePosted;
    }

    public void setDatePosted(Timestamp datePosted) {
        this.datePosted = datePosted;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public static class PostImage {
        private String postID;
        private int index;
        private String image;

        public PostImage(String postID, int index, String image) {
            this.postID = postID;
            this.index = index;
            this.image = image;
        }

        public String getPostID() {
            return postID;
        }

        public void setPostID(String postID) {
            this.postID = postID;
        }

        public int getIndex() {
            return index;
        }

        public void setIndex(int index) {
            this.index = index;
        }

        public String getImage() {
            return image;
        }

        public void setImage(String image) {
            this.image = image;
        }
    }

    public static class PostData {
        public PostData(UserPost post, String fDatePosted, List<PostImage> images, boolean isLikedByUser) {
            this.post = post;
            this.fDatePosted = fDatePosted;
            this.images = images;
            this.isLikedByUser = isLikedByUser;
        }

        private UserPost post;
        private String fDatePosted;
        private List<PostImage> images;
        private boolean isLikedByUser;

        public UserPost getPost() {
            return post;
        }

        public void setPost(UserPost post) {
            this.post = post;
        }

        public String getfDatePosted() {
            return fDatePosted;
        }

        public void setfDatePosted(String fDatePosted) {
            this.fDatePosted = fDatePosted;
        }

        public List<PostImage> getImages() {
            return images;
        }

        public void setImages(List<PostImage> images) {
            this.images = images;
        }

        public boolean getIsLikedByUser() {
            return isLikedByUser;
        }

        public void setLikedByUser(boolean isLikedByUser) {
            this.isLikedByUser = isLikedByUser;
        }
    }
}