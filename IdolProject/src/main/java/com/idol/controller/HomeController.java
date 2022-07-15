package com.idol.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.omg.CORBA.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.idol.model.EventDTO;
import com.idol.model.ImagesDTO;
import com.idol.model.MusicDAO;
import com.idol.model.MusicDTO;
import com.idol.model.PageDTO;
import com.idol.model.ProductDAO;
import com.idol.model.ProductDTO;
import com.idol.model.UserEventDAO;
import com.idol.model.UserImagesDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private UserImagesDAO userImagesDAO;
	
	@Autowired
	private ProductDAO productDao;
	
	@Autowired
	private UserEventDAO userEventDao;
	
	@Autowired
	private MusicDAO musicDao;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request) {
		
		List<ImagesDTO> list= this.userImagesDAO.imagesList();
		List<ProductDTO> mainplist = this.productDao.mainProductList();
		List<EventDTO> elist = this.userEventDao.allList();
		List<MusicDTO> mainmlist = this.musicDao.getAllList();
		
		for(int i=0; i<10; i++) {
			
			ImagesDTO imagesDto = new ImagesDTO();
			int visible = i%1;
			if(visible == 1) {
				
				int priority = i;
				
				imagesDto.setImage_priority(priority);
				imagesDto.setImage_visible(visible);
				
			}
		}
		
		for(int i = 0;i<mainplist.size();i++) {
			StringTokenizer tokenizer = new StringTokenizer(mainplist.get(i).getProduct_image(), "|");
			String result = tokenizer.nextToken();
			mainplist.get(i).setProduct_image(result);
		}
		
		for(int i=0; i<elist.size(); i++) {
			StringTokenizer eventTokenizer = new StringTokenizer(elist.get(i).getNotice_image(),"|");
			String st = eventTokenizer.nextToken();
			elist.get(i).setNotice_image(st);

			}

		for(int i=0; i<mainmlist.size(); i++) {
			StringTokenizer eventTokenizer = new StringTokenizer(mainmlist.get(i).getMusic_coverimage(),"|");
			String str = eventTokenizer.nextToken();
			mainmlist.get(i).setMusic_coverimage(str);
			
		}
		
		model.addAttribute("mlist", mainmlist);
		model.addAttribute("plist", mainplist);
		model.addAttribute("images", list);
		model.addAttribute("elist", elist);
		
		return "main";
	}
	
}
