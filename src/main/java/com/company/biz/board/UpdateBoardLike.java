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

import com.company.jdbc.JDBCConnection;


@WebServlet("/UpdateBoardLike")
public class UpdateBoardLike extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/UpdateBoardLike");
		
		String value=request.getParameter("value");
		int seq=Integer.parseInt(request.getParameter("seq"));
		String id=request.getParameter("id");
		
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql;
			// 최초 공감,비공감 체크 여부를 판정하는 로직 처리
			
			sql="select * from boardlike where id=? and seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setInt(2, seq);
			
			rs=stmt.executeQuery();
			String isCheckCode="G0B0";
			// isCheckCode -> Good 1 Bad 0  G1B0
			// isCheckCode -> Good 0 Bad 1  G0B1	
			
			// 공감 비공감 체크 여부를 정하여 getBoard.jsp로 데이터 전송 예정.
			// getBoard.jsp에서 체크 여부에 따라 버튼의 상태를 javascript로 변화를 주어야 하기 때문.
			if(rs.next()) {
				// 공감 비공감을 체크를 한 경우..
				System.out.println("공감 비공감 체크 진입");
				
				stmt.close();
				rs.close();
				
				if(value.equals("good")) {
					// 공감 누를 경우
					sql="update boardlike set good=1,bad=0,isCheckCode=? where seq=? and id=?";
					isCheckCode="G1B0";
				}else {
					// 비공감 누를 경우
					sql="update boardlike set bad=1,good=0,isCheckCode=? where seq=? and id=?";
					isCheckCode="G0B1";
				}
				
				stmt=conn.prepareStatement(sql);
				stmt.setString(1, isCheckCode);
				stmt.setInt(2, seq);
				stmt.setString(3, id);
				
				
			}else {
				// 공감 비공감 미체크..
				System.out.println("공감 비공감 미체크 진입");
				stmt.close();
				rs.close();
				
				if(value.equals("good")) {
					// 공감 누를 경우
					sql="insert into boardlike(id,seq,good,bad,isCheckCode) values(?,?,1,0,?)";
					isCheckCode="G1B0";
				}else {
					// 비공감 누를 경우
					sql="insert into boardlike(id,seq,good,bad,isCheckCode) values(?,?,0,1,?)";
					isCheckCode="G0B1";
				}
				
				stmt=conn.prepareStatement(sql);
				stmt.setString(1, id);
				stmt.setInt(2, seq);
				stmt.setString(3, isCheckCode);
				
				
			}
			
			int cnt=stmt.executeUpdate();
			
			
			
			if(cnt>0)
				response.sendRedirect("GetBoardCtrl?seq="+seq);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(rs, stmt, conn);
		}
	}

}
