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
import com.zinsupark.member.SessionInfo;

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
			@RequestParam(value="ecategoryCode", defaultValue="0") int ecategoryCode,
			@RequestParam(value="state", defaultValue="1") int state,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 6;
		int total_page = 0;
		int dataCount = 0;

		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8"); 
		}
		// 전체 페이지 수
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ecategoryCode", ecategoryCode);
		map.put("state", state);
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
	    
	    String query = "";
        String listUrl = cp+"/event/list?ecategoryCode="+ecategoryCode+"&state="+state;
        String articleUrl = cp+"/event/article?ecategoryCode="+ecategoryCode+"&page="+current_page+"&state="+state;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	           "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
	    
        if(query.length()!=0) {
        	listUrl+="&"+query;
        	articleUrl+="&"+query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
       
        model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("ecategoryCode", ecategoryCode);
		model.addAttribute("keyword", keyword);
		
		return ".event.list";
	}
	
	//응모 등록
	@RequestMapping(value="/event/request", method=RequestMethod.GET)
	public String requestcreated(
			Event dto,
			HttpSession session
			) throws Exception {

		try {

			service.eventRequest(dto);
		} catch (Exception e) {
		}
		
		return ".event.article";

	}
	
	// 분류 등록
	@RequestMapping(value="/event/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception {
		
		List<Event> list=service.listCategory();

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
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getAdminId());
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
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		return ".event.article";
	}
	
	@RequestMapping(value="/event/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int ecode,
			@RequestParam String page,
			Model model
			) throws Exception {

		
		Event dto = service.readEvent(ecode);
		if (dto == null)
			return "redirect:/event/list?page="+page;
		
		List<Event> list=service.listCategory();
		
		
		model.addAttribute("list", list);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return ".event.created";
		
	}
	
	@RequestMapping(value="/event/update", method=RequestMethod.POST)
	public String updateSubmit(
			Event dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"event";
		
		try {
			service.updateEvent(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/event/article?ecode="+dto.getEcode()+"&page="+page;
	}	
	
	@RequestMapping(value="/event/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int ecode,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"event";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteEvent(ecode, pathname, info.getAdminId());
		} catch (Exception e) {
		}
		
		return "redirect:/event/list?"+query;	
	}
	
	@RequestMapping(value="/event/listDott")
	public String eventRequest(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
 	    String cp = req.getContextPath();
   	    
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		 // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;
        
        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        // 글 리스트
        List<Event> list = service.listDott(map);
        
        // 리스트의 번호
        int ecode, n = 0;
        for(Event dto : list) {
        	ecode = dataCount - (offset + n);
        	dto.setEcode(ecode);
        	n++;
        }
        String query = "";
        String listDottUrl = cp+"/event/listDott";
        String articleDottUrl = cp+"/event/articleDott?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listDottUrl = cp+"/event/listDott?" + query;
        	articleDottUrl = cp+"/event/articleDott?page=" + current_page + "&"+ query;
        }
        String paging = myUtil.paging(current_page, total_page, listDottUrl);

        model.addAttribute("listDottUrl", listDottUrl);
        model.addAttribute("articleDottUrl", articleDottUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
	
		return ".event.listDott";
	}

}