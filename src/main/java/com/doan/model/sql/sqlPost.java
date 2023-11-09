package com.doan.model.sql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import com.doan.model.PostComment;
import com.doan.model.UserPost;

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
    public static List<PostComment> getCommentsFromPost(String postID, Timestamp start, Timestamp end){
        List<PostComment> comments = new ArrayList<PostComment>();
        try{
            
        }
        catch(Exception e){
            System.err.println(e.getMessage());
        }
        return comments;
    }
}
