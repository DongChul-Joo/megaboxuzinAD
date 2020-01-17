package com.zinsupark.branch;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zinsupark.cinema.Cinema;
import com.zinsupark.cinema.CinemaService;
import com.zinsupark.common.MyUtil;


@Controller("branch.branchController")
public class BranchController {
	@Autowired
	private BranchService service;
	
	@Autowired
	private CinemaService service2;
	
	@Autowired
	private MyUtil util;

	
	@RequestMapping(value="/branch/branch",method=RequestMethod.GET)
		public String branchForm(
				Model model
				) {
			List<Branch> areaList=null;
			
			try {
				areaList=service.listArea();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("areaList",areaList);
		return ".branch.branch";
	}
	
	@RequestMapping(value="/branch/list",method=RequestMethod.GET)
	public String branchList(
			@RequestParam(defaultValue="0") int areaCode
			,@RequestParam(defaultValue="1") int pageNo
			,Model model) {
		
		List<Branch> list=null;
		
		int nowPage=pageNo;
		int rows=5;
		
		
		int dataCount=0;
		
		
		Map<String,Object> map=new HashMap<>();
		map.put("areaCode",areaCode);
		
		try {
			dataCount=service.branchCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		int tot_page=util.pageCount(rows, dataCount);
		
		if(tot_page<nowPage) {
			tot_page=nowPage;
		}
		
		String paging=util.paging(nowPage, tot_page);
		
		int offset=(nowPage-1)*rows;
		
		try {
			map.put("rows", rows);
			map.put("offset", offset);
			list=service.listBranch(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("areaCode",areaCode);
		model.addAttribute("page",nowPage);
		model.addAttribute("paging",paging);
		model.addAttribute("list",list);
		return "branch/list";
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
	
	
	@RequestMapping(value="/branch/insertShowingMovie", method=RequestMethod.GET)
	public String getMovieList(
			@RequestParam int branCode,
			Model model
			) {
		List<Branch> list = null;
		List<Cinema> list2=null;
		try {
			list = service.getMovieList();
			list2=service2.listCinema(branCode);
			
			for(Cinema dto : list2) {
				if(dto.getCmRange()== 1) {
					dto.setCmRangeName("2D 전용관");
				} else {
					dto.setCmRangeName("2D and 3D관");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		
		return ".branch.insertShowingMovie";
	}

	@RequestMapping(value="/branch/insertMovie", method=RequestMethod.POST) 
	@ResponseBody
	public String insertShowingMovie(
			@RequestParam Map<String, Object> paramMap,
			@RequestParam int movieCode,
			@RequestParam int cmCode,
			@RequestParam String showingStart,
			@RequestParam String showingEnd
			) {
		String state = "true";
		try {
			paramMap.put("movieCode", movieCode);
			paramMap.put("cmCode", cmCode);
			paramMap.put("showingStart", showingStart);
			paramMap.put("showingEnd", showingEnd);
			
			service.insertShowingMovie(paramMap);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			state = "false";
		}
		
		return state;
	}
	
}
