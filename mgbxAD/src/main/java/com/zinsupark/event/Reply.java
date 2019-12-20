package com.zinsupark.event;

public class Reply {
	private int rcode; // 댓글 코드
	private int answer; // 대댓글 코드
	private int ecode; // 이벤트 코드
	private String content; // 내용
	private String created; // 생성일
	private String userId; // 유저 아이디
	
	
	public int getRcode() {
		return rcode;
	}
	public void setRcode(int rcode) {
		this.rcode = rcode;
	}
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	public int getEcode() {
		return ecode;
	}
	public void setEcode(int ecode) {
		this.ecode = ecode;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	

}
