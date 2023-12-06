package com.spring.ft.members.impl;

import java.time.LocalDate;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.ft.members.MembersVO;
import com.spring.ft.members.SubscribeVO;

@Repository
public class MembersDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public MembersDAO() {}
	
	public MembersDAO(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	public MembersVO getMem(String memberId) {
		return mybatis.selectOne("membersDAO.getMem", memberId);
	}
	
	public MembersVO getMembers(MembersVO vo) {
		return mybatis.selectOne("membersDAO.getUser", vo);
	}
	
	public MembersVO getUser(MembersVO vo) {
		return mybatis.selectOne("membersDAO.getUser", vo);
	}
	
	public void updateLog(MembersVO vo) {
		mybatis.update("membersDAO.updateLog", vo);
	}

	public void updateMembers(MembersVO vo) {
		mybatis.update("membersDAO.updateMembers", vo);
	}
	
	public List<MembersVO> checkGetUser(MembersVO vo) {
		return mybatis.selectList("membersDAO.checkGetUser",vo);
	}
	
	public String getID(String finalEmail) {
		return mybatis.selectOne("membersDAO.getID",finalEmail);
	}
	
	public MembersVO getPwd(MembersVO vo) {
		return mybatis.selectOne("membersDAO.getPwd",vo);
	}
	
	public void changePwd(MembersVO vo) {
		mybatis.update("membersDAO.changePwd",vo);
	}
	
	//===========
	
	//1년 미접속 계정 삭제
	public void userTimeDelete() {
			 // 오늘 날짜 기준으로 1년 전의 날짜 계산
            LocalDate today = LocalDate.now();
            LocalDate oneYearAgo = today.minusYears(1);

		mybatis.delete("membersDAO.membersTimeDelete", java.sql.Date.valueOf(oneYearAgo));
		System.out.println("members 최종 접속 확인 후 1년이상 미접속 삭제");
	}
	//회원 등록
	public void memberRegist(MembersVO vo) {
		mybatis.insert("membersDAO.memberRegist", vo);
		System.out.println("member 등록");
	}
	//id 중복 체크
	public int duplicationCheck(String memberId) {
		System.out.println("id 중복체크. memberId : " + memberId);
		return mybatis.selectOne("membersDAO.selectMemberOne", memberId);
	}
	//email 중복 체크
	public int duplicationEmailCheck(String email) {
		System.out.println("email 중복체크. email : " + email);
		return mybatis.selectOne("membersDAO.selectEmailOne", email);
	}
	//회원정보 리스트 확인-관리자용
	public List<MembersVO> selectMasterList(String searchID) {
		return mybatis.selectList("membersDAO.selectMasterList", searchID);
	}
	//회원 상태 수정-관리자
	public void statusUpdate(MembersVO vo) {
		mybatis.update("membersDAO.statusUpdate", vo);
	}
	//채널명 검색
	public List<MembersVO> titleSearch(String searchTitle) {
		return mybatis.selectList("membersDAO.titleSearch", searchTitle);
	}
	//구독한 사람 아이디 확인
	public List<SubscribeVO> subscribeSelect(String memberId) {
		return mybatis.selectList("membersDAO.subscribeSelect", memberId);
	}
	//구독등록
	public void subscribeIn(SubscribeVO svo) {
		mybatis.insert("membersDAO.subscribeIn", svo);
	}
	//구독삭제
	public void subscribeDel(SubscribeVO svo) {
		mybatis.insert("membersDAO.subscribeDel", svo);
	}
	public MembersVO titleList(String subscribeId) {
		return mybatis.selectOne("membersDAO.memberSelectOne", subscribeId);
	}
	
}
