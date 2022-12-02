package dao;

import java.util.*;

import util.DBUtil;

import java.sql.*;

import vo.*;

public class CommentDao {
	public boolean insertComment(Comment insertComment) {
		
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtInsert = null;
			
		try {
			String sqlInsert = "INSERT INTO comment (help_no, comment_memo, member_id, updatedate, createdate) VALUES(?, ?, ?, now(), now())";
			
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
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(stmtInsert, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	public boolean updateComment(Comment updateComment) {

		boolean result = false;

		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		try {
			String sqlUpdate = "UPDATE comment SET comment_memo = ?, updatedate = now() WHERE comment_no = ?";
			
			conn = dbUtil.getConnection();
			stmtUpdate = conn.prepareStatement(sqlUpdate);
			
			stmtUpdate.setString(1, updateComment.getCommentMemo());
			stmtUpdate.setInt(2, updateComment.getCommentNo());
			
			int row = stmtUpdate.executeUpdate();
			
			if(row == 1) {
				result = true;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(stmtUpdate, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	public boolean deleteComment(Comment deleteComment) {

		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtDelete = null;
			
		try {
			String sqlDelete = "DELETE FROM comment WHERE comment_no = ? AND member_id = ?";
			
			conn = dbUtil.getConnection();
			stmtDelete = conn.prepareStatement(sqlDelete);
			
			stmtDelete.setInt(1, deleteComment.getCommentNo());
			stmtDelete.setString(2, deleteComment.getMemberId());
			
			int row = stmtDelete.executeUpdate();
			
			if(row == 1) {
				result = true;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(stmtDelete, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
