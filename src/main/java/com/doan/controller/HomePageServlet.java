package com.doan.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.doan.model.AccountDetails;
import com.doan.model.PostComment;
import com.doan.model.UserPost;
import com.doan.model.PostComment.PostCommentData;
import com.doan.model.UserPost.PostData;
import com.doan.model.UserPost.PostImage;
import com.doan.model.sql.sqlAccountDetails;
import com.doan.model.sql.sqlFriend;
import com.doan.model.sql.sqlPost;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(
    name="home-page",
    value={
        "/home-page",
        "/Post/GetPosts",
        "/Post/GetComments",
        "/Post/LikePost",
        "/Post/AddComment",
        "/Post/LikeComment"
    })
public class HomePageServlet extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if(uri.contains("/home-page")){
            redirect(request, response);
        }
        else if(uri.contains("/Post")){
            uri.replace("/Post","");
            if(uri.contains("/GetPosts")){
                getUserPosts(request, response);
            }
            if(uri.contains("/GetComments")){
                getCommentsFromPost(request,response);
            }
            if(uri.contains("/LikePost")){
                processLikePost(request, response);
            }
            if(uri.contains("/AddComment")){
                processAddComment(request, response);
            }
            if(uri.contains("/LikeComment")){
                processLikeComment(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        redirect(request, response);
    }

    private void redirect(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("WEB-INF/home-page/home-page.jsp").forward(request, response);
    }

    private void getUserPosts(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        int postCount = Integer.parseInt(request.getParameter("postCount").toString());
        Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate"));
        
        HttpSession session = request.getSession();
        String loggedInUser = session.getAttribute("loggedInID").toString();
        
        HashMap<String,AccountDetails> friendsHashMap = new HashMap<String,AccountDetails>();
        
        friendsHashMap.put(loggedInUser, sqlAccountDetails.getDetails(loggedInUser));

        for(AccountDetails detail: sqlFriend.getAllFriendAccountDetails(loggedInUser)){
            friendsHashMap.put(detail.getUserID(), detail);
        }

        request.setAttribute("userDetails", friendsHashMap);


        List<String> friendIDs = sqlFriend.getFriendIDS(loggedInUser);

        friendIDs.add(loggedInUser);

        List<UserPost> posts = sqlPost.getPostsByDate(endDate, postCount, friendIDs);
        List<PostData> postDatas = new ArrayList<PostData>();
        for(UserPost post:posts){
            List<PostImage> attachedImages = sqlPost.getAttachedImageFromPost(post.getPostID());

            String formattedDate = post.getDatePosted().toString();
            try{
                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");

                java.util.Date date = inputFormat.parse(post.getDatePosted().toString());
                formattedDate = outputFormat.format(date);
            }
            catch(Exception e){
                System.err.println(e.getMessage());
            }
            boolean isLiked = sqlPost.checkUserLikePost(post.getPostID(), loggedInUser);
            postDatas.add(new PostData(post, formattedDate, attachedImages, isLiked));
        }
        request.setAttribute("postItems", postDatas);
        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home-page/components/user-post.jsp");
        dispatcher.forward(request, response);
    }

    public void getCommentsFromPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        int postCount = Integer.parseInt(request.getParameter("commentCount").toString());
        Timestamp endDate = Timestamp.valueOf(request.getParameter("lastDate"));
        String postID =request.getParameter("postID").toString();
        List<PostCommentData> commentData = new ArrayList<PostCommentData>();
    
        HttpSession session = request.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        for(PostComment comment : sqlPost.getCommentsFromPostByCount(postID, postCount, endDate)){
            boolean isLiked = sqlPost.checkUserLikeComment(postID, comment.getCommentID(), userID);

            String formattedDate = comment.getDate().toString();
            try{
                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");

                java.util.Date date = inputFormat.parse(comment.getDate().toString());
                formattedDate = outputFormat.format(date);
            }
            catch(Exception e){
                System.err.println(e.getMessage());
            }

            commentData.add(new PostCommentData(sqlAccountDetails.getDetails(comment.getUserID()), comment,formattedDate,isLiked));
        }
        
        request.setAttribute("commentItems", commentData);

        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home-page/components/comment-section.jsp");
        dispatcher.forward(request, response);
    }

    public void processLikePost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        HttpSession session = request.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        String postID = request.getParameter("postID").toString();
        
        sqlPost.likePost(postID, userID);
    }
    public void processAddComment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        try{
            HttpSession session = request.getSession();
            String userID = session.getAttribute("loggedInID").toString();

            String postID = request.getParameter("postID").toString();
            String commentText = request.getParameter("commentText").toString();


            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date parsedDate = inputFormat.parse(request.getParameter("dateSent").toString());
            Timestamp dateSent = new Timestamp(parsedDate.getTime());


            sqlPost.addCommentToPost(postID, userID, commentText,dateSent );
        }
        catch(Exception e){
            System.err.println(e.getMessage());
        }
    }
    public void processLikeComment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        HttpSession session = request.getSession();
        String userID = session.getAttribute("loggedInID").toString();
        String postID = request.getParameter("postID").toString();
        int commentID = Integer.parseInt(request.getParameter("commentID").toString());

        sqlPost.likeComment(postID, commentID, userID);
    }
}