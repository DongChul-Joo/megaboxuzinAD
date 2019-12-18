package com.zinsupark.cinema;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("cinema.cinemaController")
public class CinemaController {
	@Autowired
	private CinemaService service;
	
	@RequestMapping(value="/cinema/created",method=RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("mode","created");
		return ".cinema.created";
	}
	
	@RequestMapping(value="/cinema/created",method=RequestMethod.POST)
	public String createSubmit(
			Cinema dto
			) {
		
		try {
			dto.setCmSeatMap(dto.getCmSeatMap().trim());
			service.insertCinema(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/branch/list";
	}
	
	@RequestMapping(value="/cinema/update",method=RequestMethod.GET)
	public String updateForm(Model model) {
		model.addAttribute("mode","update");
		Cinema dto=service.readCinema(6);
		model.addAttribute("dto",dto);
		model.addAttribute("mode","update");
		return ".cinema.created";
	}
	
	@RequestMapping(value="/cinema/update",method=RequestMethod.POST)
	public String updateSubmit(Cinema dto) {
		
		try {
			dto.setCmCode(6);
			dto.setCmSeatMap(dto.getCmSeatMap().trim());
			service.updateCinema(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return "redirect:/branch/list";
	}
}
