package com.zinsupark.branch;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("branch.branchController")
public class CinemaController {

	
	@RequestMapping(value="/branch/list",method=RequestMethod.GET)
	public String createForm(Model model) {
		
		return ".branch.list";
	}
	
}
