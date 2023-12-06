package com.spring.ft.members;

import java.util.List;

public interface MembersService {

	// 멤버 하나 가져옴
	MembersVO getMem(String memberId);
//	
//	int updateLogdate(MembersVO vo);
//	
	// -----------------------------------------
	// 회원
	MembersVO getMembers(MembersVO vo);
	void updateLog(MembersVO vo);
	void updateMembers(MembersVO vo);
	List<MembersVO> checkGetUser(MembersVO vo);
	String getID(String finalEmail);
	MembersVO getPwd(MembersVO vo);
	void changePwd(MembersVO vo);
	void userTimeDelete();
	void memberRegist(MembersVO vo);
	int duplicationCheck(String memberId);
	int duplicationEmailCheck(String email);
	List<MembersVO> membersListMaster(String searchID);
	void statusUpdate(MembersVO vo);
	List<MembersVO> titleSearch(String searchTitle);
	List<SubscribeVO> subscribeSelect(String memberId);
	void subscribeIn (SubscribeVO svo);
	void subscribeDel (SubscribeVO svo);
	MembersVO titleList(String subscribeId);
	
	
}
