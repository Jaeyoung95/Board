package com.company.biz.user;

import java.io.IOException;
import java.io.PrintWriter;
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


@WebServlet("/LoginCtrl")
public class LoginCtrl extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		String id=request.getParameter("id");
		String password=request.getParameter("password");
		
		// DB접속
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		try {
			conn=JDBCConnection.getConnection();
			String sql="select * from users where id=? and password=?";
			stmt=conn.prepareStatement(sql);
			
			stmt.setString(1, id);
			stmt.setString(2, password);
			
			rs=stmt.executeQuery();
			
			if(rs.next()) {
				// ID와 비밀번호를 정확히 입력한 경우.(회원가입이 된 계정에 한하여)
				System.out.println(id+"사용자 ID와 비번을 정확히 입력");
				String name=rs.getString("name");
				HttpSession session=request.getSession();
				session.setAttribute("name", name);
				session.setAttribute("id", id);
				// 로그인 확인 후 이름과 ID를 저장하기 위해서 세션영역에 이름,ID 저장. 로그인 후 게시판 리스트 이동
				response.sendRedirect("index.jsp");
			}else {
				// ID와 비밀번호의 정보가 다른 경우.
				System.out.println("해당 사용자가 존재하지 않거나 비번이 잘못되었습니다.");
				out.print("<script>alert('해당 사용자가 존재하지 않거나 비번이 잘못되었습니다.');location.href='login.jsp';</script>");
			}
			
			out.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(rs, stmt, conn);
		}
	}

}
