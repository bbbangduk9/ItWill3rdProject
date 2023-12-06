package com.spring.ft.members;

import java.sql.Date;

public class SubscribeVO {
	private String memberId;
	private String subscribeId;
	private Date sregDate;
	
	public SubscribeVO() {
		System.out.println("SubscribeVO() 객체 생성");
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getSubscribeId() {
		return subscribeId;
	}

	public void setSubscribeId(String subscribeId) {
		this.subscribeId = subscribeId;
	}

	public Date getSregDate() {
		return sregDate;
	}

	public void setSregDate(Date sregDate) {
		this.sregDate = sregDate;
	}

	@Override
	public String toString() {
		return "SubscribeVO [memberId=" + memberId + ", subscribeId=" + subscribeId + ", sregDate=" + sregDate + "]";
	}
	
	
}
