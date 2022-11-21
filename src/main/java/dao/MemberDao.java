package dao;

import java.sql.*;

import util.*;
import vo.*;

public class MemberDao {
	
	// 로그인 메서드
	public Member login(Member paramMember) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. 반환할 Member 변수
		Member resultMember = null;
		
		// 3. sql을 이용하여 로그인
		String sqlLogin = "SELECT member_id, member_name FROM member WHERE member_id = ? && member_pw = PASSWORD(?)";
		
		PreparedStatement stmtLogin = conn.prepareStatement(sqlLogin);
		stmtLogin.setString(1, paramMember.getMemberId());
		stmtLogin.setString(2, paramMember.getMemberPw());
		
		ResultSet rsLogin = stmtLogin.executeQuery();
		if(rsLogin.next()) {
			// SELECT 한 값을 resultMember에 저장.
			resultMember = new Member();
			resultMember.setMemberId(rsLogin.getString("member_id"));
			resultMember.setMemberName(rsLogin.getString("member_name"));
			
			rsLogin.close();
			stmtLogin.close();
			conn.close();
			return resultMember;	
		}
		
		rsLogin.close();
		stmtLogin.close();
		conn.close();
		return null;
	}	
	
	// 회원가입 메서드
	public Boolean insertMember(Member paramMember) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql을 이용하여 Insert
		String sqlInsert = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE()";
		PreparedStatement stmtInsert = conn.prepareStatement(sqlInsert);
		stmtInsert.setString(1, paramMember.getMemberId());
		stmtInsert.setString(2, paramMember.getMemberPw());
		stmtInsert.setString(3, paramMember.getMemberName());
		
		int row = stmtInsert.executeUpdate();
		
		if(row==1) {
			System.out.println("회원가입 성공!!");
			stmtInsert.close();
			conn.close();
			return true;
		} else {
			System.out.println("회원가입 실패..");
			stmtInsert.close();
			conn.close();
			return false;
		}
	}
	
	// 회원탈퇴 메서드
	public Boolean deleteMember(Member paramMember) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql을 이용하여 Delete
		String sqlDelete = "DELETE FROM member WHERE memeber_id = ? memeber_pw = PASSWORD(?)";
		PreparedStatement stmtDelete = conn.prepareStatement(sqlDelete);
		stmtDelete.setString(1, paramMember.getMemberId());
		stmtDelete.setString(2, paramMember.getMemberPw());
		
		int row = stmtDelete.executeUpdate();
		
		if(row==1) {
			System.out.println("회원탈퇴 성공!!");
			stmtDelete.close();
			conn.close();
			return true;
		} else {
			System.out.println("회원탈퇴 실패..");
			stmtDelete.close();
			conn.close();
			return false;
		}		
	}
	
	// 회원정보 수정 메서드
	public Boolean updateMember(Member paramMember) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql을 이용하여 Delete
		String sqlUpdate = "UPDATE member SET (member_name = ?) WHERE memeber_id = ? memeber_pw = PASSWORD(?)";
		PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate);
		stmtUpdate.setString(1, paramMember.getMemberName());
		stmtUpdate.setString(2, paramMember.getMemberId());
		stmtUpdate.setString(3, paramMember.getMemberPw());
		
		int row = stmtUpdate.executeUpdate();
		
		if(row==1) {
			System.out.println("회원정보 수정 성공!!");
			stmtUpdate.close();
			conn.close();
			return true;
		} else {
			System.out.println("회원정보 수정 실패..");
			stmtUpdate.close();
			conn.close();
			return false;
		}		
	}
}
