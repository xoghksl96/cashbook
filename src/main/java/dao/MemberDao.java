package dao;

import java.sql.*;
import java.util.ArrayList;

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
		String sqlLogin = "SELECT member_id, member_name, member_level FROM member WHERE member_id = ? && member_pw = PASSWORD(?)";
		
		PreparedStatement stmtLogin = conn.prepareStatement(sqlLogin);
		stmtLogin.setString(1, paramMember.getMemberId());
		stmtLogin.setString(2, paramMember.getMemberPw());
		
		ResultSet rsLogin = stmtLogin.executeQuery();
		if(rsLogin.next()) {
			// SELECT 한 값을 resultMember에 저장.
			resultMember = new Member();
			resultMember.setMemberId(rsLogin.getString("member_id"));
			resultMember.setMemberName(rsLogin.getString("member_name"));
			resultMember.setMemberLevel(Integer.parseInt(rsLogin.getString("member_level")));
		}
		
		dbUtil.close(rsLogin, stmtLogin, conn);
		return resultMember;
	}
	
	// memberId 중복 확인 메서드
	public Boolean memberIdCheck(String memberId) throws Exception {
		boolean result = false; 
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlSelect = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		stmtSelect.setString(1, memberId);
		
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		if(rsSelect.next()) {			
			result = true;		
		} 
		
		dbUtil.close(rsSelect, stmtSelect, conn);
		return result;
			
	}	
	
	// 회원가입 메서드
	public Boolean insertMember(Member paramMember) throws Exception {
		boolean result = false; 
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql을 이용하여 Insert
		String sqlInsert = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmtInsert = conn.prepareStatement(sqlInsert);
		stmtInsert.setString(1, (String)paramMember.getMemberId());
		stmtInsert.setString(2, (String)paramMember.getMemberPw());
		stmtInsert.setString(3, (String)paramMember.getMemberName());
		
		int row = stmtInsert.executeUpdate();
		
		if(row==1) {
			
			result = true;	
		}
		dbUtil.close(stmtInsert, conn);
		return result;
	}
	
	// 회원탈퇴 메서드
	public Boolean deleteMember(Member paramMember) throws Exception {
		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql을 이용하여 Delete
		String sqlDelete = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmtDelete = conn.prepareStatement(sqlDelete);
		stmtDelete.setString(1, paramMember.getMemberId());
		stmtDelete.setString(2, paramMember.getMemberPw());
		
		int row = stmtDelete.executeUpdate();
		
		if(row==1) {

			result = true;
		} 
		
		dbUtil.close(stmtDelete, conn);
		return result;		
	}
	
	// 회원정보 수정 메서드
	public Member updateMember(Member paramMember) throws Exception {
		Member resultMember = null;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql을 이용하여 Delete
		String sqlUpdate = "UPDATE member SET member_name = ?, updatedate = CURDATE() WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate);
		stmtUpdate.setString(1, paramMember.getMemberName());
		stmtUpdate.setString(2, paramMember.getMemberId());
		stmtUpdate.setString(3, paramMember.getMemberPw());
		
		int row = stmtUpdate.executeUpdate();
		
		if(row==1) {

			resultMember = paramMember;
		} 
		
		dbUtil.close(stmtUpdate, conn);
		
		return resultMember;	
	}
	
	// 회원정보 수정 메서드
	public Member updateMemberPw(Member paramMember, String newPw) throws Exception {
		Member resultMember = null;
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql을 이용하여 Delete
		String sqlUpdate = "UPDATE member SET member_pw = PASSWORD(?), updatedate = CURDATE() WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate);
		stmtUpdate.setString(1, newPw);
		stmtUpdate.setString(2, paramMember.getMemberId());
		stmtUpdate.setString(3, paramMember.getMemberPw());
		
		int row = stmtUpdate.executeUpdate();
		
		if(row == 1) {
			
			resultMember = new Member();
			resultMember.setMemberId(paramMember.getMemberId());
			resultMember.setMemberPw(newPw);
			
		} 
			
		dbUtil.close(stmtUpdate, conn);
		return resultMember;

	}
	
	// 입력한 두 비밀번호가 일치하는 지 확인하는 메서드
	public Boolean passwordCheck(String pw, String pwCheck) {
		boolean result = false;
		if(pw.equals(pwCheck)) {
			result = true;
		} 
		return result;
	}
	
	// 관리자 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Member> list = new ArrayList<Member>();
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate "
				+ "FROM member "
				+ "ORDER BY createdate DESC, member_no DESC "
				+ "LIMIT ?, ?";
		
		// 3. sql 세팅
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		stmtSelect.setInt(1, beginRow);
		stmtSelect.setInt(2, rowPerPage);
			
		// 4. sql 실행
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		// 5. list에 값 저장
		while(rsSelect.next()) {
			Member returnMember = new Member();
			returnMember.setMemberNo(rsSelect.getInt("memberNo"));
			returnMember.setMemberId(rsSelect.getString("memberId"));
			returnMember.setMemberLevel(rsSelect.getInt("memberLevel"));
			returnMember.setMemberName(rsSelect.getString("memberName"));
			returnMember.setUpdatedate(rsSelect.getString("updatedate"));
			returnMember.setCreatedate(rsSelect.getString("createdate"));
			
			list.add(returnMember);
		}
		
		dbUtil.close(rsSelect, stmtSelect, conn);
		return list;		
	}
	
	public ArrayList<Member> selectMemberListByPage() throws Exception {
		ArrayList<Member> list = new ArrayList<Member>();
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate "
				+ "FROM member "
				+ "ORDER BY createdate DESC, member_no DESC ";
		
		// 3. sql 세팅
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
			
		// 4. sql 실행
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		// 5. list에 값 저장
		while(rsSelect.next()) {
			Member returnMember = new Member();
			returnMember.setMemberNo(rsSelect.getInt("memberNo"));
			returnMember.setMemberId(rsSelect.getString("memberId"));
			returnMember.setMemberLevel(rsSelect.getInt("memberLevel"));
			returnMember.setMemberName(rsSelect.getString("memberName"));
			returnMember.setUpdatedate(rsSelect.getString("updatedate"));
			returnMember.setCreatedate(rsSelect.getString("createdate"));
			
			list.add(returnMember);
		}
		
		dbUtil.close(rsSelect, stmtSelect, conn);
		return list;		
	}
	
	// 관리자 멤버 count
	public int selectMemberCount() throws Exception {
		int result = 0;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlSelect = "SELECT COUNT(member_no) FROM member";
		
		// 3. sql 세팅
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		// 4. sql 실행
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		// 5. 값을 반환
		if(rsSelect.next()) {
			result = rsSelect.getInt("COUNT(member_no)");
		}
		dbUtil.close(stmtSelect, conn);
		return result;
	}
	
	
	// 관리자 멤버 강퇴
	public boolean deleteMemberMyAdmin(Member member) throws Exception {
		boolean result = false;
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlDelete = "DELETE FROM member WHERE member_id = ?";
		
		// 3. sql 세팅
		PreparedStatement stmtDelete = conn.prepareStatement(sqlDelete);
		stmtDelete.setString(1, member.getMemberId());
		
		// 4. sql 실행
		int row = stmtDelete.executeUpdate();
		if(row==1) {
			result = true;
		}
		
		dbUtil.close(stmtDelete, conn);
		return result;
	}
	
	
	// 관리장 멤버 레벨수정
	public boolean updateMemberLevel(Member member) throws Exception {
		boolean result = false;
		int changeLevel = 1;
		
		if(member.getMemberLevel() == 1) { // 기존 member.leber == 0 -> 1로 전환
			changeLevel = 0;
		}
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. sql 작성
		String sqlUpdateMemberLevel = "UPDATE member SET member_level = ?, updatedate = CURRENTDATE() WHERE member_id = ?";
		
		// 3. sql 세팅
		PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdateMemberLevel);
		stmtUpdate.setInt(1, changeLevel);
		stmtUpdate.setString(2, member.getMemberId());
		
		// 4. sql 실행
		int row = stmtUpdate.executeUpdate();
		if(row == 1) {
			result = true;
		}
		
		dbUtil.close(stmtUpdate, conn);
		return result;
	}
}
