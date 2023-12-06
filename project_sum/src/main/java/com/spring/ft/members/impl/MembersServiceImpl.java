package com.spring.ft.members.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.ft.members.MembersService;
import com.spring.ft.members.MembersVO;
import com.spring.ft.members.SubscribeVO;

@Service("membersService")
public class MembersServiceImpl implements MembersService {

	private MembersDAO membersDAO;

	public MembersServiceImpl() {}
	
	@Autowired
	public MembersServiceImpl(MembersDAO membersDAO) {
		this.membersDAO = membersDAO;
	}
	
	@Override
	public MembersVO getMem(String memberId) {
		return membersDAO.getMem(memberId);
	}

	@Override
	public MembersVO getMembers(MembersVO vo) {
		return membersDAO.getMembers(vo);
	}

	@Override
	public void updateLog(MembersVO vo) {
		membersDAO.updateLog(vo);
	}

	@Override
	public void updateMembers(MembersVO vo) {
		membersDAO.updateMembers(vo);
	}

	@Override
	public List<MembersVO> checkGetUser(MembersVO vo) {
		return membersDAO.checkGetUser(vo);
	}

	@Override
	public String getID(String finalEmail) {
		return membersDAO.getID(finalEmail);
	}

	@Override
	public MembersVO getPwd(MembersVO vo) {
		return membersDAO.getPwd(vo);
	}
	
	@Override
	public void changePwd(MembersVO vo) {
		membersDAO.changePwd(vo);
	}
	
	//===============
	@Override
	public void userTimeDelete() {
		membersDAO.userTimeDelete();
	}

	@Override
	public void memberRegist(MembersVO vo) {
		membersDAO.memberRegist(vo);
	}

	@Override
	public int duplicationCheck(String memberId) {
		return membersDAO.duplicationCheck(memberId);
	}
	
	@Override
	public int duplicationEmailCheck(String email) {
		return membersDAO.duplicationEmailCheck(email);
	}

	@Override
	public List<MembersVO> membersListMaster(String searchID) {
		return membersDAO.selectMasterList(searchID);
	}

	@Override
	public void statusUpdate(MembersVO vo) {
		membersDAO.statusUpdate(vo);
		
	}

	@Override
	public List<MembersVO> titleSearch(String searchTitle) {
		return membersDAO.titleSearch(searchTitle);
	}

	@Override
	public List<SubscribeVO> subscribeSelect(String memberId) {
		return membersDAO.subscribeSelect(memberId);
	}

	@Override
	public void subscribeIn(SubscribeVO svo) {
		membersDAO.subscribeIn(svo);
	}

	@Override
	public void subscribeDel(SubscribeVO svo) {
		membersDAO.subscribeDel(svo);
	}

	@Override
	public MembersVO titleList(String subscribeId) {
		return membersDAO.titleList(subscribeId);
	}

	
}
