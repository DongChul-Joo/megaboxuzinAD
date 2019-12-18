package com.zinsupark.branch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("branch.branchController")
public class CinemaController {
	@Autowired
	private BranchService service;

	
	@RequestMapping(value="/branch/list",method=RequestMethod.GET)
	public String branchList(Model model) {
		
		return ".branch.list";
	}
	
	@RequestMapping(value="/branch/created",method=RequestMethod.GET)
	public String createForm(Model model) {
		
		List<Branch> list =service.listArea();
		
		model.addAttribute("list",list);
		model.addAttribute("mode","created");
		return ".branch.created";
	}
	
}
