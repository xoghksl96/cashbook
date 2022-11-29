package dao;

import java.util.*;

import util.DBUtil;

import java.sql.*;

import vo.*;

public class HelpDao {
	public ArrayList<Help> selectHelpList(String memberId) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT help_no helpNo, help_memo helpMemo, updatedate, createdate FROM help WHERE member_id = ?";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		
		stmtSelect.setString(1, memberId);
		
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		ArrayList<Help> resultList = new ArrayList<Help> ();
		
		while(rsSelect.next())
		{
			Help help = new Help();
			help.setHelpNo(rsSelect.getInt("helpNo"));
			help.setHelpMemo(rsSelect.getString("helpMemo"));
			help.setUpdatedate(rsSelect.getString("updatedate"));
			help.setCreatedate(rsSelect.getString("createdate"));
			resultList.add(help);
		}
		
		dbUtil.close(rsSelect, stmtSelect, conn);
		return resultList;
		
	}
	public ArrayList<HashMap<String,Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String,Object>> returnList = new ArrayList<HashMap<String,Object>>();
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT h.help_no,"
				+ " h.help_memo, "
				+ "h.member_id, "
				+ "h.updatedate, "
				+ "h.createdate, "
				+ "c.comment_no, "
				+ "c.comment_memo, "
				+ "c.member_id, "
				+ "c.updatedate, "
				+ "c.createdate "
				+ "FROM help h LEFT JOIN comment c "
				+ "ON h.help_no = c.help_no "
				+ "ORDER BY h.createdate DESC "
				+ "LIMIT ?,?";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		stmtSelect.setInt(1, beginRow);
		stmtSelect.setInt(2, rowPerPage);
		
		ResultSet rsSelect = stmtSelect.executeQuery();
	
		
		while(rsSelect.next()) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("helpNo", rsSelect.getInt("h.help_no"));
			resultMap.put("helpMemo", rsSelect.getString("h.help_memo"));
			resultMap.put("helpMemberId", rsSelect.getString("h.member_id"));
			resultMap.put("helpUpdatedate", rsSelect.getString("h.updatedate"));
			resultMap.put("helpCreatedate", rsSelect.getString("h.createdate"));
			resultMap.put("commentNo", rsSelect.getInt("c.comment_no"));
			resultMap.put("commentMemo", rsSelect.getString("c.comment_memo"));
			resultMap.put("commentMemberId", rsSelect.getString("c.member_id"));
			resultMap.put("commentUpdatedate", rsSelect.getString("c.updatedate"));
			resultMap.put("commentCreatedate", rsSelect.getString("c.createdate"));
			
			returnList.add(resultMap);
		}
		return returnList;		
	}
	
	public HashMap<String, Object> selectHelpOne (String memberId, int helpNo) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT h.help_no,"
				+ " h.help_memo, "
				+ "h.member_id, "
				+ "h.updatedate, "
				+ "h.createdate, "
				+ "c.comment_no, "
				+ "c.comment_memo, "
				+ "c.member_id, "
				+ "c.updatedate, "
				+ "c.createdate "
				+ "FROM help h LEFT JOIN comment c "
				+ "ON h.help_no = c.help_no "
				+ "WHERE h.member_id = ? AND h.help_no = ?";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		stmtSelect.setString(1, memberId);
		stmtSelect.setInt(2, helpNo);
		
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(rsSelect.next()) {
			resultMap.put("helpNo", rsSelect.getInt("h.help_no"));
			resultMap.put("helpMemo", rsSelect.getString("h.help_memo"));
			resultMap.put("helpMemberId", rsSelect.getString("h.member_id"));
			resultMap.put("helpUpdatedate", rsSelect.getString("h.updatedate"));
			resultMap.put("helpCreatedate", rsSelect.getString("h.createdate"));
			resultMap.put("commentNo", rsSelect.getInt("c.comment_no"));
			resultMap.put("commentMemo", rsSelect.getString("c.comment_memo"));
			resultMap.put("commentMemberId", rsSelect.getString("c.member_id"));
			resultMap.put("commentUpdatedate", rsSelect.getString("c.updatedate"));
			resultMap.put("commentCreatedate", rsSelect.getString("c.createdate"));
		}
		return resultMap;
		
	}
	
public HashMap<String, Object> selectHelpOneByAdmin (int helpNo) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT h.help_no,"
				+ " h.help_memo, "
				+ "h.member_id, "
				+ "h.updatedate, "
				+ "h.createdate, "
				+ "c.comment_no, "
				+ "c.comment_memo, "
				+ "c.member_id, "
				+ "c.updatedate, "
				+ "c.createdate "
				+ "FROM help h LEFT JOIN comment c "
				+ "ON h.help_no = c.help_no "
				+ "WHERE h.help_no = ?";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		stmtSelect.setInt(1, helpNo);
		
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(rsSelect.next()) {
			resultMap.put("helpNo", rsSelect.getInt("h.help_no"));
			resultMap.put("helpMemo", rsSelect.getString("h.help_memo"));
			resultMap.put("helpMemberId", rsSelect.getString("h.member_id"));
			resultMap.put("helpUpdatedate", rsSelect.getString("h.updatedate"));
			resultMap.put("helpCreatedate", rsSelect.getString("h.createdate"));
			resultMap.put("commentNo", rsSelect.getInt("c.comment_no"));
			resultMap.put("commentMemo", rsSelect.getString("c.comment_memo"));
			resultMap.put("commentMemberId", rsSelect.getString("c.member_id"));
			resultMap.put("commentUpdatedate", rsSelect.getString("c.updatedate"));
			resultMap.put("commentCreatedate", rsSelect.getString("c.createdate"));
		}
		return resultMap;
		
	}
	
	// 마지막 페이지를 구하기
	public int selectHelpCount() throws Exception {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlSelect = "SELECT COUNT(help_no)"
				+ "FROM help";
		
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		if(rsSelect.next()) {
			count = rsSelect.getInt("COUNT(help_no)");
		}
		return count;
	}
		
	public boolean insertHelp(Help insertHelp) throws Exception {
		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlInsert = "INSERT INTO help (help_memo, member_id, updatedate, createdate) VALUES(?, ?, now(), now()) ";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtInsert = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtInsert = conn.prepareStatement(sqlInsert);
		
		// 5. sql세팅
		stmtInsert.setString(1, insertHelp.getHelpMemo());
		stmtInsert.setString(2, insertHelp.getMemberId());
		
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
	
	public boolean updateHelp(Help updateHelp) throws Exception {

		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlUpdate = "UPDATE help SET help_memo = ?, updatedate = now() WHERE help_no = ?";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtUpdate = conn.prepareStatement(sqlUpdate);
		
		// 5. sql세팅
		stmtUpdate.setString(1, updateHelp.getHelpMemo());
		stmtUpdate.setInt(2, updateHelp.getHelpNo());
		
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
	
	public boolean deleteHelp(Help deleteHelp) throws Exception {

		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlDelete = "DELETE FROM help WHERE help_no = ?";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtDelete = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtDelete = conn.prepareStatement(sqlDelete);
		
		// 5. sql세팅
		stmtDelete.setInt(1, deleteHelp.getHelpNo());
		
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
