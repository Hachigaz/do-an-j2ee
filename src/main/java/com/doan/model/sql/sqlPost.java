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
    public static void addNewPost(UserPost post){
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL createPost(?,?,?)";

            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, post.getUserID());
            statement.setString(2, post.getDescription());
            statement.setTimestamp(3, post.getDatePosted());

            statement.execute();

            statement.close();
            connection.close();
        }
        catch(Exception e){
            System.err.println(e.getMessage());
        }
    }
    public static List<UserPost> getPostsWithin(Timestamp start, Timestamp end, List<String> userIDs){
        List<UserPost> posts = new ArrayList<UserPost>();
        try{
            if(userIDs.size()!=0){
                Connection connection = sqlConnect.connectToDB();

                String sql = "SELECT * FROM user_post WHERE ";

                sql+="(";
                for(int i = 0 ; i < userIDs.size(); i++){
                    sql+="userID = " + userIDs.get(i);
                    if(i!=userIDs.size()-1){
                        sql+= " OR ";
                    }
                }
                sql+=")";
                sql+=" AND ";
                sql+="(datePosted <= ? AND datePosted>= ?)";

                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setTimestamp(1, end);
                statement.setTimestamp(2, start);

                ResultSet rs = statement.executeQuery();
                while(rs.next()){
                    posts.add(new UserPost(rs.getString(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getInt(5), rs.getInt(6)));
                }
            }
        }
        catch(Exception e){
            System.err.println(e.getMessage());
        }
        return posts;
    }

    public static List<UserPost> getPostsByDate(Timestamp endDate,int count, List<String> userIDs){
        List<UserPost> posts = new ArrayList<UserPost>();
        try{
            if(userIDs.size()!=0){
                Connection connection = sqlConnect.connectToDB();

                String sql = "SELECT * FROM user_post WHERE ";

                sql+="(";
                for(int i = 0 ; i < userIDs.size(); i++){
                    sql+="userID = " + userIDs.get(i);
                    if(i!=userIDs.size()-1){
                        sql+= " OR ";
                    }
                }
                sql+=") AND (datePosted <= ?) ORDER BY datePosted DESC LIMIT ?";

                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setTimestamp(1, endDate);
                statement.setInt(2,count);

                ResultSet rs = statement.executeQuery();
                while(rs.next()){
                    posts.add(new UserPost(rs.getString(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getInt(5), rs.getInt(6)));
                }
            }
        }
        catch(Exception e){
            System.err.println(e.getMessage());
        }
        return posts;
    }

    public static List<PostComment> getCommentsFromPostByDate(String postID, Timestamp start, Timestamp end){
        List<PostComment> comments = new ArrayList<PostComment>();
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_comment WHERE postID = ?";
            sql+=" AND ";
            sql+="(datePosted <= ? AND datePosted>= ?)";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setTimestamp(2, end);
            statement.setTimestamp(3, start);

            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                comments.add(new PostComment(rs.getString(1),rs.getInt(2),rs.getString(3),rs.getString(4),rs.getTimestamp(5),rs.getInt(6)));
            }
        }
        catch(Exception e){
            System.err.println(e.getMessage());
        }
        return comments;
    }

    public static List<PostComment> getCommentsFromPostByCount(String postID, int count, Timestamp lastTime){
        List<PostComment> comments = new ArrayList<PostComment>();
        try{
            Connection connection = sqlConnect.connectToDB();
            String sql = "SELECT * FROM post_comment WHERE postID = ?";
            sql+=" AND date <= ? ";
            sql+=" ORDER BY date DESC LIMIT ?";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setTimestamp(2, lastTime);
            statement.setInt(3, count);

            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                comments.add(new PostComment(rs.getString(1),rs.getInt(2),rs.getString(3),rs.getString(4),rs.getTimestamp(5),rs.getInt(6)));
            }
        }
        catch(Exception e){
            System.err.println(e.getMessage());
        }
        return comments;
    }

    public static List<PostImage> getAttachedImageFromPost(String postID){
        List<PostImage> attachedImage = new ArrayList<PostImage>();
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_image where postID = ? ORDER BY post_image.index ASC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                attachedImage.add(new PostImage(rs.getString(1),rs.getInt(2),rs.getString(3)));
            }
        }
        catch (Exception e){
            System.err.println(e.getMessage());
        }
        return attachedImage;
    }

    public static void likePost(String postID, String userID){
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL processLikePost(?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);            
            statement.setString(2, userID);

            statement.execute();
        }
        catch (Exception e){
            System.err.println(e.getMessage());
        }
    }

    public static void likeComment(String postID, int commentID, String userID){
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL processLikeComment(?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setInt(2, commentID);            
            statement.setString(3, userID);

            statement.execute();
        }
        catch (Exception e){
            System.err.println(e.getMessage());
        }
    }

    public static void addCommentToPost(String postID, String userID, String comment, Timestamp dateSent){
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL addComment(?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setString(2, userID);            
            statement.setString(3, comment);
            statement.setTimestamp(4, dateSent);

            statement.execute();
        }
        catch (Exception e){
            System.err.println(e.getMessage());
        }
    }

    public static boolean checkUserLikePost(String postID, String userID){
        boolean isAvail = false;
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_like WHERE postID = ? AND userID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setString(2, userID);
            
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                isAvail=true;
            }
        }
        catch (Exception e){
            System.err.println(e.getMessage());
        }
        return isAvail;
    }

    public static boolean checkUserLikeComment(String postID, int commentID, String userID){
        boolean isAvail = false;
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM post_like WHERE postID = ? AND userID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, postID);
            statement.setString(2, userID);
            
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                isAvail=true;
            }
        }
        catch (Exception e){
            System.err.println(e.getMessage());
        }
        return isAvail;
    }
}
