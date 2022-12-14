package dao;

import vo.*;
import java.sql.*;
import java.util.*;
import util.*;

public class CashDao {
	public ArrayList<HashMap<String, Object>> slectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			// 1. DB 연결
			conn = dbUtil.getConnection();
			
			String sqlSelect = "SELECT c.cash_no cashNo, "
					+ "c.cash_date cashDate, "
					+ "c.cash_price cashPrice, "
					+ "c.category_no categoryNo, "
					+ "ct.category_kind categoryKind, "
					+ "ct.category_name categoryName "
					+ "FROM cash c INNER JOIN category ct "
					+ "ON c.category_no = ct.category_no "
					+ "WHERE c.member_id = ? "
					+ "AND YEAR(c.cash_date) = ? "
					+ "AND MONTH(c.cash_date) = ? "
					+ "ORDER BY c.cash_date ASC, ct.category_kind ASC";
			
			stmtSelect = conn.prepareStatement(sqlSelect);
			stmtSelect.setString(1, memberId);
			stmtSelect.setInt(2,year);
			stmtSelect.setInt(3,month);
			
			rsSelect = stmtSelect.executeQuery();
			

			while(rsSelect.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				
				// 해당 월의 cash 정보 HashMap에 저장
				m.put("cashNo", rsSelect.getInt("cashNo"));
				m.put("cashDate", rsSelect.getString("cashDate"));
				m.put("cashPrice", rsSelect.getLong("cashPrice"));
				m.put("categoryNo", rsSelect.getInt("categoryNo"));
				m.put("categoryKind", rsSelect.getString("categoryKind"));
				m.put("categoryName", rsSelect.getString("categoryName"));
				
				// 리스트에 넣음
				resultList.add(m);
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
	
	public ArrayList<HashMap<String, Object>> slectCashListByDate(String memberId, int year, int month, int date) {
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			// 1. DB 연결
			conn = dbUtil.getConnection();
			
			String sqlSelect = "SELECT c.cash_no cashNo, "
					+ "c.cash_date cashDate, "
					+ "c.cash_price cashPrice, "
					+ "c.category_no categoryNo, "
					+ "ct.category_kind categoryKind, "
					+ "ct.category_name categoryName, "
					+ "c.cash_memo cashMemo "
					+ "FROM cash c INNER JOIN category ct "
					+ "ON c.category_no = ct.category_no "
					+ "WHERE c.member_id = ? AND YEAR(c.cash_date) = ? "
					+ "AND MONTH(c.cash_date) = ? "
					+ "AND DAY(c.cash_date) = ? "
					+ "ORDER BY c.cash_date ASC, ct.category_kind ASC";
			
			stmtSelect = conn.prepareStatement(sqlSelect);
			stmtSelect.setString(1, memberId);
			stmtSelect.setInt(2,year);
			stmtSelect.setInt(3,month);
			stmtSelect.setInt(4,date);
			
			rsSelect = stmtSelect.executeQuery();
			
			while(rsSelect.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				
				// 해당 월의 cash 정보 HashMap에 저장
				m.put("cashNo", rsSelect.getInt("cashNo"));
				m.put("cashDate", rsSelect.getString("cashDate"));
				m.put("cashPrice", rsSelect.getLong("cashPrice"));
				m.put("categoryNo", rsSelect.getInt("categoryNo"));
				m.put("categoryKind", rsSelect.getString("categoryKind"));
				m.put("categoryName", rsSelect.getString("categoryName"));
				m.put("cashMemo", rsSelect.getString("cashMemo"));
				
				// 리스트에 넣음
				resultList.add(m);
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
	
	public Boolean insertCash(Cash cash) {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtInsert = null;
		
		try {
			
			// 2. sql 작성
			String sqlInsert = "INSERT INTO cash (category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) "
					+ "VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
			
			// 3. sql 세팅
			conn = dbUtil.getConnection();
			stmtInsert = conn.prepareStatement(sqlInsert);
			
			stmtInsert.setInt(1, cash.getCategoryNo());
			stmtInsert.setString(2, cash.getMemberId());
			stmtInsert.setString(3, cash.getCashDate());
			stmtInsert.setLong(4, cash.getCashPrice());
			stmtInsert.setString(5, cash.getCashMemo());
			
			// 4. sql 실행, 결과에 따라 True false 반환
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
	
	public Cash selectCashOne(String memberId, int cashNo) throws Exception {
		Cash resultCash = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		
		// 1. DB 연결
		conn = dbUtil.getConnection();
		
		String sqlSelect = "SELECT category_no categoryNo, "
				+ "cash_price cashPrice, "
				+ "cash_memo cashMemo, "
				+ "cash_date cashDate "
				+ "FROM cash "
				+ "WHERE member_id = ? AND cash_no = ?";
		
		stmtSelect = conn.prepareStatement(sqlSelect);
		
		stmtSelect.setString(1, memberId);
		stmtSelect.setInt(2,cashNo);
		
		rsSelect = stmtSelect.executeQuery();
		
		resultCash = new Cash();
		if(rsSelect.next()) {
			
			resultCash = new Cash();
			
			resultCash.setMemberId(memberId);
			resultCash.setCashNo(cashNo);
			resultCash.setCategoryNo(rsSelect.getInt("categoryNo"));
			resultCash.setCashPrice(rsSelect.getLong("cashPrice"));
			resultCash.setCashMemo(rsSelect.getString("cashMemo"));	
			resultCash.setCashDate(rsSelect.getString("cashDate"));
		}
		
		dbUtil.close(rsSelect, stmtSelect, conn);
		return resultCash;	
	}
	
	public Boolean updateCash(Cash cash) throws Exception {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		try {
			// 1. DB 연결
			conn = dbUtil.getConnection();
			
			// 2. sql 작성
			String sqlUpdate = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo = ? WHERE member_id = ? AND cash_no = ?";
			
			// 3. sql 세팅
			stmtUpdate = conn.prepareStatement(sqlUpdate);
			stmtUpdate.setInt(1, cash.getCategoryNo());
			stmtUpdate.setLong(2,cash.getCashPrice());
			stmtUpdate.setString(3,cash.getCashMemo());
			stmtUpdate.setString(4,cash.getMemberId());
			stmtUpdate.setInt(5,cash.getCashNo());
			
			// 4. sql 실행, 결과에 따라 True false 반환
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
	
	public Boolean deleteCash(Cash cash) throws Exception {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtDelete = null;
		
		try {
			/// 1. DB 연결
			conn = dbUtil.getConnection();
			
			// 2. sql 작성
			String sqlDelete = "DELETE FROM cash WHERE member_id = ? AND cash_no = ?";
			
			// 3. sql 세팅
			stmtDelete = conn.prepareStatement(sqlDelete);
			stmtDelete.setString(1, cash.getMemberId());
			stmtDelete.setInt(2,cash.getCashNo());
			
			// 4. sql 실행, 결과에 따라 True false 반환
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
}
