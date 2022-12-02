package dao;

import java.util.*;
import java.sql.*;

import util.DBUtil;
import vo.*;


public class CategoryDao {
	public ArrayList<Category> selectCategoryList() {
		ArrayList<Category> resultList = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			conn = dbUtil.getConnection();
			
			String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category";
			stmtSelect = conn.prepareStatement(sqlSelect);
			rsSelect = stmtSelect.executeQuery();
			
			
			resultList = new ArrayList<Category>();
			
			while(rsSelect.next())
			{
				Category category = new Category();
				category.setCategoryNo(rsSelect.getInt("categoryNo"));
				category.setCategoryKind(rsSelect.getString("categoryKind"));
				category.setCategoryName(rsSelect.getString("categoryName"));
				
				resultList.add(category);
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
	
	public ArrayList<Category> selectCategoryListByadmin() {
		ArrayList<Category> resultList = null;;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			rsSelect = stmtSelect.executeQuery();
			
			resultList = new ArrayList<Category>();
			
			while(rsSelect.next())
			{
				Category category = new Category();
				category.setCategoryNo(rsSelect.getInt("categoryNo"));
				category.setCategoryKind(rsSelect.getString("categoryKind"));
				category.setCategoryName(rsSelect.getString("categoryName"));
				category.setUpdatedate(rsSelect.getString("updatedate"));
				category.setCreatedate(rsSelect.getString("createdate"));
				
				resultList.add(category);
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
	
	public Category selectCategoryOneByadmin(Category selectCategory) {
		Category resultcategory = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			// 2. sql 작성
			String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category WHERE category_no = ?";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			stmtSelect.setInt(1, selectCategory.getCategoryNo());
			
			rsSelect = stmtSelect.executeQuery();
			
			
			resultcategory = new Category();
			if(rsSelect.next())
			{
				resultcategory = new Category();
				resultcategory.setCategoryNo(rsSelect.getInt("categoryNo"));
				resultcategory.setCategoryKind(rsSelect.getString("categoryKind"));
				resultcategory.setCategoryName(rsSelect.getString("categoryName"));
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
		
		return resultcategory;
	}
	
	public boolean insertCategory(Category insertCategory) {
		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtInsert = null;
		

		try {
			String sqlInsert = "INSERT INTO category (category_kind, category_name, updatedate, createdate) VALUES(?, ?, now(), now()) ";
			
			conn = dbUtil.getConnection();
			stmtInsert = conn.prepareStatement(sqlInsert);
			
			stmtInsert.setString(1, insertCategory.getCategoryKind());
			stmtInsert.setString(2, insertCategory.getCategoryName());
			
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
	
	public boolean updateCateogory(Category updateCategory) {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		try {
			String sqlUpdate = "UPDATE category SET category_kind = ?, category_name = ?, updatedate = now() WHERE category_no = ?";
			
			conn = dbUtil.getConnection();
			stmtUpdate = conn.prepareStatement(sqlUpdate);
			
			stmtUpdate.setString(1, updateCategory.getCategoryKind());
			stmtUpdate.setString(2, updateCategory.getCategoryName());
			stmtUpdate.setInt(3, updateCategory.getCategoryNo());
			
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
	
	public boolean deleteCategory(Category deleteCategory) {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtDelete = null;
		
		try {
			String sqlDelete = "DELETE FROM category WHERE category_no = ?";
			
			conn = dbUtil.getConnection();
			stmtDelete = conn.prepareStatement(sqlDelete);
			
			stmtDelete.setInt(1, deleteCategory.getCategoryNo());
			
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
