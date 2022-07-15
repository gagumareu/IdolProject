package com.idol.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.idol.model.CommunityDAO;
import com.idol.model.CommunityDTO;
import com.idol.model.MemberDTO;
import com.idol.model.RankingDAO;
import com.idol.model.RankingDTO;

@Controller
public class RankingController {
	
	@Autowired
	private RankingDAO rankingDao;
	
	
	@RequestMapping("whole_ranking.do")
	public String whole(HttpServletRequest request, Model model) {
		
		List<RankingDTO> puList = new ArrayList<RankingDTO>();
		List<RankingDTO> meList = new ArrayList<RankingDTO>();
		List<RankingDTO> miList = new ArrayList<RankingDTO>();
		List<RankingDTO> reList = new ArrayList<RankingDTO>();
		List<RankingDTO> birthList = new ArrayList<RankingDTO>();
		List<RankingDTO> coList = new ArrayList<RankingDTO>();
		
		String keyword=request.getParameter("keyword");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("keyword", keyword);
		map.put("rnum", "5");
		
		List<MemberDTO> memberList = this.rankingDao.todayBirth(map);
		for(int i=0; i<memberList.size(); i++) {
			RankingDTO rankingDto = new RankingDTO();
			rankingDto.setMember_no(memberList.get(i).getMember_no());
			rankingDto.setMember_id(memberList.get(i).getMember_id());
			rankingDto.setMember_image(memberList.get(i).getMember_image());
			rankingDto.setMember_introduction(memberList.get(i).getMember_introduction());
			rankingDto.setMember_nickname(memberList.get(i).getMember_nickname());
			rankingDto.setScore(0);
			
			birthList.add(rankingDto);
		}
		
		
		//puList 제품구매횟수 meList 글작성 마일리지 miList 누적마일리지 
		puList = this.rankingDao.mostPurchase(map);
		meList = this.rankingDao.mostMessages(map);
		miList = this.rankingDao.mostMileage(map);
		reList = this.rankingDao.mostReferrals(map);
		coList = this.rankingDao.mostComment(map);
		
		
		model.addAttribute("birthList", birthList);
		model.addAttribute("puList", puList);
		model.addAttribute("meList", meList);
		model.addAttribute("miList", miList);
		model.addAttribute("reList", reList);
		model.addAttribute("coList", coList);
		
		
		return "ranking/whole_ranking_list";
	}
	
	@RequestMapping("detail_ranking.do")
	public String list(HttpServletRequest request, Model model) {
		
		List<RankingDTO> rankList = new ArrayList<RankingDTO>();
		String title = "";
		
		String keyword=request.getParameter("keyword");

		String key=request.getParameter("key");
		
		int score = 0;
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		 map.put("keyword", keyword); 
		 map.put("rnum", "10");
		
		if(key == null) {
			return "ranking/detail_ranking_list";
		}
		
		if(key.equals("point")) {
			title = "Most Point";
			rankList = this.rankingDao.mostMileage(map);
		}else if(key.equals("message")) {
			title = "Most Message";
			rankList = this.rankingDao.mostMessages(map);
		}else if(key.equals("birth")) {
			title = "Congraturation!!";
			List<MemberDTO> memberList = this.rankingDao.todayBirth(map);
			for(int i=0; i<memberList.size(); i++) {
				RankingDTO rankingDto = new RankingDTO();
				rankingDto.setMember_no(memberList.get(i).getMember_no());
				rankingDto.setMember_id(memberList.get(i).getMember_id());
				rankingDto.setMember_image(memberList.get(i).getMember_image());
				rankingDto.setMember_introduction(memberList.get(i).getMember_introduction());
				rankingDto.setMember_nickname(memberList.get(i).getMember_nickname());
				rankingDto.setScore(0);
				
				rankList.add(rankingDto);
			}
		}else if(key.equals("purchase")) {
			title = "Most Purchase";
			rankList = this.rankingDao.mostPurchase(map);
		}else if(key.equals("referrals")) {
			title = "Most Referrals";
			rankList = this.rankingDao.mostReferrals(map);
		}else {
			title="Most Comment";
			rankList = this.rankingDao.mostComment(map);
		}
		
		model.addAttribute("title", title);
		model.addAttribute("rankList", rankList);
		
		
		return "ranking/detail_ranking_list";
		
	}
	
	@RequestMapping(value = "/chat.do", method = RequestMethod.GET)
	public String view_chat(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		return "ranking/view_chat";
	}


}
