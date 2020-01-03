package com.zinsupark.event;

import org.springframework.web.multipart.MultipartFile;

public class Event {
	private int ecode; // 이벤트 코드
	private int rcode; // 댓글 코드
	private String userId; // 회원 아이디
	private String sdate; // 시작날짜
	private String edate; // 종료날짜
	private String subject; // 제목
	private String content; // 내용
	private String created; // 작성일자
	private String imageFilename; // 이미지 파일 이름
	private int lott; // 추첨여부
	private String lottDate; // 추첨 날짜 
	private String elink; // 이벤트 링크
	private int mcount; // 당첨자 수
	private int ecategoryCode; // 분류 코드
	private String ecategoryName; // 분류 이름
	private int dott; // 당첨자
	
	private MultipartFile upload;
	
	public int getEcode() {
		return ecode;
	}
	public void setEcode(int ecode) {
		this.ecode = ecode;
	}
	public int getRcode() {
		return rcode;
	}
	public void setRcode(int rcode) {
		this.rcode = rcode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
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
	public String getLottDate() {
		return lottDate;
	}
	public void setLottDate(String lottDate) {
		this.lottDate = lottDate;
	}
	public String getElink() {
		return elink;
	}
	public void setElink(String elink) {
		this.elink = elink;
	}
	public int getMcount() {
		return mcount;
	}
	public void setMcount(int mcount) {
		this.mcount = mcount;
	}
	public int getEcategoryCode() {
		return ecategoryCode;
	}
	public void setEcategoryCode(int ecategoryCode) {
		this.ecategoryCode = ecategoryCode;
	}
	public String getEcategoryName() {
		return ecategoryName;
	}
	public void setEcategoryName(String ecategoryName) {
		this.ecategoryName = ecategoryName;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public int getDott() {
		return dott;
	}
	public void setDott(int dott) {
		this.dott = dott;
	}

}
