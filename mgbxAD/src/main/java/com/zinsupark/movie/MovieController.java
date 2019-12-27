package com.zinsupark.movie;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller(".movie.movieController")
public class MovieController {
	
	@Autowired
	private APISerializer apiSerializer;
	
	@Autowired
	private MovieService service;
	
	
	@RequestMapping(value="/movie/test", method=RequestMethod.GET)
	public String method2() {
	
		return ".movie.test";
	}
	
	@RequestMapping(value="/movie/movie", method=RequestMethod.GET)
	public String createdForm(Model model) {
		
		model.addAttribute("mode", "movie");
	
		return ".movie.movie";
	}
	
	@RequestMapping(value="/movie/movie", method=RequestMethod.POST)
	public String createdSubmit(Movie dto) {
		try {
			service.insertMovie(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:movie";
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
	
	@RequestMapping(value="/movie/movieImage", produces="application/json;charset=utf-8")
	@ResponseBody
	public String movieImage(
			@RequestParam(defaultValue="") String movieTitle,
			@RequestParam int year,
			@RequestParam(defaultValue="") String country
			) throws Exception{
		
		String clientId = "Jx74CsXTgG7FHEYVVYpg";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "AwLiBAxU6Z";//애플리케이션 클라이언트 시크릿값";
        String result = null;
        String decoded_result = null;
       
        
        try {
        	movieTitle = URLEncoder.encode(movieTitle, "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/search/movie.json?query="+movieTitle+"&yearfrom="+year+"&yearto="+year+"&country="+country; // json 결과
           
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
           
            int responseCode = con.getResponseCode();
            BufferedReader br;
           
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
           
            String inputLine;
            StringBuffer response = new StringBuffer();
            
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
           
            br.close();
            result = response.toString();
            decoded_result = new String(result.getBytes("euc-kr"), "UTF-8");
        } catch (Exception e) {
            System.out.println(e);
        }
        return decoded_result;
    }
	

}
