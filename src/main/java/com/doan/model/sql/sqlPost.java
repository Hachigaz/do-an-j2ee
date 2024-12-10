package com.doan.model.sql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.doan.model.PostComment;
import com.doan.model.UserPost;
import com.doan.model.UserPost.PostImage;

public class sqlPost {
    public static void addNewPost(String userId, String description, Timestamp datePosted) {
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL createPost(?,?,?)";

            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, userId);
            statement.setString(2, description);
            statement.setTimestamp(3, datePosted);

            statement.execute();

            statement.close();
            connection.close();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public static List<UserPost> getPostsWithin(Timestamp start, Timestamp end, List<String> userIDs) {
        List<UserPost> posts = new ArrayList<UserPost>();
        try {
            if (userIDs.size() != 0) {
                Connection connection = sqlConnect.connectToDB();

                String sql = "SELECT * FROM user_post WHERE ";

                sql += "(";
                for (int i = 0; i < userIDs.size(); i++) {
                    sql += "userID = " + userIDs.get(i);
                    if (i != userIDs.size() - 1) {
                        sql += " OR ";
                    }
                }
                sql += ")";
                sql += " AND ";
                sql += "(datePosted <= ? AND datePosted>= ?)";

                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setTimestamp(1, end);
                statement.setTimestamp(2, start);

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    posts.add(new UserPost(rs.getString(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4),
                            rs.getInt(5), rs.getInt(6)));
                }
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return posts;
    }

    public static List<UserPost> getPostsByDate(Timestamp endDate, int count, List<String> userIDs) {
        List<UserPost> posts = new ArrayList<UserPost>();
        try {
            if (userIDs.size() != 0) {
                Connection connection = sqlConnect.connectToDB();

                String sql = "SELECT * FROM user_post WHERE ";

                sql += "(";
                for (int i = 0; i < userIDs.size(); i++) {
                    sql += "userID = " + userIDs.get(i);
                    if (i != userIDs.size() - 1) {
                        sql += " OR ";
                    }
                }
                sql += ") AND (datePosted <= ?) ORDER BY datePosted DESC LIMIT ?";

                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setTimestamp(1, endDate);
                statement.setInt(2, count);

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    posts.add(new UserPost(rs.getString(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4),
                            rs.getInt(5), rs.getInt(6)));
                }
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return posts;
    }

    public static List<PostComment> getCommentsFromPostByDate(String postID, Timestamp start, Timestamp end) {
        List<PostComment> comments = new ArrayList<PostComment>();
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_comment WHERE postID = ?";
            sql += " AND ";
            sql += "(datePosted <= ? AND datePosted>= ?)";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setTimestamp(2, end);
            statement.setTimestamp(3, start);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                comments.add(new PostComment(rs.getString(1), rs.getInt(2), rs.getString(3), rs.getString(4),
                        rs.getTimestamp(5), rs.getInt(6)));
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return comments;
    }

    public static List<PostComment> getCommentsFromPostByCount(String postID, int count, Timestamp lastTime) {
        List<PostComment> comments = new ArrayList<PostComment>();
        try {
            Connection connection = sqlConnect.connectToDB();
            // String sql = "SELECT * FROM post_comment WHERE postID = ?";
            // sql += " AND date <= ? ";
            // sql += " ORDER BY date DESC LIMIT ?";

            String sql = "SELECT * FROM post_comment WHERE postID = ? LIMIT ?";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            // statement.setTimestamp(2, lastTime);
            statement.setInt(2, count);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                comments.add(new PostComment(rs.getString(1), rs.getInt(2), rs.getString(3), rs.getString(4),
                        rs.getTimestamp(5), rs.getInt(6)));
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return comments;
    }

    public static List<PostImage> getAttachedImageFromPost(String postID) {
        List<PostImage> attachedImage = new ArrayList<PostImage>();
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_image where postID = ? ORDER BY image_index ASC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                attachedImage.add(new PostImage(rs.getString(1), rs.getInt(2), rs.getString(3)));
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return attachedImage;
    }

    public static PostImage getImageFromPost(String postID, int index) {
        PostImage img = null;
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_image where postID = ? and image_index = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setInt(2, index);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                img = new PostImage(rs.getString(1), rs.getInt(2), rs.getString(3));
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return img;
    }

    public static void likePost(String postID, String userID) {
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL processLikePost(?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setString(2, userID);

            statement.execute();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public static void likeComment(String postID, int commentID, String userID) {
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL processLikeComment(?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setInt(2, commentID);
            statement.setString(3, userID);

            statement.execute();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public static void addCommentToPost(String postID, String userID, String comment, Timestamp dateSent) {
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL addComment(?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setString(2, userID);
            statement.setString(3, comment);
            statement.setTimestamp(4, dateSent);

            statement.execute();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public static boolean checkUserLikePost(String postID, String userID) {
        boolean isAvail = false;
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_like WHERE postID = ? AND userID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setString(2, userID);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                isAvail = true;
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return isAvail;
    }

    public static boolean checkUserLikeComment(String postID, int commentID, String userID) {
        boolean isAvail = false;
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_like WHERE postID = ? AND userID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setString(2, userID);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                isAvail = true;
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return isAvail;
    }

    public static UserPost getPostByPostId(String id) {
        UserPost userPost = null;
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM user_post WHERE postID = '" + id + "'";

            PreparedStatement statement = connection.prepareStatement(sql);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                String postId = rs.getString(1);
                String userId = rs.getString(2);
                String description = rs.getString(3);
                Timestamp datePosted = rs.getTimestamp(4);
                int likeCount = rs.getInt(5);
                int commentCount = rs.getInt(6);
                userPost = new UserPost(postId, userId, description, datePosted, likeCount, commentCount);
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return userPost;
    }

    public static UserPost getNewestPostOfUser(String userId) {
        UserPost userPost = null;
        try {
            Connection connection = sqlConnect.connectToDB();
            String sql = "SELECT * FROM user_post WHERE userID = '" + userId + "' ";
            sql += "ORDER BY datePosted DESC LIMIT 1";

            System.out.println(sql);
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                String postId = rs.getString(1);
                String description = rs.getString(3);
                Timestamp datePosted = rs.getTimestamp(4);
                int likeCount = rs.getInt(5);
                int commentCount = rs.getInt(6);
                userPost = new UserPost(postId, userId, description, datePosted, likeCount, commentCount);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userPost;
    }

    public static PostComment getNewestPostCommentOfUser(String postId, String userId) {
        PostComment postComment = null;
        try {
            Connection connection = sqlConnect.connectToDB();
            String sql = "select * ";
            sql += "from post_comment ";
            sql += "where userId = '" + userId + "' and postID = '" + postId + "' ";
            sql += "order by commentID DESC limit 1";

            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                postComment = new PostComment(
                        rs.getString(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getTimestamp(5),
                        rs.getInt(6));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return postComment;
    }

    public static void addPostImage(String postId, int index, String url) {
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "INSERT INTO post_image (postID, image_index, image) VALUES (?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postId);
            statement.setInt(2, index);
            statement.setString(3, url);

            statement.execute();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public static List<PostComment> getCommentsFromPostByCount(String postID, int count, Timestamp lastTime, int pos) {
        List<PostComment> comments = new ArrayList<PostComment>();
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * " + 
                    "FROM `post_comment` " + 
                    "WHERE postID = ? AND commentID > ? " + 
                    "ORDER BY commentID ASC LIMIT ?";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setInt(2, pos);
            statement.setInt(3, count);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                comments.add(new PostComment(rs.getString(1), rs.getInt(2), rs.getString(3), rs.getString(4),
                        rs.getTimestamp(5), rs.getInt(6)));
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return comments;
    }

    public static int getCommentQuantityAfterPosition(String postID, int count, Timestamp lastTime, int pos) {
        int quantity = 0;
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT COUNT(commentID) as count " + 
                    "FROM `post_comment` " + 
                    "WHERE postID = ? AND commentID > ? " + 
                    "ORDER BY commentID ASC LIMIT ?";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setInt(2, pos);
            statement.setInt(3, count);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("count");
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return quantity;
    }

    public static int getCommentQuantityByPostID(String postID) {
        int quantity = 0;
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT COUNT(commentID) as count FROM `post_comment` WHERE postID = ?";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("count");
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return quantity;
    }

    public static List<UserPost> getPostsByDateAndPos(Timestamp endDate, int count, List<String> userIDs, int pos) {
        List<UserPost> posts = new ArrayList<UserPost>();
        try {
            if (userIDs.size() != 0) {
                Connection connection = sqlConnect.connectToDB();

                String sql = "SELECT * FROM user_post WHERE ";

                sql += "(";
                for (int i = 0; i < userIDs.size(); i++) {
                    sql += "userID = " + userIDs.get(i);
                    if (i != userIDs.size() - 1) {
                        sql += " OR ";
                    }
                }
                sql += ") AND (datePosted <= '" + endDate + "') ORDER BY datePosted DESC LIMIT " + count + " OFFSET " + pos;
                //System.out.println("GetPostByDateAndPost SQL: " + sql);
                PreparedStatement statement = connection.prepareStatement(sql);
                // statement.setTimestamp(1, endDate);
                // statement.setInt(2, count);
                // statement.setInt(3, pos);

                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    posts.add(new UserPost(rs.getString(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4),
                            rs.getInt(5), rs.getInt(6)));
                }
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return posts;
    }

    public static int getPostQuantityAfterPosition(Timestamp endDate, int count, List<String> userIDs, int pos) {
        int quantity = 0;
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "select count(*) " +
            "from `user_post` " +
            "where CAST(postID as INT) < ((select count(*) from `user_post`) - ?) " +
            "order by datePosted desc";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, count * 2);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("count");
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return quantity;
    }

    public static int getPostQuantity() {
        int quantity = 0;
        try {
            Connection connection = sqlConnect.connectToDB();

            String sql = "select count(*) as quantity from `user_post`";

            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return quantity;
    }
}
