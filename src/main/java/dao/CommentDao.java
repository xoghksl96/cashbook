package dao;

import java.util.*;

import util.DBUtil;

import java.sql.*;

import vo.*;

public class CommentDao {
	public boolean insertComment(Comment insertComment) throws Exception {
		System.out.println("insertComment:"+insertComment.getHelpNo());
		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlInsert = "INSERT INTO comment (help_no, comment_memo, member_id, updatedate, createdate) VALUES(?, ?, ?, now(), now())";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtInsert = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtInsert = conn.prepareStatement(sqlInsert);
		
		// 5. sql세팅
		stmtInsert.setInt(1, insertComment.getHelpNo());
		stmtInsert.setString(2, insertComment.getCommentMemo());
		stmtInsert.setString(3, insertComment.getMemberId());
		
		// 6. sql실행
		int row = stmtInsert.executeUpdate();
		
		// 7. 분기에 따른 반환값 설정
		if(row == 1) {
			result = true;
		}
		
		// 8. DB자원 반납
		dbUtil.close(stmtInsert, conn);
		
		// 9. return
		return result;
	}
	
	public boolean updateComment(Comment updateComment) throws Exception {

		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlUpdate = "UPDATE comment SET comment_memo = ?, updatedate = now() WHERE comment_no = ?";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtUpdate = conn.prepareStatement(sqlUpdate);
		
		// 5. sql세팅
		stmtUpdate.setString(1, updateComment.getCommentMemo());
		stmtUpdate.setInt(2, updateComment.getCommentNo());
		
		// 6. sql실행
		int row = stmtUpdate.executeUpdate();
		
		// 7. 분기에 따른 반환값 설정
		if(row == 1) {
			result = true;
		}
		
		// 8. DB자원 반납
		dbUtil.close(stmtUpdate, conn);
		
		// 9. return
		return result;
		
	}
	
	public boolean deleteComment(Comment deleteComment) throws Exception {

		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlDelete = "DELETE FROM comment WHERE comment_no = ? AND member_id = ?";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtDelete = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtDelete = conn.prepareStatement(sqlDelete);
		
		// 5. sql세팅
		stmtDelete.setInt(1, deleteComment.getCommentNo());
		stmtDelete.setString(2, deleteComment.getMemberId());
		
		// 6. sql실행
		int row = stmtDelete.executeUpdate();
		
		// 7. 분기에 따른 반환값 설정
		if(row == 1) {
			result = true;
		}
		
		// 8. DB자원 반납
		dbUtil.close(stmtDelete, conn);
		
		// 9. return
		return result;
		
	}
}
