package com.doan.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.doan.model.AccountDetails;
import com.doan.model.UserPost;
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
        "/Post/GetComments"
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
                GetCommentsFromPost(request,response);
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
            postDatas.add(new PostData(post, formattedDate, attachedImages));
        }
        request.setAttribute("postItems", postDatas);

        
        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home-page/components/user-post.jsp");
        dispatcher.forward(request, response);
    }

    public void GetCommentsFromPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        int postCount = Integer.parseInt(request.getParameter("postCount").toString());
        Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate"));
    }
}