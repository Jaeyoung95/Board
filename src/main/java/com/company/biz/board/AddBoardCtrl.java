package com.company.biz.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.jdbc.JDBCConnection;


@WebServlet("/AddBoardCtrl")
public class AddBoardCtrl extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/AddBoardCtrl");
		// 1. 접속한 유저 이름 추출
		// 로그인을 안했으면 로그인 페이지로 이동시킨다.
		HttpSession session=request.getSession();
		String name=(String) session.getAttribute("name");
		if(name==null) response.sendRedirect("login.jsp");
		
		// insert,update,delete,또는 select의 조건값이 넘어올 경우 넘어오는 값을 받는다.
		request.setCharacterEncoding("UTF-8");
		String title=request.getParameter("title");
		String nickname=request.getParameter("nickname");
		String content=request.getParameter("content");
		String userid=request.getParameter("userid");
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="insert into board(seq,title,nickname,content,userid) values"
					+ "((select nvl(max(seq),0)+1 from board),?,?,?,?)";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1,title);
			stmt.setString(2,nickname);
			stmt.setString(3,content);
			stmt.setString(4,userid);
			
			int cnt1=stmt.executeUpdate();
			
//			stmt.close();

//			sql="insert into boardlike(seq) values((select max(seq) from board))";
//			stmt=conn.prepareStatement(sql);
			
//			int cnt2=stmt.executeUpdate();
			
			if(cnt1>0)
				response.sendRedirect("GetBoardListCtrl");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
	}

}
