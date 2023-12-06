package com.spring.ft.video;

import java.util.Date;

public class VideoMembersVO {
	//video
	private String memberId;
	private int videoIdx;
	private String vtitle;
	private String genre;
	private String vimage;
	private String video;
	private String description;
	private Date vregdate;
	private String views;
	//members
	private String title;
	private String image;
	
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
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getVimage() {
		return vimage;
	}
	public void setVimage(String vimage) {
		this.vimage = vimage;
	}
	public String getVideo() {
		return video;
	}
	public void setVideo(String video) {
		this.video = video;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getVregdate() {
		return vregdate;
	}
	public void setVregdate(Date vregdate) {
		this.vregdate = vregdate;
	}
	public String getViews() {
		return views;
	}
	public void setViews(String views) {
		this.views = views;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	@Override
	public String toString() {
		return "VideoMembersVO [memberId=" + memberId + ", videoIdx=" + videoIdx + ", vtitle=" + vtitle + ", genre="
				+ genre + ", vimage=" + vimage + ", video=" + video + ", description=" + description + ", vregdate="
				+ vregdate + ", views=" + views + ", title=" + title + ", image=" + image + "]";
	}
}
