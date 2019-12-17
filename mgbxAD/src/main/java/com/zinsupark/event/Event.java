package com.zinsupark.event;

import org.springframework.web.multipart.MultipartFile;

public class Event {
	private int ecode; // 이벤트 코드
	private String userId; // 회원 아이디
	private String sDate; // 시작날짜
	private String eDate; // 종료날짜
	private String subject; // 제목
	private String content; // 내용
	private String created; // 작성일자
	private String imageFilename; // 이미지 파일 이름
	private int lott; // 추첨여부
	private String eLink; // 이벤트 링크
	private int mCount; // 당첨자 수
	private int eCategoryCode; // 분류 코드
	private String eCategoryName; // 분류 이름
	private MultipartFile upload;
	public int getEcode() {
		return ecode;
	}
	public void setEcode(int ecode) {
		this.ecode = ecode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getsDate() {
		return sDate;
	}
	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	public String geteDate() {
		return eDate;
	}
	public void seteDate(String eDate) {
		this.eDate = eDate;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public int getLott() {
		return lott;
	}
	public void setLott(int lott) {
		this.lott = lott;
	}
	public String geteLink() {
		return eLink;
	}
	public void seteLink(String eLink) {
		this.eLink = eLink;
	}
	public int getmCount() {
		return mCount;
	}
	public void setmCount(int mCount) {
		this.mCount = mCount;
	}
	public int geteCategoryCode() {
		return eCategoryCode;
	}
	public void seteCategoryCode(int eCategoryCode) {
		this.eCategoryCode = eCategoryCode;
	}
	public String geteCategoryName() {
		return eCategoryName;
	}
	public void seteCategoryName(String eCategoryName) {
		this.eCategoryName = eCategoryName;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	
}
