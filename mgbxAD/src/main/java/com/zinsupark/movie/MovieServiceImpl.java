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
			dao.insertData("movie.insertMovie", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	
	
}
	

	
	
	

