package dao;

import java.util.*;
import java.sql.*;

import util.DBUtil;
import vo.*;


public class NoticeDao {
	// 마지막 페이지를 구하기
	public int selectNoticeCount() {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT COUNT(notice_no)"
					+ "FROM notice";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			rsSelect = stmtSelect.executeQuery();
			
			if(rsSelect.next()) {
				count = rsSelect.getInt("COUNT(notice_no)");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect,stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	public ArrayList<Notice> selectNoticeListByPage(int biginRow, int rowPerPage) {
		ArrayList<Notice> resultList = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate "
					+ "FROM notice "
					+ "ORDER BY createdate DESC "
					+ "LIMIT ?, ?";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			stmtSelect.setInt(1, biginRow);
			stmtSelect.setInt(2, rowPerPage);
			rsSelect = stmtSelect.executeQuery();
			
			resultList = new ArrayList<Notice>();
			while(rsSelect.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rsSelect.getInt("noticeNo"));
				n.setNoticeMemo(rsSelect.getString("noticeMemo"));
				n.setNoticecreatedate(rsSelect.getString("createdate"));
				
				resultList.add(n);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect,stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return resultList;	
	}
	
	
	
	public ArrayList<Notice> selectNoticeListByPage() {
		ArrayList<Notice> resultList = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate "
					+ "FROM notice ";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			rsSelect = stmtSelect.executeQuery();
			
			resultList = new ArrayList<Notice>();
			while(rsSelect.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rsSelect.getInt("noticeNo"));
				n.setNoticeMemo(rsSelect.getString("noticeMemo"));
				n.setNoticecreatedate(rsSelect.getString("createdate"));
				
				resultList.add(n);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect,stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultList;	
	}
	
	public boolean updateNotice(Notice notice) {
		boolean result = false ;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		try {
			String sqlUpdate ="UPDATE notice SET notice_memo = ?, updatedate = NOW()"
					+" WHERE notice_no = ?";
			
			conn = dbUtil.getConnection();
			stmtUpdate = conn.prepareStatement(sqlUpdate);
			stmtUpdate.setString(1, notice.getNoticeMemo());
			stmtUpdate.setInt(2, notice.getNoticeNo());
			
			int row = stmtUpdate.executeUpdate();
			if(row==1) {
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
	
	public boolean deleteNotice(Notice notice) {
		boolean result = false ;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtDelete = null;
		
		try {
			String sqlDelete ="DELETE notice from notice WHERE notice_no = ?";
			
			conn = dbUtil.getConnection();
			stmtDelete = conn.prepareStatement(sqlDelete);
			stmtDelete.setInt(1, notice.getNoticeNo());
			
			int row = stmtDelete.executeUpdate();
			if(row==1) {
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
	
	public boolean insertNotice(Notice notice) {
		boolean result = false ;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtInsert = null;
		
		try {
			String sqlInsert ="INSERT INTO notice (notice_memo, updatedate, createdate) VALUES (?, now(), now())";
			
			conn = dbUtil.getConnection();
			stmtInsert = conn.prepareStatement(sqlInsert);
			stmtInsert.setString(1, notice.getNoticeMemo());
			
			int row = stmtInsert.executeUpdate();
			if(row==1) {
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
}
