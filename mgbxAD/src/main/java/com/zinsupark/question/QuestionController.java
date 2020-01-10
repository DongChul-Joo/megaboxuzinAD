package com.zinsupark.question;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.zinsupark.common.MyUtil;
import com.zinsupark.member.SessionInfo;

@Controller("question.questionController")
public class QuestionController {
	
	@Autowired
	private QuestionService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/question/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if(dataCount != 0)
			total_page = myUtil.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
//		List<Question> questionList = null;
//		if(current_page==1) {
//			questionList=service.listQuestion(map);
//		}
		
		 int offset = (current_page-1) * rows;
			if(offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("rows", rows);
	        
	        List<Question> list = service.listQuestion(map);
	        
	        String cp = req.getContextPath();
	        String query = "";
	        String listUrl = cp+"/question/list";
	        String articleUrl = cp+"/question/article?page=" + current_page;
			if(keyword.length()!=0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}
			if(query.length()!=0) {
				listUrl = cp+"/question/list?" + query;
				articleUrl = cp+"/question/article?page=" + current_page + "&" + query;
			}
			String paging = myUtil.paging(current_page, total_page, listUrl);

			
//			model.addAttribute("questionList", questionList);
			model.addAttribute("list", list);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging" , paging);
			model.addAttribute("articleUrl" , articleUrl);
			
			model.addAttribute("condition" , condition);
			model.addAttribute("keyword", keyword);
				
			return ".question.list";      	
	}
	
	@RequestMapping(value="/question/article")
	public String article(
			@RequestParam int code,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "UTF-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}

		
		Question dto = service.readQuestion1(code);
		if(dto==null) {
			return "redirect:/question/list?"+query;
		}
		
		Question adto = service.readQuestion2(code);
		
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		model.addAttribute("adto", adto);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
				
		return ".question.article";
		
		
	}	
	
	@RequestMapping(value="/question/reply" ,method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replySubmit(
			@RequestParam int code,
			@RequestParam String content,
			Question dto, 
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String isAnswer="false";
		
		if(info.getAdminId().equals("admin")) {
			try {
				dto.setCode(code);
				dto.setUserId(info.getAdminId());
				dto.setContent(content);

				service.insertQuestionAnswer(dto, "reply");
				isAnswer="true";			
			} catch (Exception e) {
				
			}
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("isAnswer", isAnswer);
		model.put("dto", dto);
		return model;	
		
	}
	
	@RequestMapping(value="/question/delete")
	public String delete(
			@RequestParam int code,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Question dto, 
			HttpSession session,
			Model model	
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "UTF-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String isAnswer="true";
		
		if(info.getAdminId().equals("admin")) {
		try {
			dto.setCode(code);
			dto.setUserId(info.getAdminId());
			
			service.deleteQuestionisanswer(code , dto , "reply");	
			isAnswer="false";	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		}


		
		return "redirect:/question/list?"+query;
	}


}
