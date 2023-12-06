package com.spring.ft.likes;

public class LikesVO {

	String memberId;
	int videoIdx;
	int likes;
	
	public LikesVO() {
		System.out.println("LikesVO 객체 생성~~");
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getVideoIdx() {
		return videoIdx;
	}

	public void setVideoIdx(int videoIdx) {
		this.videoIdx = videoIdx;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	@Override
	public String toString() {
		return "LikesVO [memberId=" + memberId + ", videoIdx=" + videoIdx + ", likes=" + likes + "]";
	}
	
	
}
