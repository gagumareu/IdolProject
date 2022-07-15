package com.idol.controller;

import java.io.File;
import java.util.Iterator;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service   // 스프링에서 비지니스 로직을 수행할 때 붙이는 애노테이션
           // 해당 Upload 라는 클래스는 비지니스 로직을 수행하는 클래스.
public class UsedUpload {

	public boolean fileUpload(MultipartHttpServletRequest mRequest) {
		
		boolean isUpload = false;
		
		String uploadPath = "C:\\Users\\sjasj\\Documents\\SourceTree\\IdolProject\\IdolProject\\src\\main\\webapp\\resources\\upload\\used\\";
		
		// 업로드된 파일들의 이름 목록을 제공하는 메서드.
		Iterator<String> iterator = mRequest.getFileNames();
		
		while(iterator.hasNext()) {
			
			String uploadFileName = iterator.next();
			
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			
			// 업로드한 파일의 이름을 구하는 메서드.
			String originaleFileName = mFile.getOriginalFilename();
			
			// 실제 폴더를 만들어 보자.
			// ........\\resources\\upload\\2022-05-30
			String homedir = uploadPath;
			
			File path1 = new File(homedir);
			
			if(!path1.exists()) {
				path1.mkdirs();
			}
			
			// 실제 파일을 만들어 보자.
			String saveFileName = originaleFileName;
			
			if(saveFileName != null) {
				
				try {
					//  ........\\resources\\upload\\2022-05-30\\실제 파일
					File origin = new File(homedir + "/" + saveFileName);
					
					// transferTo() : 파일 데이터를 지정한 폴더로 실제 저장시키는 메서드. 
					mFile.transferTo(origin);
					
					isUpload = true;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					
				}
			}
		}  // while문 end
		
		return isUpload;
	
	}  // fileUpload() 메서드 end
}
