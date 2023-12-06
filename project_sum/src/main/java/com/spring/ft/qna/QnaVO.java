package com.spring.ft.qna;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value =  { "searchCondition", "searchKeyword", "uploadFile" })
public class QnaVO {
	private int seq;
	private String qtitle;
	private String memberId;
	private String content;
	private String secret;
	private Date qregdate;
	private int cnt;
	
	//검색조건 처리용
	//@JsonIgnore // JSON 데이터 변경에서 제외하겠다
	private String searchCondition;
	private String searchKeyword;
	
	//파일 업로드
	//@JsonIgnore
	private MultipartFile uploadFile;
	
	public QnaVO() {
		System.out.println(">> QnaVO() 객체생성");
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	public String getQtitle() {
		return qtitle;
	}

	public void setQtitle(String qtitle) {
		this.qtitle = qtitle;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public Date getQregdate() {
		return qregdate;
	}
	
	public void setQregdate(Date qregdate) {
		this.qregdate = qregdate;
	}

	public int getCnt() {
		return cnt;
	}


	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
		
	@Override
	public String toString() {
		return "QnaVO [seq=" + seq + ", qtitle=" + qtitle + ", memberId=" + memberId + ", content=" + content
				+ ", secret=" + secret + ", qregdate=" + qregdate + ", cnt=" + cnt + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword + ", uploadFile=" + uploadFile + "]";
	}

	//파일업로드 ------
	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	//검색조건 처리용----------------
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	
}





