package dao;

import java.util.*;

import util.DBUtil;

import java.sql.*;

public class StatsDao {
	public ArrayList<HashMap<String, Object>> selectCashListByYear(String memberId) {
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 1. DB 연결
			conn = dbUtil.getConnection();
			
			String sql = "SELECT YEAR(t2.cashDate) year\r\n"
					+ "					 	, COUNT(t2.importCash) countImportCash\r\n"
					+ "					 	, COUNT(t2.exportCash) countExportCash\r\n"
					+ "					 	, IFNULL(SUM(t2.importCash),0) sumImportCash\r\n"
					+ "					 	, IFNULL(SUM(t2.exportCash),0) sumExportCash\r\n"
					+ "					 	, IFNULL(ROUND(AVG(t2.importCash)),0) avgImportCash\r\n"
					+ "					 	, IFNULL(ROUND(AVG(t2.exportCash)),0) avgExportCash\r\n"
					+ "					 FROM \r\n"
					+ "					 	(SELECT \r\n"
					+ "					 	t.memberId\r\n"
					+ "					 		, t.cashNo\r\n"
					+ "					 		, t.cashDate\r\n"
					+ "					 		, IF(categoryKind = '수입', t.cashPrice, NULL) importCash\r\n"
					+ "					 		, IF(categoryKind = '지출', t.cashPrice, NULL) exportCash\r\n"
					+ "					 		FROM \r\n"
					+ "					 		(SELECT cs.cash_no cashNo\r\n"
					+ "					 			, cs.cash_date cashDate\r\n"
					+ "					 			, cs.cash_price cashPrice\r\n"
					+ "					 			, cs.member_id memberId\r\n"
					+ "					 			, cg.category_kind categoryKind\r\n"
					+ "					 		FROM cash cs\r\n"
					+ "					 			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2\r\n"
					+ "					 WHERE t2.memberId = ?\r\n"
					+ "					 GROUP BY YEAR(t2.cashDate)\r\n"
					+ "					 ORDER BY YEAR(t2.cashDate) DESC;";
			
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			
			rs = stmt.executeQuery();
			

			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				
				// 해당 월의 cash 정보 HashMap에 저장
				m.put("year", rs.getInt("year"));
				m.put("countImportCash", rs.getInt("countImportCash"));
				m.put("countExportCash", rs.getInt("countExportCash"));
				m.put("sumImportCash", rs.getInt("sumImportCash"));
				m.put("sumExportCash", rs.getInt("sumExportCash"));
				m.put("avgImportCash", rs.getInt("avgImportCash"));
				m.put("avgExportCash", rs.getInt("avgExportCash"));
				
				// 리스트에 넣음
				resultList.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return resultList;
		
	}
	
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year) {
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 1. DB 연결
			conn = dbUtil.getConnection();
			
			String sql = "SELECT YEAR(t2.cashDate) year, MONTH(t2.cashDate) month\r\n"
					+ "					 	, COUNT(t2.importCash) countImportCash\r\n"
					+ "					 	, COUNT(t2.exportCash) countExportCash\r\n"
					+ "					 	, IFNULL(SUM(t2.importCash),0) sumImportCash\r\n"
					+ "					 	, IFNULL(SUM(t2.exportCash),0) sumExportCash\r\n"
					+ "					 	, IFNULL(ROUND(AVG(t2.importCash)),0) avgImportCash\r\n"
					+ "					 	, IFNULL(ROUND(AVG(t2.exportCash)),0) avgExportCash\r\n"
					+ "					 FROM \r\n"
					+ "					 	(SELECT \r\n"
					+ "					 		memberId\r\n"
					+ "					 		, cashNo\r\n"
					+ "					 		, cashDate\r\n"
					+ "					 		, if(categoryKind = '수입', cashPrice, NULL) importCash\r\n"
					+ "					 		, if(categoryKind = '지출', cashPrice, NULL) exportCash\r\n"
					+ "					 	FROM \r\n"
					+ "					 		(SELECT cs.cash_no cashNo\r\n"
					+ "					 		, cs.cash_date cashDate\r\n"
					+ "					 		, cs.cash_price cashPrice\r\n"
					+ "					 		, cs.member_id memberId\r\n"
					+ "					 		, cg.category_kind categoryKind\r\n"
					+ "					 		FROM cash cs\r\n"
					+ "					 			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2\r\n"
					+ "					 WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?\r\n"
					+ "					 GROUP BY MONTH(t2.cashDate)\r\n"
					+ "					 ORDER BY MONTH(t2.cashDate) DESC;";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			
			rs = stmt.executeQuery();
			

			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				
				// 해당 월의 cash 정보 HashMap에 저장
				m.put("year", rs.getInt("year"));
				m.put("month", rs.getInt("month"));
				m.put("countImportCash", rs.getInt("countImportCash"));
				m.put("countExportCash", rs.getInt("countExportCash"));
				m.put("sumImportCash", rs.getInt("sumImportCash"));
				m.put("sumExportCash", rs.getInt("sumExportCash"));
				m.put("avgImportCash", rs.getInt("avgImportCash"));
				m.put("avgExportCash", rs.getInt("avgExportCash"));
				
				// 리스트에 넣음
				resultList.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return resultList;
		
	}
}
