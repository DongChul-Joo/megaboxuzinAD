package com.zinsupark.event;

public class Reply {
	public int rcode; // 댓글 코드
	public int ecode; // 이벤트 코드
	public String content; // 내용
	public String created; // 생성일
	public String userId; // 유저 아이디
	public int like_Hate; // 좋아요 싫어요 분류 코드
	
	public int getRcode() {
		return rcode;
	}
	public void setRcode(int rcode) {
		this.rcode = rcode;
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
	public int getLike_Hate() {
		return like_Hate;
	}
	public void setLike_Hate(int like_Hate) {
		this.like_Hate = like_Hate;
	}
	
	
}
