package com.doan.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;
import java.nio.file.Path;

import com.doan.model.AccountDetails;
import com.doan.model.Account;
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
import jakarta.servlet.http.Part;

@WebServlet(name = "AddNewPost", value = "/AddNewPost")
@MultipartConfig(maxFileSize = 16177215)
public class AddNewPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		if (uri.contains("/AddNewPost")) {
			uri.replace("/AddNewPost", "");
			redirect(request, response);
		}
	}

	private void redirect(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		request.getRequestDispatcher("WEB-INF/home-page/home-page.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		if (uri.contains("/AddNewPost")) {
			uri.replace("/AddNewPost", "");
		}

		HttpSession session = request.getSession();
		String userId = session.getAttribute("loggedInID").toString();
		String description = request.getParameter("postContent").toString();
		description = description.trim();
		try {	

			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date parsedDate = new Date();
			parsedDate = dateFormat.parse(dateFormat.format(parsedDate));
			Timestamp datePosted = new Timestamp(parsedDate.getTime());

			sqlPost.addNewPost(userId, description, datePosted);

		} catch (Exception e) {
			e.printStackTrace();
		}

		UserPost userPost = sqlPost.getNewestPostOfUser(userId);
		String postId = userPost.getPostID();
		Account acc = sqlAccount.getAccountByID(userId);

		// Image
		List<Part> fileParts = request.getParts().stream()
				.filter(part -> "files".equals(part.getName()) && part.getSize() > 0).collect(Collectors.toList()); // Retrieves
																													// <input
																													// type="file"
																													// name="files"
																													// multiple="true">
		int index = 0;
		for (Part filePart : fileParts) {

			String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

			// Tạo tên mới cho tệp tin, có thể sử dụng UUID để đảm bảo tính duy nhất
			String newFileName = postId + "-" + index + "." + getFileExtension(originalFileName);

			// Lưu file vào thư mục
			String uploadDirectory = "C:/tmp/resources/img/userdata/" + acc.getUsername();
			// String uploadPath = uploadDirectory + newFileName;

			// Kiểm tra và tạo thư mục nếu nó chưa tồn tại
			File uploadDir = new File(uploadDirectory);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			filePart.write(uploadDirectory + File.separator + newFileName);

			newFileName = acc.getUsername() + "/" + newFileName;
			// Path projectPath = Paths.get(System.getProperty("user.dir"));
			// Path targetFolder = projectPath.resolve("src/main/resources/img/post_img");
			// System.out.println("Target Folder: " + targetFolder);

			// Lưu tên tệp tin mới vào cơ sở dữ liệu
			sqlPost.addPostImage(postId, index, newFileName);
			++index;
		}

		String loggedInUser = session.getAttribute("loggedInID").toString();

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

		request.setAttribute("postItem", data);

		response.setContentType("text/html");
		response.sendRedirect(request.getContextPath() + "/home-page");
	}

	public String getFileExtension(String fileName) {
		if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0) {
			return fileName.substring(fileName.lastIndexOf(".") + 1);
		} else {
			return ""; // Không có phần mở rộng
		}
	}
}