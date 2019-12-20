package com.zinsupark.movie;

import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller(".movie.movieController")
public class MovieController {
	
	@Autowired
	private APISerializer apiSerializer;

	
	@RequestMapping(value="/movie/movie", method=RequestMethod.GET)
	public String method() {
	
		return ".movie.movie";
	}
	
	@RequestMapping(value="/movie/movieInfo", produces="application/json;charset=utf-8")
	@ResponseBody
	public String movieinfo(
			@RequestParam (defaultValue="") String movieNm,
			@RequestParam (defaultValue="") String directorNm
			) throws Exception{
		
		String result = "";
		
		movieNm = URLEncoder.encode(movieNm, "UTF-8");
		directorNm = URLEncoder.encode(directorNm, "UTF-8");
		
		String url="http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=dcc1f12995a2b19c3bc5f4f8c32ff84c";
		
		if(movieNm ==""&&directorNm!="") {
			url="http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=dcc1f12995a2b19c3bc5f4f8c32ff84c"
					+ "&directorNm="+directorNm;
		
		} else if(movieNm !=""&&directorNm == ""){
			url="http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=dcc1f12995a2b19c3bc5f4f8c32ff84c"
					+ "&movieNm="+movieNm;
			
			
		} else if(movieNm !=""&&directorNm != ""){
			url="http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=dcc1f12995a2b19c3bc5f4f8c32ff84c"
					+ "&movieNm="+movieNm+"&directorNm="+directorNm;
			
		}
		result = apiSerializer.jsonToString(url);
       
		return result;
	}
	
	@RequestMapping(value="/movie/movieDetail", produces="application/json;charset=utf-8")
	@ResponseBody
	public String movieDetail(
			@RequestParam(defaultValue="") String movieCd
			) throws Exception{
		
		String result = "";
		
		String url="http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=dcc1f12995a2b19c3bc5f4f8c32ff84c&movieCd";
		
		if(movieCd != "") {
			url="http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=dcc1f12995a2b19c3bc5f4f8c32ff84c&movieCd="+movieCd;
		}
		
		result = apiSerializer.jsonToString(url);
		
		return result;
	}
	
	


}
