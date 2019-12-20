package com.zinsupark.cinema;

import java.util.List;

public interface CinemaService {

	public void insertCinema(Cinema dto);
	public Cinema readCinema(int cmCode);
	public void updateCinema(Cinema dto);
	public List<Cinema> listCinema(int branCode);
}
