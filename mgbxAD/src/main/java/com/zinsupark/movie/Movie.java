package com.zinsupark.movie;

public class Movie {
	//상영분류 테이블
		private int showingType;
		private String typeName;
		
		//영화등급 테이블
		private int limitCode;
		private String limitName;
		
		//영화제작사 테이블
		private int productionCode;
		private int productionName;
		
		//장르테이블
		private int genreCode;
		private String genreName;
		
		//영화테이블
		private int movieCode;
		private String mstory;
		private String mcreated;
		private String mtime;
		private String mstartDate;
		private String country;
		private String mtitle;
		
		//스틸컷 테이블
		private int steelcutCode;
		private String steelcutName;
		
		//클립 테이블
		private int clipCode;
		private String clipName;
		
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

		public int getShowingType() {
			return showingType;
		}

		public void setShowingType(int showingType) {
			this.showingType = showingType;
		}

		public String getTypeName() {
			return typeName;
		}

		public void setTypeName(String typeName) {
			this.typeName = typeName;
		}

		public int getLimitCode() {
			return limitCode;
		}

		public void setLimitCode(int limitCode) {
			this.limitCode = limitCode;
		}

		public String getLimitName() {
			return limitName;
		}

		public void setLimitName(String limitName) {
			this.limitName = limitName;
		}

		public int getProductionCode() {
			return productionCode;
		}

		public void setProductionCode(int productionCode) {
			this.productionCode = productionCode;
		}

		public int getProductionName() {
			return productionName;
		}

		public void setProductionName(int productionName) {
			this.productionName = productionName;
		}

		public int getGenreCode() {
			return genreCode;
		}

		public void setGenreCode(int genreCode) {
			this.genreCode = genreCode;
		}

		public String getGenreName() {
			return genreName;
		}

		public void setGenreName(String genreName) {
			this.genreName = genreName;
		}

		public int getMovieCode() {
			return movieCode;
		}

		public void setMovieCode(int movieCode) {
			this.movieCode = movieCode;
		}

		public String getMstory() {
			return mstory;
		}

		public void setMstory(String mstory) {
			this.mstory = mstory;
		}

		public String getMcreated() {
			return mcreated;
		}

		public void setMcreated(String mcreated) {
			this.mcreated = mcreated;
		}

		public String getMtime() {
			return mtime;
		}

		public void setMtime(String mtime) {
			this.mtime = mtime;
		}

		public String getMstartDate() {
			return mstartDate;
		}

		public void setMstartDate(String mstartDate) {
			this.mstartDate = mstartDate;
		}

		public String getCountry() {
			return country;
		}

		public void setCountry(String country) {
			this.country = country;
		}

		public String getMtitle() {
			return mtitle;
		}

		public void setMtitle(String mtitle) {
			this.mtitle = mtitle;
		}

		public int getSteelcutCode() {
			return steelcutCode;
		}

		public void setSteelcutCode(int steelcutCode) {
			this.steelcutCode = steelcutCode;
		}

		public String getSteelcutName() {
			return steelcutName;
		}

		public void setSteelcutName(String steelcutName) {
			this.steelcutName = steelcutName;
		}

		public int getClipCode() {
			return clipCode;
		}

		public void setClipCode(int clipCode) {
			this.clipCode = clipCode;
		}

		public String getClipName() {
			return clipName;
		}

		public void setClipName(String clipName) {
			this.clipName = clipName;
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
