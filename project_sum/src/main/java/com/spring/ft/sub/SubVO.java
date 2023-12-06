package com.spring.ft.sub;

import java.sql.Date;

public class SubVO {

	private String memberId;
	private String subscribeId;
	private Date   sregdate;
	
	public SubVO() {}
	
	public SubVO(String memberId, String subscribeId, Date sregdate) {
		this.memberId = memberId;
		this.subscribeId = subscribeId;
		this.sregdate = sregdate;
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

	public Date getSregdate() {
		return sregdate;
	}

	public void setSregdate(Date sregdate) {
		this.sregdate = sregdate;
	}

	@Override
	public String toString() {
		return "SubVO [memberId=" + memberId + ", subscribeId=" + subscribeId + ", sregdate=" + sregdate + "]";
	}
	
}
