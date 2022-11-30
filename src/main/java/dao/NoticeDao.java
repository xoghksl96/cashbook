package dao;

import java.util.*;
import java.sql.*;

import util.DBUtil;
import vo.*;


public class NoticeDao {
	// 마지막 페이지를 구하기
	public int selectNoticeCount() throws Exception {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlSelect = "SELECT COUNT(notice_no)"
				+ "FROM notice";
		
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		if(rsSelect.next()) {
			count = rsSelect.getInt("COUNT(notice_no)");
		}
		return count;
	}
	
	public ArrayList<Notice> selectNoticeListByPage(int biginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> resultList = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlSelect = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate "
				+ "FROM notice "
				+ "ORDER BY createdate DESC "
				+ "LIMIT ?, ?";
		
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		stmtSelect.setInt(1, biginRow);
		stmtSelect.setInt(2, rowPerPage);
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		while(rsSelect.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rsSelect.getInt("noticeNo"));
			n.setNoticeMemo(rsSelect.getString("noticeMemo"));
			n.setNoticecreatedate(rsSelect.getString("createdate"));
			
			resultList.add(n);
		}
		return resultList;	
	}
	
	
	
	public ArrayList<Notice> selectNoticeListByPage() throws Exception {
		ArrayList<Notice> resultList = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlSelect = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate "
				+ "FROM notice "
				+ "ORDER BY createdate DESC ";
		
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		while(rsSelect.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rsSelect.getInt("noticeNo"));
			n.setNoticeMemo(rsSelect.getString("noticeMemo"));
			n.setNoticecreatedate(rsSelect.getString("createdate"));
			
			resultList.add(n);
		}
		return resultList;	
	}
	
	public boolean updateNotice(Notice notice) throws Exception {
		boolean result = false ;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlUpdate ="UPDATE notice SET notice_memo = ?, updatedate = NOW()"
				+" WHERE notice_no = ?";
		
		PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate);
		stmtUpdate.setString(1, notice.getNoticeMemo());
		stmtUpdate.setInt(2, notice.getNoticeNo());
		
		int row = stmtUpdate.executeUpdate();
		if(row==1) {
			result = true;
		}
		
		dbUtil.close(stmtUpdate, conn);
		return result;
	}
	
	public boolean deleteNotice(Notice notice) throws Exception {
		boolean result = false ;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlDelete ="DELETE notice from notice WHERE notice_no = ?";
		
		PreparedStatement stmtDelete = conn.prepareStatement(sqlDelete);
		stmtDelete.setInt(1, notice.getNoticeNo());
		
		int row = stmtDelete.executeUpdate();
		if(row==1) {
			result = true;
		}
		
		dbUtil.close(stmtDelete, conn);
		return result;
	}
	
	public boolean insertNotice(Notice notice) throws Exception {
		boolean result = false ;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlInsert ="INSERT INTO notice (notice_memo, updatedate, createdate) VALUES (?, now(), now())";
		
		PreparedStatement stmtInsert = conn.prepareStatement(sqlInsert);
		stmtInsert.setString(1, notice.getNoticeMemo());
		
		int row = stmtInsert.executeUpdate();
		if(row==1) {
			result = true;
		}
		
		dbUtil.close(stmtInsert, conn);
		return result;
	}
}
