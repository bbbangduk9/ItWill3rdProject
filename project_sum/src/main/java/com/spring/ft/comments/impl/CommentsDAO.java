package com.spring.ft.comments.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.ft.comments.CommentsVO;
import com.spring.ft.video.VideoVO;

@Repository
public class CommentsDAO {

	private SqlSessionTemplate mybatis;
	
	public CommentsDAO() {}
	
	@Autowired
	public CommentsDAO(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}

	// (내 채널) 채널 콘텐츠
	public int getMyChannelCommentsCount(Map<String, String> map) {
		return mybatis.selectOne("commentsDAO.getMyChannelCommentsCount", map);
	}
	public List<CommentsVO> getMyChannelCommentsList(Map<String, String> map) {
		return mybatis.selectList("commentsDAO.getMyChannelCommentsList", map);
	}
	public int getMyCommentCount(Map<String, String> map) {
		return mybatis.selectOne("commentsDAO.getMyCommentCount", map);
	}
	public int getMyCommentCountOne(Map<String, String> map) {
		return mybatis.selectOne("commentsDAO.getMyCommentCountOne", map);
	}
	// -----------------------------------------------------------------------
	
	// 댓글
	public List<CommentsVO> viewComments(VideoVO vo) {
		System.out.println(">>CommnetsDAO viewComments(CommentsVO vo) 실행");
		return mybatis.selectList("commentsDAO.viewComments", vo);
	}
	public CommentsVO commentFrame(VideoVO vo) {
		System.out.println(">> CommentsDAO insertComments(VideoVO vo) 실행");
		return mybatis.selectOne("commentsDAO.commentBorn", vo);
	}
	public void insertComments(CommentsVO vo) {
		System.out.println(">> CommentsDAO insertComments(VideoVO vo) 실행");
		mybatis.insert("commentsDAO.insertComments", vo);
	}
	public void deleteCommetns(CommentsVO vo) {
		System.out.println(">> CommentsDAO deleteCommetns(CommentsVO vo) 실행");
		mybatis.delete("commentsDAO.deleteComments", vo);
	}
	public void updateComment(CommentsVO vo) {
		System.out.println(">> CommentsDAO updateComment(CommentsVO vo) 실행");
		mybatis.update("commentsDAO.updateComment", vo);
	}
	public CommentsVO upSelectComment(CommentsVO vo) {
		System.out.println("CommentsDAO upSelectComment(CommentsVO vo)");
		return mybatis.selectOne("commentsDAO.selectComment", vo);
	}
	
}
