package com.spring.ft.likes.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.ft.likes.LikesService;
import com.spring.ft.likes.LikesVO;

@Service("likesService")
public class LikesServiceImpl implements LikesService {
	
	@Autowired
	private LikesDAO likesDAO;
	
	@Override
	public void addLikes(LikesVO vo) {
		likesDAO.addLikes(vo);
	}

	@Override
	public int checkLikesStatusOfMember(LikesVO vo) {
		return likesDAO.checkLikesStatusOfMember(vo);
	}

	@Override
	public void updateLikesStatusOfMember(LikesVO vo) {
		likesDAO.updateLikesStatusOfMember(vo);
	}
	
	@Override
	public int checkNumberOfLikesOnVideo(int videoIdx) {
		return likesDAO.checkNumberOfLikesOnVideo(videoIdx);
	}

}
