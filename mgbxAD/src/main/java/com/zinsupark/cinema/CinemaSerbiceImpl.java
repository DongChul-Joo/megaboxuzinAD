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

	@Override
	public Cinema readCinema(int cmCode) {
		Cinema dto=null;
		try {
			dto=dao.selectOne("cinema.readCinema",cmCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateCinema(Cinema dto) {
		try {
			dao.updateData("cinema.updateCinema", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
