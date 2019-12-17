package com.zinsupark.cinema;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zinsupark.common.dao.CommonDAO;

@Service("cinema.cinemaService")
public class CinemaSerbiceImpl implements CinemaService{
	@Autowired
	CommonDAO dao;
	
	@Override
	public void insertCinema(Cinema dto) {
		try {
			dao.insertData("cinema.insertCinema", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
