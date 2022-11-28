package dao;

import java.sql.Connection;
import java.util.*;
import java.sql.*;

import util.DBUtil;
import vo.*;


public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception {
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		// 3. sql 실행 및 반환값 list에 추가
		ArrayList<Category> list = new ArrayList<Category>();
		
		while(rsSelect.next())
		{
			Category category = new Category();
			category.setCategoryNo(rsSelect.getInt("categoryNo"));
			category.setCategoryKind(rsSelect.getString("categoryKind"));
			category.setCategoryName(rsSelect.getString("categoryName"));
			
			list.add(category);
		}
		
		dbUtil.close(rsSelect, stmtSelect, conn);
		return list;
			
	}
	
	public ArrayList<Category> selectCategoryListByadmin() throws Exception {
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		// 3. sql 실행 및 반환값 list에 추가
		ArrayList<Category> list = new ArrayList<Category>();
		
		while(rsSelect.next())
		{
			Category category = new Category();
			category.setCategoryNo(rsSelect.getInt("categoryNo"));
			category.setCategoryKind(rsSelect.getString("categoryKind"));
			category.setCategoryName(rsSelect.getString("categoryName"));
			category.setUpdatedate(rsSelect.getString("updatedate"));
			category.setCreatedate(rsSelect.getString("createdate"));
			
			list.add(category);
		}
		
		dbUtil.close(rsSelect, stmtSelect, conn);
		return list;
	}
	
	public Category selectCategoryOneByadmin(Category selectCategory) throws Exception {
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category WHERE category_no = ?";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		stmtSelect.setInt(1, selectCategory.getCategoryNo());
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		
		Category resultcategory = null;
		if(rsSelect.next())
		{
			resultcategory = new Category();
			resultcategory.setCategoryNo(rsSelect.getInt("categoryNo"));
			resultcategory.setCategoryKind(rsSelect.getString("categoryKind"));
			resultcategory.setCategoryName(rsSelect.getString("categoryName"));
		}
		
		dbUtil.close(rsSelect, stmtSelect, conn);
		return resultcategory;
	}
	
	public boolean insertCategory(Category insertCategory) throws Exception {
		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlInsert = "INSERT INTO category (category_kind, category_name, updatedate, createdate) VALUES(?, ?, now(), now()) ";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtInsert = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtInsert = conn.prepareStatement(sqlInsert);
		
		// 5. sql세팅
		stmtInsert.setString(1, insertCategory.getCategoryKind());
		stmtInsert.setString(2, insertCategory.getCategoryName());
		
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
	
	public boolean updateCateogory(Category updateCategory) throws Exception {
		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlUpdate = "UPDATE category SET category_kind = ?, category_name = ?, updatedate = now() WHERE category_no = ?";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtUpdate = conn.prepareStatement(sqlUpdate);
		
		// 5. sql세팅
		stmtUpdate.setString(1, updateCategory.getCategoryKind());
		stmtUpdate.setString(2, updateCategory.getCategoryName());
		stmtUpdate.setInt(3, updateCategory.getCategoryNo());
		
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
	
	public boolean deleteCategory(Category deleteCategory) throws Exception {
		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		// 2. sql 작성
		String sqlDelete = "DELETE FROM category WHERE category_no = ?";
		
		// 3. DB자원 초기화
		Connection conn = null;
		PreparedStatement stmtDelete = null;
		
		// 4.
		conn = dbUtil.getConnection();
		stmtDelete = conn.prepareStatement(sqlDelete);
		
		// 5. sql세팅
		stmtDelete.setInt(1, deleteCategory.getCategoryNo());
		
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
