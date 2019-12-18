package com.zinsupark.item;

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

@Controller("item.ItemController")
public class ItemController {
	@Autowired
	private ItemService service;
	@Autowired
	private MyUtil myUtil;


	@RequestMapping(value="/item/created", method=RequestMethod.GET)
	public String createdForm(Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Item> list = service.listItem(map);
		
		model.addAttribute("list", list);
		model.addAttribute("mode", "created");
		return "item/created";
	}
	
	@RequestMapping(value="/item/created", method=RequestMethod.POST)
	public String createdSubmit(
			Item dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+"uploads"+File.separator+"item";
		
		try {
			
			service.insertItem(dto, path);
		} catch (Exception e) {
		}
		return "redirect:/item/list";
	}
	
	@RequestMapping(value="/item/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 6;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
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
		
		List<Item> list = service.listItem(map);
		
		String query = "";
		String listUrl = cp+"/item/list";
		String articleUrl = cp+"/item/article?page=" + current_page;
		if(keyword.length()!=0) {
			query = "condition=" + condition + "&keyword=" +URLEncoder.encode(keyword, "UTF-8");
		}
		
		if(query.length()!=0) {
			listUrl = cp + "/item/list?" + query;
			articleUrl = cp+"/item/article?page=" + current_page + "&" +query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("condtion", condition);
		model.addAttribute("keyword", keyword);
		
		return "item/list";
	}
	
	@RequestMapping(value="/item/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int itemCode,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "UTF-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Item dto = service.readItem(itemCode);
		if(dto == null)
			return "redirect:/item/list?"+query;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("itemCode", itemCode);
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return "item/article";
	}
	
	@RequestMapping(value="/item/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int itemCode,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		
		
		Item dto = service.readItem(itemCode);
		if(dto == null ) {
			return "redirect:/item/list?page="+page;			
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return "item/created";
	}
	
	@RequestMapping(value="/item/update", method=RequestMethod.POST)
	public String updateSubmit(
			Item dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"item";
		
		try {
			service.updateItem(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/item/article?itemCode="+dto.getItemCode()+"&page="+page;
	}
	
	@RequestMapping(value="/item/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int itemCode,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"item";
		
		keyword = URLDecoder.decode(keyword, "UTF-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		

		Item dto = service.readItem(itemCode);
		if(dto!=null ) {
			service.deleteItem(itemCode, pathname);
		}
		
		return "redirect:/item/list?"+query;
	}
	
}
