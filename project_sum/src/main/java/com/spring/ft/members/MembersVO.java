package com.spring.ft.members;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = "uploadfile")
public class MembersVO {

	private String memberId;
	private String name;
	private String title; // 채널명
	private Date regDate;
	private String pwd;
	private String image;
	private String email;
	private int status;
	private String logDate;
	private MultipartFile imageFile;
	private String birth;

	public String getBirth() {
		return birth;
	}

			public void setBirth(String birth) {
				this.birth = birth;
			}
			
			public MultipartFile getImageFile() {
			   return imageFile;
		   }
			
			public void setImageFile(MultipartFile imageFile) {
				this.imageFile = imageFile;
			}
			
			public MembersVO() {
				System.out.println("MembersVO객체 생성");
			}
		   
		   public String getMemberId() {
		      return memberId;
		   }
		   public void setMemberId(String memberId) {
		      this.memberId = memberId;
		   }
		   public String getName() {
		      return name;
		   }
		   public void setName(String name) {
		      this.name = name;
		   }
		   public String getTitle() {
		      return title;
		   }
		   public void setTitle(String title) {
		      this.title = title;
		   }
		   public Date getRegDate() {
		      return regDate;
		   }
		   public void setRegDate(Date regDate) {
		      this.regDate = regDate;
		   }
		   public String getPwd() {
		      return pwd;
		   }
		   public void setPwd(String pwd) {
		      this.pwd = pwd;
		   }
		   public String getImage() {
		      return image;
		   }
		   public void setImage(String image) {
		      this.image = image;
		   }
		   public String getEmail() {
		      return email;
		   }
		   public void setEmail(String email) {
		      this.email = email;
		   }
		   public int getStatus() {
		      return status;
		   }
		   public void setStatus(int status) {
		      this.status = status;
		   }
		   @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
		   public String getLogDate() {
		      return logDate;
		   }
		   public void setLogDate(String logDate) {
		      this.logDate = logDate;
		   }
		   @Override
		public String toString() {
			return "MembersVO [memberId=" + memberId + ", name=" + name + ", title=" + title + ", regDate=" + regDate + ", pwd="
					+ pwd + ", image=" + image + ", email=" + email + ", status=" + status + ", logDate=" + logDate
					+ ", imageFile=" + imageFile + ", birth=" + birth + "]";
		}
		   
	
}
