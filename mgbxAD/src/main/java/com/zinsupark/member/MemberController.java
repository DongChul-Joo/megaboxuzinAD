package com.zinsupark.member;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("member.memberController")
public class MemberController {

	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public String loginForm() {
		return "main/login";
	}
	
	@RequestMapping(value="/member/login", method=RequestMethod.POST)
	public String loginSubmit(
			@RequestParam String adminId,
			@RequestParam String adminPwd,
			HttpSession session,
			Model model
			) {
		
		
		// 세션에 로그인 정보 저장
		SessionInfo info=new SessionInfo();
		info.setAdminId(adminId);
		info.setAdminName(adminPwd);
		
		session.setMaxInactiveInterval(30*60); // 세션유지시간 30분, 기본:30분
		
		session.setAttribute("member", info);
		
		
		return ".main.main";
	}
	
	@RequestMapping(value="/member/logout")
	public String logout(HttpSession session) {
		// 세션에 저장된 정보 지우기
		session.removeAttribute("member");
		
		// 세션에 저장된 모든 정보 지우고, 세션초기화
		session.invalidate();
		
		return "redirect:/";
	}
}
