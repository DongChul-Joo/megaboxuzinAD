package com.zinsupark.cinema;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("cinema.cinemaController")
public class CinemaController {
	@Autowired
	private CinemaService service;
	
	
	@RequestMapping(value="/cinema/list",method=RequestMethod.POST)
	@ResponseBody
	public List<Cinema> listCinema(
			@RequestParam int branCode
			,Model model) {
		
		List<Cinema> list=null;
		try {
			list=service.listCinema(branCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@RequestMapping(value="/cinema/created",method=RequestMethod.GET)
	public String createForm(
			@RequestParam int branCode
			,@RequestParam String branName
			,Model model) {
		
		
		model.addAttribute("mode","created");
		model.addAttribute("branCode",branCode);
		model.addAttribute("branName",branName);
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
	public String updateForm(
			@RequestParam int cmCode
			,@RequestParam int branCode
			,@RequestParam String branName
			,Model model
			) {
		
		Cinema dto=service.readCinema(cmCode);
		
		model.addAttribute("mode","update");
		model.addAttribute("dto",dto);
		model.addAttribute("branCode","branCode");
		model.addAttribute("branName","branName");
		
		return ".cinema.created";
	}
	
	@RequestMapping(value="/cinema/update",method=RequestMethod.POST)
	public String updateSubmit(Cinema dto) {
		
		try {
			dto.setCmSeatMap(dto.getCmSeatMap().trim());
			service.updateCinema(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return "redirect:/branch/list";
	}
}
