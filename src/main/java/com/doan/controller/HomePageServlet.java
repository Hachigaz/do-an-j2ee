package com.doan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.doan.model.Account;
import com.doan.model.AccountDetails;
import com.doan.model.FriendDetails;
import com.doan.model.PostComment;
import com.doan.model.UserPost;
import com.doan.model.PostComment.PostCommentData;
import com.doan.model.UserPost.PostData;
import com.doan.model.UserPost.PostImage;
import com.doan.model.sql.sqlAccount;
import com.doan.model.sql.sqlAccountDetails;
import com.doan.model.sql.sqlFriend;
import com.doan.model.sql.sqlPost;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "home-page", value = {
        "/home-page",
        "/Post/GetHeader",
        "/Post/GetCreatePostInterface",
        "/Post/GetCreatePostContainer",
        "/Post/GetLeftMenu",
        "/Post/GetPosts",
        "/Post/GetComments",
        "/Post/LikePost",
        "/Post/AddComment",
        "/Post/LikeComment",
        "/Post/GetPostDetail",
        "/Post/AddNewPost",
        "/Post/GetImageDetail",
        "/Post/GetRightFriendList",
        "/Post/GetMoreComment",
        "/Post/GetViewMoreComment",
        "/Post/GetMorePosts",
        "/Post/GetLoggedInPosts"
})
@MultipartConfig
public class HomePageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/home-page")) {
            redirect(request, response);
        } else if (uri.contains("/Post")) {
            uri.replace("/Post", "");
            if (uri.contains("/GetHeader")) {
                getHeader(request, response);
            }
            if (uri.contains("/GetCreatePostInterface")) {
                getCreatePostInterface(request, response);
            }
            if (uri.contains("/GetCreatePostContainer")) {
                getCreatePostContainer(request, response);
            }
            if (uri.contains("/GetLeftMenu")) {
                getLeftMenu(request, response);
            }
            if (uri.contains("/GetPosts")) {
                getUserPosts(request, response);
            }
            if (uri.contains("/GetComments")) {
                getCommentsFromPost(request, response);
            }
            if (uri.contains("/LikePost")) {
                processLikePost(request, response);
            }
            if (uri.contains("/AddComment")) {
                processAddComment(request, response);
            }
            if (uri.contains("/LikeComment")) {
                processLikeComment(request, response);
            }
            if (uri.contains("/GetPostDetail")) {
                getPostDetail(request, response);
            }
            if (uri.contains("/AddNewPost")) {
                processAddNewPost(request, response);
            }
            if (uri.contains("/GetImageDetail")) {
                processGetImageDetail(request, response);
            }
            if (uri.contains("/GetRightFriendList")) {
                processGetRightFriendList(request, response);
            }
            if (uri.contains("/GetMoreComment")) {
                processGetMoreComment(request, response);
            }
            if (uri.contains("/GetViewMoreComment")) {
                processGetViewMoreComment(request, response);
            }
            if (uri.contains("/GetMorePosts")) {
                processGetMorePosts(request, response);
            }
            if(uri.contains("/GetLoggedInPosts")){
                getLoggedInUserPosts(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        redirect(request, response);
    }

    private void redirect(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.getRequestDispatcher("WEB-INF/home-page/home-page.jsp").forward(request, response);
    }

    private void getHeader(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String loggedInUserId = session.getAttribute("loggedInID").toString();

        AccountDetails userAcc = sqlAccountDetails.getDetails(loggedInUserId);
        PrintWriter out = response.getWriter();
        out.println("<a href=\"userpage\" class=\"icon\">");
        out.println("<img src=\"/stored-user-images/" + userAcc.getAvatar() + "\" alt=\"user\" id=\"user-img\">");
        out.println("</a>");
    }

    private void getCreatePostInterface(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String loggedInUserId = session.getAttribute("loggedInID").toString();

        AccountDetails userAcc = sqlAccountDetails.getDetails(loggedInUserId);
        PrintWriter out = response.getWriter();
        out.println("<a href=\"userpage\">");
        out.println("<img src=\"/stored-user-images/" + userAcc.getAvatar() + "\">");
        out.println("</a>");
    }

    private void getCreatePostContainer(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        String loggedInUserId = session.getAttribute("loggedInID").toString();

        AccountDetails userAcc = sqlAccountDetails.getDetails(loggedInUserId);
        request.setAttribute("detail", userAcc);

        response.setContentType("text/html");
        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/WEB-INF/home-page/components/create-post-container.jsp");
        dispatcher.forward(request, response);
    }

    private void getLeftMenu(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String loggedInUserId = session.getAttribute("loggedInID").toString();

        AccountDetails userAcc = sqlAccountDetails.getDetails(loggedInUserId);
        PrintWriter out = response.getWriter();
        out.println("<a href=\"userpage\">");
        out.println("<div class=\"line\">");
        out.println("<div class=\"user-img\">");
        out.println("<img src=\"/stored-user-images/" + userAcc.getAvatar() + "\" alt=\"\">");
        out.println("</div>");
        out.println("<div class=\"title\">" + userAcc.getFirstName() + " " + userAcc.getLastName() + "</div>");
        out.println("</div>");
        out.println("</a>");
    }

    private void getUserPosts(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int postCount = Integer.parseInt(request.getParameter("postCount").toString());
        Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate"));

        HttpSession session = request.getSession();
        String loggedInUser = session.getAttribute("loggedInID").toString();

        HashMap<String, AccountDetails> friendsHashMap = new HashMap<String, AccountDetails>();

        friendsHashMap.put(loggedInUser, sqlAccountDetails.getDetails(loggedInUser));

        for (AccountDetails detail : sqlFriend.getAllFriendAccountDetails(loggedInUser)) {
            friendsHashMap.put(detail.getUserID(), detail);
        }

        request.setAttribute("userDetails", friendsHashMap);

        List<String> friendIDs = sqlFriend.getFriendIDS(loggedInUser);

        friendIDs.add(loggedInUser);

        List<UserPost> posts = sqlPost.getPostsByDateAndPos(endDate, postCount, friendIDs, 0);
        List<PostData> postDatas = new ArrayList<PostData>();
        for (UserPost post : posts) {
            List<PostImage> attachedImages = sqlPost.getAttachedImageFromPost(post.getPostID());

            String formattedDate = post.getDatePosted().toString();
            try {
                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");

                java.util.Date date = inputFormat.parse(post.getDatePosted().toString());
                formattedDate = outputFormat.format(date);
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
            boolean isLiked = sqlPost.checkUserLikePost(post.getPostID(), loggedInUser);
            postDatas.add(new PostData(post, formattedDate, attachedImages, isLiked));
        }
        request.setAttribute("postItems", postDatas);
        request.setAttribute("isFirstLoad", "true");
        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home-page/components/user-post.jsp");
        dispatcher.forward(request, response);
    }

    public void getCommentsFromPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int postCount = Integer.parseInt(request.getParameter("commentCount").toString());
        Timestamp endDate = Timestamp.valueOf(request.getParameter("lastDate"));
        String postID = request.getParameter("postID").toString();
        List<PostCommentData> commentData = new ArrayList<PostCommentData>();

        HttpSession session = request.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        for (PostComment comment : sqlPost.getCommentsFromPostByCount(postID, postCount, endDate)) {
            boolean isLiked = sqlPost.checkUserLikeComment(postID, comment.getCommentID(), userID);

            String formattedDate = comment.getDate().toString();
            try {
                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");

                java.util.Date date = inputFormat.parse(comment.getDate().toString());
                formattedDate = outputFormat.format(date);
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }

            commentData.add(new PostCommentData(sqlAccountDetails.getDetails(comment.getUserID()), comment,
                    formattedDate, isLiked));
        }

        request.setAttribute("commentItems", commentData);

        response.setContentType("text/html");
        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/WEB-INF/home-page/components/comment-section.jsp");
        dispatcher.forward(request, response);
    }

    public void processLikePost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        String postID = request.getParameter("postID").toString();

        sqlPost.likePost(postID, userID);
    }

    public void processAddComment(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            HttpSession session = request.getSession();
            String userID = session.getAttribute("loggedInID").toString();

            String postID = request.getParameter("postID").toString();

            String commentText = request.getParameter("commentText").toString();

            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date parsedDate = inputFormat.parse(request.getParameter("dateSent").toString());
            Timestamp dateSent = new Timestamp(parsedDate.getTime());

            sqlPost.addCommentToPost(postID, userID, commentText, dateSent);

            PostComment postComment = sqlPost.getNewestPostCommentOfUser(postID, userID);
            AccountDetails userAcc = sqlAccountDetails.getDetails(userID);

            PrintWriter out = response.getWriter();
            out.println("<div class='comment'>");
            out.println("<div class='user-img'>");
            out.println("<a href='#'>");
            out.println("<img src='/stored-user-images/" + userAcc.getAvatar() + "' alt=`User's Image`>");
            out.println("</a>");
            out.println("</div>");
            out.println("<div class='right'>");
            out.println("<div class='content'>");
            out.println("<div class='username'>");
            out.println("<a href='#''>" + userAcc.getFirstName() + " " + userAcc.getLastName() + "</a>");
            out.println("</div>");
            out.println("<div class='text'>" + postComment.getComment() + "</div>");
            out.println("</div>");
            out.println("<div class='time'>" + postComment.getDate() + "</div>");
            out.println("</div>");
            out.println("</div>");
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public void processLikeComment(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        String userID = session.getAttribute("loggedInID").toString();
        String postID = request.getParameter("postID").toString();
        int commentID = Integer.parseInt(request.getParameter("commentID").toString());

        sqlPost.likeComment(postID, commentID, userID);
    }

    public void getPostDetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String postId = request.getParameter("postId").toString();
        HttpSession session = request.getSession();
        String loggedInUser = session.getAttribute("loggedInID").toString();

        UserPost userPost = sqlPost.getPostByPostId(postId);
        HashMap<String, AccountDetails> friendsHashMap = new HashMap<String, AccountDetails>();

        friendsHashMap.put(loggedInUser, sqlAccountDetails.getDetails(loggedInUser));

        for (AccountDetails detail : sqlFriend.getAllFriendAccountDetails(loggedInUser)) {
            friendsHashMap.put(detail.getUserID(), detail);
        }

        request.setAttribute("userDetails", friendsHashMap);

        List<String> friendIDs = sqlFriend.getFriendIDS(loggedInUser);

        friendIDs.add(loggedInUser);

        List<PostImage> attachedImages = sqlPost.getAttachedImageFromPost(userPost.getPostID());

        String formattedDate = userPost.getDatePosted().toString();
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
            SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");

            java.util.Date date = inputFormat.parse(userPost.getDatePosted().toString());
            formattedDate = outputFormat.format(date);

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        boolean isLiked = sqlPost.checkUserLikePost(postId, loggedInUser);
        PostData data = new PostData(userPost, formattedDate, attachedImages, isLiked);

        int commentCount = Integer.parseInt(request.getParameter("commentCount").toString());
        Timestamp lastDate = Timestamp.valueOf(request.getParameter("lastDate"));

        List<PostCommentData> commentData = new ArrayList<PostCommentData>();

        // String userID = session.getAttribute("loggedInID").toString();

        for (PostComment comment : sqlPost.getCommentsFromPostByCount(postId, commentCount, lastDate)) {
            // boolean isLiked = sqlPost.checkUserLikeComment(postId,
            // comment.getCommentID(), userID);

            String formattedCommentDate = comment.getDate().toString();
            try {
                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");

                java.util.Date date = inputFormat.parse(comment.getDate().toString());
                formattedCommentDate = outputFormat.format(date);
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }

            commentData.add(new PostCommentData(sqlAccountDetails.getDetails(comment.getUserID()), comment,
                    formattedCommentDate, isLiked));
        }

        int commentQuantityAfterPos = sqlPost.getCommentQuantityAfterPosition(postId, commentCount, lastDate,
                commentCount - 1);
        if (commentQuantityAfterPos > 0) {
            request.setAttribute("isExistMoreComment", "true");
            int commentQuantityOfPost = sqlPost.getCommentQuantityByPostID(postId);
            request.setAttribute("commentQuantityOfPost", commentQuantityOfPost);
            request.setAttribute("commentCount", commentCount);
        } else {
            request.setAttribute("isExistMoreComment", "false");
        }

        request.setAttribute("postItem", data);
        request.setAttribute("commentItems", commentData);

        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home-page/components/post-comment.jsp");
        dispatcher.forward(request, response);
    }

    public void processAddNewPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

    }

    public String getPreviousImage(String url) {
        String[] str = url.split("/");
        String currentImgName = str[1];
        String postId = currentImgName.split("-")[0];
        String imgIndex = currentImgName.split("-")[1];
        imgIndex = imgIndex.split("\\.")[0];

        List<PostImage> imgList = sqlPost.getAttachedImageFromPost(postId);
        int leftIndex = Integer.parseInt(imgIndex);
        if (leftIndex == 0) {
            leftIndex = imgList.size() - 1;
        } else {
            leftIndex -= 1;
        }

        PostImage leftImage = sqlPost.getImageFromPost(postId, leftIndex);
        return ("/stored-user-images/" + leftImage.getImage());
    }

    public String getNextImage(String url) {
        String[] str = url.split("/");
        String currentImgName = str[1];
        String postId = currentImgName.split("-")[0];
        String imgIndex = currentImgName.split("-")[1];
        imgIndex = imgIndex.split("\\.")[0];

        List<PostImage> imgList = sqlPost.getAttachedImageFromPost(postId);
        int rightIndex = Integer.parseInt(imgIndex);
        if (rightIndex == imgList.size() - 1) {
            rightIndex = 0;
        } else {
            rightIndex += 1;
        }

        PostImage rightImage = sqlPost.getImageFromPost(postId, rightIndex);
        return ("/stored-user-images/" + rightImage.getImage());
    }

    public void processGetImageDetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String currentImgURL = request.getParameter("imageSrc").toString();

        String preImg = getPreviousImage(currentImgURL);
        String nextImg = getNextImage(currentImgURL);

        request.setAttribute("currentImg", "/stored-user-images/" + currentImgURL);
        request.setAttribute("preImg", preImg);
        request.setAttribute("nextImg", nextImg);

        response.setContentType("text/html");
        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/WEB-INF/home-page/components/post-image-detail.jsp");
        dispatcher.forward(request, response);
    }

    public void processGetRightFriendList(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        String loggedInUser = session.getAttribute("loggedInID").toString();
        int listQuantity = Integer.parseInt(request.getParameter("listQuantity").toString());

        List<String> friendIdList = sqlFriend.getFriendIDS(loggedInUser);
        ArrayList<AccountDetails> friendAccDetailList = new ArrayList<>();
        if (friendIdList.size() != 0) {
            request.setAttribute("hasFriend", "true");
            for (int i = 0; i < friendIdList.size(); i++) {
                if (i == listQuantity) {
                    break;
                }
                AccountDetails accDetail = sqlAccountDetails.getDetails(friendIdList.get(i));
                friendAccDetailList.add(accDetail);
            }
            request.setAttribute("accountDetailList", friendAccDetailList);
        } else {
            request.setAttribute("hasFriend", "false");
        }

        response.setContentType("text/html");
        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/WEB-INF/home-page/components/right-menu-friend-list.jsp");
        dispatcher.forward(request, response);
    }

    public void processGetMoreComment(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String postId = request.getParameter("postId").toString();
        int pos = Integer.parseInt(request.getParameter("pos").toString());
        HttpSession session = request.getSession();
        String loggedInUser = session.getAttribute("loggedInID").toString();

        boolean isLiked = sqlPost.checkUserLikePost(postId, loggedInUser);
        int commentCount = Integer.parseInt(request.getParameter("commentCount").toString());
        Timestamp lastDate = Timestamp.valueOf(request.getParameter("lastDate"));

        List<PostCommentData> commentData = new ArrayList<PostCommentData>();
        for (PostComment comment : sqlPost.getCommentsFromPostByCount(postId, commentCount, lastDate, pos - 1)) {
            String formattedCommentDate = comment.getDate().toString();
            try {
                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");

                java.util.Date date = inputFormat.parse(comment.getDate().toString());
                formattedCommentDate = outputFormat.format(date);
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }

            commentData.add(new PostCommentData(sqlAccountDetails.getDetails(comment.getUserID()), comment,
                    formattedCommentDate, isLiked));
        }

        int commentQuantityAfterPos = sqlPost.getCommentQuantityAfterPosition(postId, commentCount, lastDate,
                pos - 1 + commentCount);
        if (commentQuantityAfterPos > 0) {
            request.setAttribute("isExistMoreComment", "true");
            int commentQuantityOfPost = sqlPost.getCommentQuantityByPostID(postId);
            request.setAttribute("commentQuantityOfPost", commentQuantityOfPost);
            request.setAttribute("commentCount", pos + commentCount);
        } else {
            request.setAttribute("isExistMoreComment", "false");
        }
        request.setAttribute("postID", postId);
        request.setAttribute("commentItems", commentData);

        response.setContentType("text/html");
        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/WEB-INF/home-page/components/comment-section.jsp");
        dispatcher.forward(request, response);
    }

    public void processGetViewMoreComment(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String postId = request.getParameter("postId").toString();
        int pos = Integer.parseInt(request.getParameter("pos").toString());

        int commentCount = Integer.parseInt(request.getParameter("commentCount").toString());
        Timestamp lastDate = Timestamp.valueOf(request.getParameter("lastDate"));

        int commentQuantityAfterPos = sqlPost.getCommentQuantityAfterPosition(postId, commentCount, lastDate,
                pos - 1 + commentCount);
        if (commentQuantityAfterPos > 0) {
            request.setAttribute("isExistMoreComment", "true");
            int commentQuantityOfPost = sqlPost.getCommentQuantityByPostID(postId);
            request.setAttribute("commentQuantityOfPost", commentQuantityOfPost);
            request.setAttribute("commentCount", pos + commentCount);
        } else {
            request.setAttribute("isExistMoreComment", "false");
        }
        request.setAttribute("postID", postId);

        response.setContentType("text/html");
        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/WEB-INF/home-page/components/view-more-comment.jsp");
        dispatcher.forward(request, response);
    }

    public void processGetMorePosts(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int pos = Integer.parseInt(request.getParameter("pos").toString());

        int postCount = Integer.parseInt(request.getParameter("postCount").toString());
        Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate"));

        HttpSession session = request.getSession();
        String loggedInUser = session.getAttribute("loggedInID").toString();

        HashMap<String, AccountDetails> friendsHashMap = new HashMap<String, AccountDetails>();

        friendsHashMap.put(loggedInUser, sqlAccountDetails.getDetails(loggedInUser));

        for (AccountDetails detail : sqlFriend.getAllFriendAccountDetails(loggedInUser)) {
            friendsHashMap.put(detail.getUserID(), detail);
        }

        request.setAttribute("userDetails", friendsHashMap);

        List<String> friendIDs = sqlFriend.getFriendIDS(loggedInUser);

        friendIDs.add(loggedInUser);

        int isExistMorePost = sqlPost.getPostQuantity() - pos;
        if (isExistMorePost > 0) {
            List<UserPost> posts = sqlPost.getPostsByDateAndPos(endDate, postCount, friendIDs, pos);
            List<PostData> postDatas = new ArrayList<PostData>();
            for (UserPost post : posts) {
                List<PostImage> attachedImages = sqlPost.getAttachedImageFromPost(post.getPostID());

                String formattedDate = post.getDatePosted().toString();
                try {
                    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                    SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");

                    java.util.Date date = inputFormat.parse(post.getDatePosted().toString());
                    formattedDate = outputFormat.format(date);
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                }
                boolean isLiked = sqlPost.checkUserLikePost(post.getPostID(), loggedInUser);
                postDatas.add(new PostData(post, formattedDate, attachedImages, isLiked));
            }
            request.setAttribute("postItems", postDatas);
            request.setAttribute("isExistMorePost", "true");
        } else {
            request.setAttribute("isExistMorePost", "false");
        }
        request.setAttribute("isFirstLoad", "false");
        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home-page/components/user-post.jsp");
        dispatcher.forward(request, response);
    }

    private void getLoggedInUserPosts(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException {
        String postCountString = request.getParameter("postCount");

    int postCount = (postCountString != null) ? Integer.parseInt(postCountString) : 10;
    String endDateString = request.getParameter("endDate");
    Timestamp endDate = (endDateString != null) ? Timestamp.valueOf(endDateString) : Timestamp.valueOf("2023-11-11 09:09:09");
HttpSession session = request.getSession();

// Get userID from the request parameter
String fullURL = getFullURL(request);
System.out.println("Full URL: " + fullURL);
String userID = request.getParameter("userID"); 
System.out.println("UserID của page2:" +userID);
// If userID is null or undefined, use loggedInID
if (userID == null || userID.trim().isEmpty()) {
    userID = session.getAttribute("loggedInID").toString();
}
System.out.println("UserID của page:" +userID);
HashMap<String, AccountDetails> friendsHashMap = new HashMap<String, AccountDetails>();
friendsHashMap.put(userID, sqlAccountDetails.getDetails(userID));
request.setAttribute("userDetails", friendsHashMap);

List<String> friendIDs = new ArrayList<String>();
friendIDs.add(userID);

List<UserPost> posts = sqlPost.getPostsByDateAndPos(endDate, postCount, friendIDs, 0);
List<PostData> postDatas = new ArrayList<PostData>();

for (UserPost post : posts) {
    List<PostImage> attachedImages = sqlPost.getAttachedImageFromPost(post.getPostID());
    String formattedDate = post.getDatePosted().toString();
    try {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
        SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");
        java.util.Date date = inputFormat.parse(post.getDatePosted().toString());
        formattedDate = outputFormat.format(date);
    } catch (Exception e) {
        System.err.println(e.getMessage());
    }
    boolean isLiked = sqlPost.checkUserLikePost(post.getPostID(), userID);
    postDatas.add(new PostData(post, formattedDate, attachedImages, isLiked));
}

request.setAttribute("postItems", postDatas);
request.setAttribute("isFirstLoad", "true");
response.setContentType("text/html");

RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/home-page/components/user-post.jsp");
dispatcher.forward(request, response);
}
private String getFullURL(HttpServletRequest request) {
    StringBuilder requestURL = new StringBuilder(request.getRequestURL().toString());
    String queryString = request.getQueryString();

    if (queryString != null) {
        requestURL.append("?").append(queryString);
    }

    return requestURL.toString();
}
}