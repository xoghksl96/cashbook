package dao;

import java.util.*;

import util.DBUtil;

import java.sql.*;

import vo.*;

public class HelpDao {
	public ArrayList<Help> selectHelpList(String memberId) {
		ArrayList<Help> resultList = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT help_no helpNo, help_memo helpMemo, updatedate, createdate FROM help WHERE member_id = ?";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			
			stmtSelect.setString(1, memberId);
			
			rsSelect = stmtSelect.executeQuery();
			
			resultList = new ArrayList<Help> ();
			
			while(rsSelect.next())
			{
				Help help = new Help();
				help.setHelpNo(rsSelect.getInt("helpNo"));
				help.setHelpMemo(rsSelect.getString("helpMemo"));
				help.setUpdatedate(rsSelect.getString("updatedate"));
				help.setCreatedate(rsSelect.getString("createdate"));
				resultList.add(help);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect, stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return resultList;
		
	}
	public ArrayList<HashMap<String,Object>> selectHelpList(int beginRow, int rowPerPage) {
		ArrayList<HashMap<String,Object>> returnList = null;

		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
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
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			
			stmtSelect.setInt(1, beginRow);
			stmtSelect.setInt(2, rowPerPage);
			
			rsSelect = stmtSelect.executeQuery();
		
			returnList = new ArrayList<HashMap<String,Object>>();
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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect, stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return returnList;		
	}
	
	public HashMap<String, Object> selectHelpOne (String memberId, int helpNo) {
		HashMap<String, Object> resultMap = null;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;

		try {
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
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			
			stmtSelect.setString(1, memberId);
			stmtSelect.setInt(2, helpNo);
			
			rsSelect = stmtSelect.executeQuery();
			
			resultMap = new HashMap<String, Object>();
			
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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect, stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return resultMap;
		
	}
	
	public HashMap<String, Object> selectHelpOneByAdmin (int helpNo) {
		
		HashMap<String, Object> resultMap = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
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
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			
			stmtSelect.setInt(1, helpNo);
			
			rsSelect = stmtSelect.executeQuery();
			
			resultMap = new HashMap<String, Object>();
			
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
		} catch(Exception e) {
			e.printStackTrace(); 
		} finally {
			try {
				dbUtil.close(rsSelect, stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultMap;
		
	}
	
	// 마지막 페이지를 구하기
	public int selectHelpCount() {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT COUNT(help_no)"
					+ "FROM help";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			rsSelect = stmtSelect.executeQuery();
			
			if(rsSelect.next()) {
				count = rsSelect.getInt("COUNT(help_no)");
			}	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect, stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
		
	public boolean insertHelp(Help insertHelp) {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtInsert = null;
		
		try {
			String sqlInsert = "INSERT INTO help (help_memo, member_id, updatedate, createdate) VALUES(?, ?, now(), now()) ";
			
			conn = dbUtil.getConnection();
			stmtInsert = conn.prepareStatement(sqlInsert);
			
			stmtInsert.setString(1, insertHelp.getHelpMemo());
			stmtInsert.setString(2, insertHelp.getMemberId());
			
			int row = stmtInsert.executeUpdate();
			
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
	
	public boolean updateHelp(Help updateHelp) {


		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		try {
			String sqlUpdate = "UPDATE help SET help_memo = ?, updatedate = now() WHERE help_no = ?";
			
			conn = dbUtil.getConnection();
			stmtUpdate = conn.prepareStatement(sqlUpdate);
			
			stmtUpdate.setString(1, updateHelp.getHelpMemo());
			stmtUpdate.setInt(2, updateHelp.getHelpNo());
			
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
	
	public boolean deleteHelp(Help deleteHelp) {

		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtDelete = null;
		
		try {
			String sqlDelete = "DELETE FROM help WHERE help_no = ?";
			
			conn = dbUtil.getConnection();
			stmtDelete = conn.prepareStatement(sqlDelete);
			
			stmtDelete.setInt(1, deleteHelp.getHelpNo());
			
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
