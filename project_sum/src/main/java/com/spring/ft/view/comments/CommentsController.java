package com.spring.ft.view.comments;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.ft.comments.CommentsService;
import com.spring.ft.comments.CommentsVO;

@Controller
public class CommentsController {
	
	@Autowired
	private CommentsService commentsService;
	
	public CommentsController(CommentsService commentsService) {
		System.out.println(">>>> CommentsController(commentsService) 객체 생성");
		System.out.println(":::: CommentsService commentsService : " + commentsService);
		this.commentsService = commentsService;
	}
	
	@RequestMapping("/insertComments.do")
	public String insertComments(CommentsVO vo) {
		System.out.println(":::: insertComments(CommentsVO vo) : " + vo);
		commentsService.insertComments(vo);
		return "redirect:getVideo.do?videoIdx=" + vo.getVideoIdx();
	}
	
	@RequestMapping("/deleteComment.do")
	public String deleteComments(CommentsVO vo) {
		System.out.println(":::: deleteComments(CommentsVO vo) : " + vo);
		commentsService.deleteComments(vo);
		return "redirect:getVideo.do?videoIdx=" + vo.getVideoIdx();
	}
	
	@RequestMapping("/upSelectComment.do")
	public String upSelectComment(Model model,
		 	@RequestParam("videoIdx") int videoIdx, 
		    @RequestParam("commentIdx") int commentIdx,
		    @RequestParam("comments") String comments) {
		System.out.println(":::: upSelectComment - videoIdx: " + videoIdx + ", commentIdx: " + commentIdx + ", comments: " + comments);
		
		CommentsVO comment = new CommentsVO();

		comment.setVideoIdx(videoIdx);
	    comment.setCommentIdx(commentIdx);
	    comment.setComments(comments);
	    CommentsVO resultComment = commentsService.upSelectComment(comment);
	    System.out.println("model comment : " + resultComment);
	    
	    model.addAttribute("comment", resultComment);
		
		return "comments/myupdateComment";
	}
	
	
	@RequestMapping("/updateComment.do")
	public String updateComment(CommentsVO vo) {
		System.out.println(":::: updateComment(CommentsVO vo) : " + vo);
		
		commentsService.updateComment(vo);
		System.out.println("vo.getVideoIdx()" + vo.getVideoIdx());
		return "redirect:getVideo.do?videoIdx=" + vo.getVideoIdx();
	}
}
