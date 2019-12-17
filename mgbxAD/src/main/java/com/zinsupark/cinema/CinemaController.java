package com.zinsupark.cinema;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("cinema.cinemaController")
public class CinemaController {
	@Autowired
	private CinemaService service;
	
	@RequestMapping(value="/cinema/created",method=RequestMethod.GET)
	public String createForm() {
		
		return ".cinema.created";
	}
	
	@RequestMapping(value="/cinema/created",method=RequestMethod.POST)
	public String createSubmit(
			Cinema dto
			) {
		System.out.println(dto.getCmSeatMap());
		System.out.println(dto.getCmName());
		System.out.println(dto.getCmLocation());
		System.out.println(dto.getCmRange());
		System.out.println(dto.getCmSeatTot());
		try {
			service.insertCinema(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/";
	}
}
