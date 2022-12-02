package dao;

import java.sql.*;
import java.util.ArrayList;

import util.*;
import vo.*;

public class MemberDao {
	
	// 로그인 메서드
	public Member login(Member paramMember) {
		Member resultMember = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtLogin = null;
		ResultSet rsLogin = null;
		
		try {
			String sqlLogin = "SELECT member_id, member_name, member_level FROM member WHERE member_id = ? && member_pw = PASSWORD(?)";
			
			conn = dbUtil.getConnection();
			stmtLogin = conn.prepareStatement(sqlLogin);
			
			stmtLogin.setString(1, paramMember.getMemberId());
			stmtLogin.setString(2, paramMember.getMemberPw());
			
			rsLogin = stmtLogin.executeQuery();
			if(rsLogin.next()) {
				resultMember = new Member();
				resultMember.setMemberId(rsLogin.getString("member_id"));
				resultMember.setMemberName(rsLogin.getString("member_name"));
				resultMember.setMemberLevel(Integer.parseInt(rsLogin.getString("member_level")));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsLogin, stmtLogin, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		
		return resultMember;
	}
	
	// memberId 중복 확인 메서드
	public Boolean memberIdCheck(String memberId) {
		boolean result = false; 
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT member_id FROM member WHERE member_id = ?";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			
			stmtSelect.setString(1, memberId);
			
			rsSelect = stmtSelect.executeQuery();
			
			if(rsSelect.next()) {			
				result = true;		
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

		return result;			
	}	
	
	// 회원가입 메서드
	public Boolean insertMember(Member paramMember) {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtInsert = null;
		
		try {
			String sqlInsert = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE())";
			
			conn = dbUtil.getConnection();
			stmtInsert = conn.prepareStatement(sqlInsert);
			
			
			stmtInsert.setString(1, (String)paramMember.getMemberId());
			stmtInsert.setString(2, (String)paramMember.getMemberPw());
			stmtInsert.setString(3, (String)paramMember.getMemberName());
			
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
	
	// 회원탈퇴 메서드
	public Boolean deleteMember(Member paramMember) {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtDelete = null;

		try {
			String sqlDelete = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";

			conn = dbUtil.getConnection();
			stmtDelete = conn.prepareStatement(sqlDelete);
			
			stmtDelete.setString(1, paramMember.getMemberId());
			stmtDelete.setString(2, paramMember.getMemberPw());
			
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
	
	// 회원정보 수정 메서드
	public Member updateMember(Member paramMember) {
		Member resultMember = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		try {
			String sqlUpdate = "UPDATE member SET member_name = ?, updatedate = CURDATE() WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			conn = dbUtil.getConnection();
			stmtUpdate = conn.prepareStatement(sqlUpdate);
			
			stmtUpdate.setString(1, paramMember.getMemberName());
			stmtUpdate.setString(2, paramMember.getMemberId());
			stmtUpdate.setString(3, paramMember.getMemberPw());
			
			int row = stmtUpdate.executeUpdate();
			
			if(row==1) {

				resultMember = paramMember;
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
		
		return resultMember;	
	}
	
	// 회원정보 수정 메서드
	public Member updateMemberPw(Member paramMember, String newPw) {
		Member resultMember = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		try {
			String sqlUpdate = "UPDATE member SET member_pw = PASSWORD(?), updatedate = CURDATE() WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			conn = dbUtil.getConnection();
			stmtUpdate = conn.prepareStatement(sqlUpdate);
			
			stmtUpdate.setString(1, newPw);
			stmtUpdate.setString(2, paramMember.getMemberId());
			stmtUpdate.setString(3, paramMember.getMemberPw());
			
			int row = stmtUpdate.executeUpdate();
			
			if(row==1) {

				resultMember = paramMember;
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
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		ArrayList<Member> list = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate "
					+ "FROM member "
					+ "ORDER BY createdate DESC, member_no DESC "
					+ "LIMIT ?, ?";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			
			stmtSelect.setInt(1, beginRow);
			stmtSelect.setInt(2, rowPerPage);
				
			// 4. sql 실행
			rsSelect = stmtSelect.executeQuery();
			
			list = new ArrayList<Member>();
			
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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect, stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;		
	}
	
	public ArrayList<Member> selectMemberListByPage() {
		ArrayList<Member> list = null;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate "
					+ "FROM member "
					+ "ORDER BY createdate DESC, member_no DESC ";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			rsSelect = stmtSelect.executeQuery();
			
			list = new ArrayList<Member>();

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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rsSelect, stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;		
	}
	
	// 관리자 멤버 count
	public int selectMemberCount() {
		int result = 0;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtSelect = null;
		ResultSet rsSelect = null;
		
		try {
			String sqlSelect = "SELECT COUNT(member_no) FROM member";
			
			conn = dbUtil.getConnection();
			stmtSelect = conn.prepareStatement(sqlSelect);
			rsSelect = stmtSelect.executeQuery();
			
			// 5. 값을 반환
			if(rsSelect.next()) {
				result = rsSelect.getInt("COUNT(member_no)");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(stmtSelect, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	
	// 관리자 멤버 강퇴
	public boolean deleteMemberMyAdmin(Member member) {		
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtDelete = null;

		try {
			String sqlDelete = "DELETE FROM member WHERE member_id = ?";

			conn = dbUtil.getConnection();
			stmtDelete = conn.prepareStatement(sqlDelete);
			
			stmtDelete.setString(1, member.getMemberId());
			
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
	
	
	// 관리장 멤버 레벨수정
	public boolean updateMemberLevel(Member member) {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmtUpdate = null;
		
		try {
			int changeLevel = 1;
			
			if(member.getMemberLevel() == 1) { // 기존 member.level == 0 -> 1로 전환
				changeLevel = 0;
			}
			
			String sqlUpdateMemberLevel = "UPDATE member SET member_level = ?, updatedate = CURDATE() WHERE member_id = ?";
			
			conn = dbUtil.getConnection();
			stmtUpdate = conn.prepareStatement(sqlUpdateMemberLevel);
			stmtUpdate.setInt(1, changeLevel);
			stmtUpdate.setString(2, member.getMemberId());
			
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
}
