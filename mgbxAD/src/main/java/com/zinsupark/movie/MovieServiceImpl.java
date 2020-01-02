package com.zinsupark.movie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zinsupark.common.dao.CommonDAO;

@Service("movie.movieService")
public class MovieServiceImpl implements MovieService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertMovie(Movie dto) throws Exception {
		try {
			
			if(dto.getAudits().startsWith("청소년")) {
				dto.setAudits("청불");
			} else if (dto.getAudits().startsWith("12세")) {
				dto.setAudits("12");
			} else if (dto.getAudits().startsWith("15세")) {
				dto.setAudits("15");
			} else {
				dto.setAudits("전체");
			}
			
			dao.insertData("movie.insertMovie", dto);
			
		} catch (Exception e) {
			throw e;
		}
		
	}

	
	
}
	

	
	
	

