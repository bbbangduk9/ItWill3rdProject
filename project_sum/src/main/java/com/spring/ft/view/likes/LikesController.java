package com.spring.ft.view.likes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.spring.ft.likes.LikesService;
import com.spring.ft.likes.LikesVO;

@Controller
public class LikesController {		
	@Autowired
	private LikesService likesService;
	@PostMapping("/postLikes.do")
	public String clickLike(LikesVO likesVO) {
		int likesStatusOfMember = -1;
		try {
			likesStatusOfMember = likesService.checkLikesStatusOfMember(likesVO);
		} catch (NullPointerException e) {
			System.out.println("LikesController -> DB에 저장된 값이 없습니다. 좋아요 추가 실행합니다.");
			likesService.addLikes(likesVO);			
		} 
		if (likesStatusOfMember != -1) likesService.updateLikesStatusOfMember(likesVO);	
		return "/video/detail";				
	}
}