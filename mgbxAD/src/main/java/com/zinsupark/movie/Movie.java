package com.zinsupark.movie;

public class Movie {
		//영화테이블
		private int movieCode;
		private String movieNm;
		private String audits;
		private String thumbNail;
		private String movieStory;
		
		//영화 평점 테이블
		private long movieScores;
		
		//출연진 테이블
		private String director;
		private String actorName;
		
		//영화 상세게시판 댓글
		private String content;
		private String created;
		
		//영화 상세게시판 댓글 좋아요
		private String likeUserId;
		
		//댓글 신고
		private String reportUserId;

		public int getMovieCode() {
			return movieCode;
		}

		public void setMovieCode(int movieCode) {
			this.movieCode = movieCode;
		}

		public String getMovieNm() {
			return movieNm;
		}

		public void setMovieNm(String movieNm) {
			this.movieNm = movieNm;
		}

		public String getAudits() {
			return audits;
		}

		public void setAudits(String audits) {
			this.audits = audits;
		}

		public String getThumbNail() {
			return thumbNail;
		}

		public void setThumbNail(String thumbNail) {
			this.thumbNail = thumbNail;
		}

		public String getMovieStory() {
			return movieStory;
		}

		public void setMovieStory(String movieStory) {
			this.movieStory = movieStory;
		}

		public long getMovieScores() {
			return movieScores;
		}

		public void setMovieScores(long movieScores) {
			this.movieScores = movieScores;
		}

		public String getDirector() {
			return director;
		}

		public void setDirector(String director) {
			this.director = director;
		}

		public String getActorName() {
			return actorName;
		}

		public void setActorName(String actorName) {
			this.actorName = actorName;
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

		public String getLikeUserId() {
			return likeUserId;
		}

		public void setLikeUserId(String likeUserId) {
			this.likeUserId = likeUserId;
		}

		public String getReportUserId() {
			return reportUserId;
		}

		public void setReportUserId(String reportUserId) {
			this.reportUserId = reportUserId;
		}

		
		
}
