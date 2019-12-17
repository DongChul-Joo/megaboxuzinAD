package com.zinsupark.event;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.zinsupark.common.MyUtil;

@Controller("event.eventController")
public class EventController {

	@Autowired
	private EventService service;
	@Autowired
	private MyUtil myUtil;
	
	// 리스트 만들기
	@RequestMapping(value="/event/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;

		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8"); 
		}
		// 전체 페이지 수
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
			if(offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("rows", rows);
	        
	    List<Event> list = service.listEvent(map);
	    
	    int listNum, n = 0;
	    for(Event dto : list) {
	    	listNum = dataCount - (offset + n);
	    	dto.setEcode(listNum);
	    	n++;
	    }
	    String query = "";
        String listUrl = cp+"/event/list";
        String articleUrl = cp+"/event/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	           "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
	    
        if(query.length()!=0) {
        	listUrl = cp+"/event/list?" + query;
        	articleUrl = cp+"/event/article?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
       
        model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".event.list";
	}
	
	// 분류 등록
	@RequestMapping(value="/event/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("eCategoryCode", null);
		
		List<Event> list=service.listCategory(map);

		model.addAttribute("list", list);
		model.addAttribute("mode", "created");
		return ".event.created";
	}
	// 글 등록
	@RequestMapping(value="/event/created", method=RequestMethod.POST)
	public String createdSubmit(
			Event dto,
			HttpSession session
			) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+"uploads"+File.separator+"event";
		
		//SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId("indo");
			service.insertEvent(dto, path);
		} catch (Exception e) {
		}
		return "redirect:/event/list";
	}
	
	@RequestMapping(value="/event/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int ecode,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"UTF-8");
		}
		
		Event dto = service.readEvent(ecode);
		if(dto==null)
			return "redirect:/event/list?"+query;
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".event.article";
	}
}