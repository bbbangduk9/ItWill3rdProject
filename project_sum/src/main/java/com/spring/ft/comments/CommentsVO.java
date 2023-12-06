package com.spring.ft.comments;

import java.sql.Date;

public class CommentsVO {

	private int commentIdx;
	private Date cregdate;
	private String comments;
	private String memberId;
	private int videoIdx;
	
	// 추가 (내 채널)
	private String vtitle;
	private String image;
	private String vimage;

	public CommentsVO() {}

	public int getCommentIdx() {
		return commentIdx;
	}

	public void setCommentIdx(int commentIdx) {
		this.commentIdx = commentIdx;
	}

	public Date getCregdate() {
		return cregdate;
	}

	public void setCregdate(Date cregdate) {
		this.cregdate = cregdate;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
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

	public String getVtitle() {
		return vtitle;
	}

	public void setVtitle(String vtitle) {
		this.vtitle = vtitle;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getVimage() {
		return vimage;
	}

	public void setVimage(String vimage) {
		this.vimage = vimage;
	}

	@Override
	public String toString() {
		return "CommentsVO [commentIdx=" + commentIdx + ", cregdate=" + cregdate + ", comments=" + comments
				+ ", memberId=" + memberId + ", videoIdx=" + videoIdx + ", vtitle=" + vtitle + ", image=" + image
				+ ", vimage=" + vimage + "]";
	}
	
}
