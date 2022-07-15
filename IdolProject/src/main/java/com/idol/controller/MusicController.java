package com.idol.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.idol.model.CelebDAO;
import com.idol.model.CelebDTO;
import com.idol.model.FollowDAO;
import com.idol.model.FollowDTO;
import com.idol.model.GroupDAO;
import com.idol.model.GroupDTO;
import com.idol.model.MemberDTO;
import com.idol.model.MusicDAO;
import com.idol.model.MusicDTO;

@Controller
public class MusicController {
	
	@Autowired
	private CelebDAO celebDAO;
	@Autowired
	private MusicDAO musicDAO;
	@Autowired
	private GroupDAO groupDAO;
	@Autowired
	private FollowDAO followDAO;
	
	@RequestMapping("artist_list.do")
	public String artist_list(@RequestParam("group") String group, Model model) {
		
		List<CelebDTO> artistList = this.celebDAO.getArtistList(group);
		
		model.addAttribute("artistList", artistList);
		
		return "music/artist_list";
	}
	
	@RequestMapping("artist_content.do")
	public String artist_content(HttpServletRequest request,
			@RequestParam("no") int no, Model model) {
		
		String type;   // 보여줄 화면 ( 상세정보 / 곡  / 포토 )
		
		if(request.getParameter("type") != null) {
			type = request.getParameter("type");
		}else {
			type = "detail";    // 처음으로 들어올 경우
		}
		
		// 상세정보 탭
		CelebDTO dto = this.celebDAO.getCelebInfo(no);
		GroupDTO gdto = null;
		if (dto.getCeleb_group() != "solo") {
			gdto = this.groupDAO.getGroupInfo(dto.getCeleb_group());
		}
		List<CelebDTO> groupMember = this.celebDAO.getArtistList(dto.getCeleb_group());
		List<CelebDTO> agencyMember = new ArrayList<CelebDTO>();
		List<CelebDTO> artistList = this.celebDAO.getCelebList();
		
		for(int i=0; i<artistList.size(); i++) {
			if((dto.getCeleb_agency().equalsIgnoreCase(artistList.get(i).getCeleb_agency())) 
					&& !(dto.getCeleb_group().equalsIgnoreCase(artistList.get(i).getCeleb_group()))) {
				agencyMember.add(artistList.get(i));
			}
		}
		
		// music 탭
		List<MusicDTO> musicList = new ArrayList<MusicDTO>();
		
		if(dto.getCeleb_group().equalsIgnoreCase("solo")) {
			musicList = this.musicDAO.getMusicList_solo(dto.getCeleb_name());
		}else {
			musicList = this.musicDAO.getMusicList_group(dto.getCeleb_group());
		}
		
		//album 탭
		List<MusicDTO> albumList = this.musicDAO.getAlbumList_solo(dto.getCeleb_name());
		
		// photo 탭
		String image = dto.getCeleb_pimage();
		StringTokenizer st = new StringTokenizer(image, "|");
		String[] array = new String[st.countTokens()];
		List<String> imageList = new ArrayList<String>();
		
		for(int j=0; j<array.length; j++){
			array[j] = st.nextToken();
		}
		for(int i=0; i<array.length; i++) {
			imageList.add(array[i].trim());
		}
		
		
		model.addAttribute("dto", dto);
		model.addAttribute("gdto", gdto);
		model.addAttribute("type", type);
		model.addAttribute("groupMember", groupMember);	
		model.addAttribute("agencyMember", agencyMember);
		model.addAttribute("musicList", musicList);
		model.addAttribute("imageList", imageList);
		model.addAttribute("albumList", albumList);
		
		return "music/artist_content";
	}
	
	@RequestMapping("user_music_content.do")
	public String music_content(
			@RequestParam("no") int no,
			HttpSession session, Model model) {
		
		MusicDTO dto = this.musicDAO.getMusicCont(no);
		
		int countFollow = this.followDAO.countFollowMusic(no);
		List<FollowDTO> followerList = this.followDAO.followerListMusic(no);
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		int confirmFollow = 0;
		if(mdto != null) {
			for(int i=0; i<followerList.size();i++) {
				if(followerList.get(i).getFollower_no() == mdto.getMember_no()) {
					confirmFollow = 1;
				}
			}
		}
		
		String composer = dto.getMusic_composer();
		StringTokenizer st = new StringTokenizer(composer, ",");
		String[] array = new String[st.countTokens()];
		List<String> composerList = new ArrayList<String>();
		
		for(int j=0; j<array.length; j++){
			array[j] = st.nextToken();
		}
		for(int i=0; i<array.length; i++) {
			composerList.add(array[i].trim());
		}
		
		String lyricst = dto.getMusic_lyricst();
		StringTokenizer st2 = new StringTokenizer(lyricst, ",");
		String[] array2 = new String[st2.countTokens()];
		List<String> lyricstList = new ArrayList<String>();
		
		for(int j=0; j<array2.length; j++){
			array2[j] = st2.nextToken();
		}
		for(int i=0; i<array2.length; i++) {
			lyricstList.add(array2[i].trim());
		}
		
		List<CelebDTO> artistList = this.celebDAO.getCelebList();
		
		model.addAttribute("dto", dto);
		model.addAttribute("composerList", composerList);
		model.addAttribute("lyricstList", lyricstList);
		model.addAttribute("artistList", artistList);
		model.addAttribute("countFollow", countFollow);
		model.addAttribute("confirmFollow", confirmFollow);
		
		return "music/music_content";
	}
	
