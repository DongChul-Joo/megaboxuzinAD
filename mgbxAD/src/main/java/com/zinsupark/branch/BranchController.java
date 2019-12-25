package com.zinsupark.branch;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.zinsupark.cinema.Cinema;

@Controller("branch.branchController")
public class BranchController {
	@Autowired
	private BranchService service;

	
	@RequestMapping(value="/branch/list",method=RequestMethod.GET)
	public String branchList(Model model) {
		
		List<Branch> list=null;
		List<Branch> areaList=null;
		
		try {
			list=service.listBranch();
			areaList=service.listArea();
		} catch (Exception e) {
			return ".error.dataAccessFailure";
		}
		
		model.addAttribute("list",list);
		model.addAttribute("areaList",areaList);
		return ".branch.list";
	}
	
	@RequestMapping(value="/branch/created",method=RequestMethod.GET)
	public String createForm(Model model) {
		
		List<Branch> list=new ArrayList<Branch>();
		try {
			list=service.listArea();
		} catch (Exception e) {
			return ".error.dataAccessFailure";
		}
		
		model.addAttribute("list",list);
		model.addAttribute("mode","created");
		return ".branch.created";  
	}
	
	@RequestMapping(value="/branch/created",method=RequestMethod.POST)
	public String createSubmit(
			Branch dto
			,Model model
			,HttpSession session
			) {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"branchImg"+File.separator+"branch";
		try {
			service.insertBranch(dto,pathname);
		} catch (Exception e) {
			
			return ".error.dataAccessFailure";
		}
		return "redirect:/branch/list";
	}
	
	
	@RequestMapping(value="/branch/update",method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int branCode
			,Model model
			) {
		List<Branch> list=null;
		Branch dto=null;
		try {
			dto=service.readBranch(branCode);
			list=service.listArea();
		} catch (Exception e) {
			return ".error.dataAccessFailure";
		}
		
		
		model.addAttribute("list",list);	
		model.addAttribute("dto",dto);	
		model.addAttribute("mode","update");
		
		return ".branch.created";
	}
	
	@RequestMapping(value="/branch/update",method=RequestMethod.POST)
	public String updateSubmit(
			Branch dto
			,Model model
			,HttpSession session
			) {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"branchImg"+File.separator+"branch";
		try {
			service.updateBranch(dto,pathname);
		} catch (Exception e) {
			
			return ".error.dataAccessFailure";
		}
		return "redirect:/branch/list";
	}
}
