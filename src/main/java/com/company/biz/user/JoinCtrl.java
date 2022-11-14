package com.company.biz.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.jdbc.JDBCConnection;


@WebServlet("/JoinCtrl")
public class JoinCtrl extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		String id=request.getParameter("id");
		String password=request.getParameter("password");
		String name=request.getParameter("name");
		
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			conn=JDBCConnection.getConnection();
			String sql="insert into users(id,password,name) values(?,?,?)";
			stmt=conn.prepareStatement(sql);
			
			stmt.setString(1, id);
			stmt.setString(2, password);
			stmt.setString(3, name);
			
			int cnt=stmt.executeUpdate();
			
			System.out.println(cnt+"명 회원 추가");
			
			out.print("<script>alert('회원가입이 되었습니다.');location.href='login.jsp';</script>");
			
			out.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			
		}
	}

}
