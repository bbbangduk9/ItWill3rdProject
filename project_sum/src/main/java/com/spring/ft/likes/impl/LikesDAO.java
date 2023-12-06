package com.spring.ft.likes.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.ft.likes.LikesVO;

@Repository
public class LikesDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void addLikes(LikesVO vo) {
		System.out.println("===> mybatis JDBC로 addLikes() 실행");
		mybatis.insert("likesDAO.addLikes", vo);
	}

	public int checkLikesStatusOfMember(LikesVO vo) {
		System.out.println("===> mybatis JDBC로 checkLikesStatusOfMember() 실행");
		return mybatis.selectOne("likesDAO.checkLikesStatusOfMember", vo);
	}
	
	public void updateLikesStatusOfMember(LikesVO vo) {
		System.out.println("===> mybatis JDBC로 updateLikesStatusOfMember() 실행");
		mybatis.update("likesDAO.updateLikesStatusOfMember", vo);
	}
	
	public int checkNumberOfLikesOnVideo(int videoIdx) {
		System.out.println("===> mybatis JDBC로 checkNumberOfLikesOnVideo 실행");	
		return mybatis.selectOne("likesDAO.checkNumberOfLikesOnVideo", videoIdx);
	}
	
}
