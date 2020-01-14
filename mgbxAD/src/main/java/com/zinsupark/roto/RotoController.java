package com.zinsupark.roto;

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
import com.zinsupark.event.Event;
import com.zinsupark.event.EventService;
import com.zinsupark.member.SessionInfo;

@Controller("roto.rotoController")
public class RotoController {

	@Autowired
	private RotoService service;
	@Autowired
	private EventService eservice;
	
	@Autowired
	private MyUtil myUtil;
	
	// 당첨자 리스트
	@RequestMapping(value="/roto/listDott")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 10;
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
	        
	    List<Roto> list = service.listRoto(map);
	    
	    String query = "";
        String listUrl = cp+"/roto/listDott";
        String articleUrl = cp+"/roto/articleDott?&page="+current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	           "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
	    
        if(query.length()!=0) {
        	listUrl+="?"+query;
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
		model.addAttribute("keyword", keyword);
		
		return ".roto.listDott";
	}
	
	// 당첨자 발표 폼
	@RequestMapping(value="/roto/winner", method=RequestMethod.GET)
	public String winnerForm(
			@RequestParam int ecode,
			@RequestParam String page,
			Model model
			) throws Exception {
		
		Event dto = eservice.readEvent(ecode);
		if(dto==null) {
			return "redirect:/roto/listDott?page="+page;
		}
		
		model.addAttribute("mode", "winner");
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);

		return ".roto.createdDott";
	}
	

	// 당첨자 발표 폼
	@RequestMapping(value="/roto/winner", method=RequestMethod.POST)
	public String winnerSubmit(
			Roto dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getAdminId());
			service.insertRoto(dto);
		} catch (Exception e) {
			
		}
		
		return "redirect:/roto/listDott?page="+page;
	}
	
	// 당첨자 보기
	@RequestMapping(value="/roto/articleDott", method=RequestMethod.GET)
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
			
			Roto dto = service.readRoto(ecode);
			if(dto==null) {
				return "redirect:/roto/listDott?"+query;
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("ecode", dto.getEcode());
			List<Roto> listPic = service.listEventPic(map);
			
			model.addAttribute("dto", dto);
			model.addAttribute("listPic", listPic);
			model.addAttribute("page", page);
			model.addAttribute("query", query);
			return ".roto.articleDott";
		}

}