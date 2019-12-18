package com.zinsupark.cinema;

public interface CinemaService {

	public void insertCinema(Cinema dto);
	public Cinema readCinema(int cmCode);
	public void updateCinema(Cinema dto);
}
