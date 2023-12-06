package com.spring.ft.comments;

import java.util.List;
import java.util.Map;

import com.spring.ft.video.VideoVO;

public interface CommentsService {
	// (내 채널) 채널 콘텐츠
	List<CommentsVO> getMyChannelCommentsList(Map<String, String> map);
	int getMyChannelCommentsCount(Map<String, String> map);
	int getMyCommentCount(Map<String, String> map);
	int getMyCommentCountOne(Map<String, String> map);
	
	// 댓글
	List<CommentsVO> viewComments(VideoVO vo);
	void insertComments(CommentsVO vo);
	void deleteComments(CommentsVO vo);
	void updateComment(CommentsVO vo);
	CommentsVO upSelectComment(CommentsVO vo);
}