	@RequestMapping("group_content.do")
	public String group_content(HttpServletRequest request,
			@RequestParam("group") String group, Model model) {
		
		GroupDTO gdto = this.groupDAO.getGroupInfo(group);
		List<CelebDTO> groupMember = this.celebDAO.getArtistList(gdto.getGroup_name());
		
		String type;   // 보여줄 화면 ( 상세정보 / 곡  / 포토 )
		
		if(request.getParameter("type") != null) {
			type = request.getParameter("type");
		}else {
			type = "detail";    // 처음으로 들어올 경우
		}
		
		// 상세정보 탭
		List<CelebDTO> agencyMember = new ArrayList<CelebDTO>();
		List<CelebDTO> artistList = this.celebDAO.getCelebList();
		
		for(int i=0; i<artistList.size(); i++) {
			if((groupMember.get(0).getCeleb_agency().equalsIgnoreCase(artistList.get(i).getCeleb_agency())) 
					&& !(gdto.getGroup_name().equalsIgnoreCase(artistList.get(i).getCeleb_group()))) {
				agencyMember.add(artistList.get(i));
			}
		}
		
		// music 탭
		List<MusicDTO> musicList = new ArrayList<MusicDTO>();
		
			musicList = this.musicDAO.getMusicList_group(gdto.getGroup_name());
		//album 탭
		List<MusicDTO> albumList = this.musicDAO.getAlbumList_group(gdto.getGroup_name());
			
			
		// photo 탭
		String image = gdto.getGroup_image();
		StringTokenizer st = new StringTokenizer(image, "|");
		String[] array = new String[st.countTokens()];
		List<String> imageList = new ArrayList<String>();
		
		for(int j=0; j<array.length; j++){
			array[j] = st.nextToken();
		}
		for(int i=0; i<array.length; i++) {
			imageList.add(array[i].trim());
		}
		
		model.addAttribute("gdto", gdto);
		model.addAttribute("groupMember", groupMember);
		model.addAttribute("type", type);
		model.addAttribute("agencyMember", agencyMember);
		model.addAttribute("musicList", musicList);
		model.addAttribute("imageList", imageList);
		model.addAttribute("albumList", albumList);
		
		
		return "music/group_content";
	}
	
	@RequestMapping("music_search.do")
	public void music_search(@RequestParam("field") String field,
			@RequestParam("keyword") String keyword,
			HttpServletResponse response) throws IOException {
		
		List<CelebDTO> cdto = new ArrayList<CelebDTO>();
		List<GroupDTO> gdto = new ArrayList<GroupDTO>();
		List<MusicDTO> mdto = new ArrayList<MusicDTO>();
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(field.equalsIgnoreCase("artist")) {
			cdto = this.celebDAO.searchCeleb(keyword);
			if(cdto != null) {
				out.println("<script>");
				out.println("location.href='artist_content.do?no=" + cdto.get(0).getCeleb_no() + "'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('정확한 정보를 입력해 주세요.')");
				out.println("history.back()");
				out.println("</script>");
			}
			
		}else if(field.equalsIgnoreCase("group")){
			gdto = this.groupDAO.searchGroup(keyword);
			if(gdto != null) {
				out.println("<script>");
				out.println("location.href='group_content.do?group=" + gdto.get(0).getGroup_name() + "'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('정확한 정보를 입력해 주세요.')");
				out.println("history.back()");
				out.println("</script>");
			}
			
		}else {
			mdto = this.musicDAO.musicSearch(keyword);
			if(mdto != null) {
				out.println("<script>");
				out.println("location.href='user_music_content.do?no=" + mdto.get(0).getMusic_no() + "'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('정확한 정보를 입력해 주세요.')");
				out.println("history.back()");
				out.println("</script>");
			}
		}
		
	}
	
	@RequestMapping("music_like.do")
	public void music_like(@RequestParam("no") int no,
			HttpSession session,
			HttpServletResponse response) throws IOException {
		
		MemberDTO dto = (MemberDTO)session.getAttribute("loginInfo");
		MusicDTO mdto = this.musicDAO.getMusicCont(no);
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(dto == null) {
			out.println("<script>");
			out.println("alert('먼저 로그인을 해주세요.')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			HashMap<String, Object> param = new HashMap<String, Object>();
			
			param.put("follow_no", no);
			param.put("follow_name", mdto.getGroup_name());
			param.put("follower_no", dto.getMember_no());
			param.put("follower_name", dto.getMember_id());
			
			int check = this.followDAO.insertFollowMusic(param);
			
			if(check > 0) {
				out.println("<script>");
				out.println("alert('관심곡으로 등록하였습니다.')");
				out.println("location.href='user_music_content.do?no=" + no + "'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('관심곡 등록에 실패하였습니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
		}
		
	}
	
	@RequestMapping("music_unlike.do")
	public void music_unlike(@RequestParam("no") int no,
			HttpSession session,
			HttpServletResponse response) throws IOException {
		
		MemberDTO dto = (MemberDTO)session.getAttribute("loginInfo");
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		param.put("follow_no", no);
		param.put("follower_no", dto.getMember_no());
		
		int check = this.followDAO.unFollowMusic(param);
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('관심곡을 취소하였습니다.')");
			out.println("location.href='user_music_content.do?no=" + no + "'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('관심곡 취소에 실패하였습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
	}
}
