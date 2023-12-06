package com.spring.ft.video;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class VideoVO {
	private String memberId;
	private int videoIdx;
	private String vtitle;
	private String genre;
	private String vimage;
	private String video;
	private String description;
	private Date vregdate;
	private int views;
	
	// (내 채널) 댓글 수, 좋아요 수 추가
	private int comments;
	private int likes;
	// ------------------------------
	
	 // MEMBERS 테이블 조인 데이터
    private String title;
    private String image;
    
    // COMMENTS 테이블 조인 데이터
    private Date cregdate;
//	private String comments;
	
	// LIKES 테이블 조인 데이터
//	private int likes;
	
	// SUB 테이블 조인 데이터
	private String subscribeid;
	private Date sregdate;
	
    private MultipartFile uploadFile;
	private MultipartFile addUploadFile;
	
	public VideoVO() {}
	
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

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getComments() {
		return comments;
	}

	public void setComments(int comments) {
		this.comments = comments;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
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

	public Date getCregdate() {
		return cregdate;
	}

	public void setCregdate(Date cregdate) {
		this.cregdate = cregdate;
	}

	public String getSubscribeid() {
		return subscribeid;
	}

	public void setSubscribeid(String subscribeid) {
		this.subscribeid = subscribeid;
	}

	public Date getSregdate() {
		return sregdate;
	}

	public void setSregdate(Date sregdate) {
		this.sregdate = sregdate;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public MultipartFile getAddUploadFile() {
		return addUploadFile;
	}

	public void setAddUploadFile(MultipartFile addUploadFile) {
		this.addUploadFile = addUploadFile;
	}

	@Override
	public String toString() {
		return "VideoVO [memberId=" + memberId + ", videoIdx=" + videoIdx + ", vtitle=" + vtitle + ", genre=" + genre
				+ ", vimage=" + vimage + ", video=" + video + ", description=" + description + ", vregdate=" + vregdate
				+ ", views=" + views + ", comments=" + comments + ", likes=" + likes + ", title=" + title + ", image="
				+ image + ", cregdate=" + cregdate + ", subscribeid=" + subscribeid + ", sregdate=" + sregdate
				+ ", uploadFile=" + uploadFile + ", addUploadFile=" + addUploadFile + "]";
	}
	
}
