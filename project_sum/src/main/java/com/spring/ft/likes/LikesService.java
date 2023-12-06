package com.spring.ft.likes;

public interface LikesService {

	void addLikes(LikesVO vo);
	void updateLikesStatusOfMember(LikesVO vo);
	int checkLikesStatusOfMember(LikesVO vo);
	int checkNumberOfLikesOnVideo(int videoIdx);
}
