package com.spring.ft.comments.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.ft.comments.CommentsService;
import com.spring.ft.comments.CommentsVO;
import com.spring.ft.common.Paging;
import com.spring.ft.video.VideoVO;

@Service("commentsService")
public class CommentsServiceImpl implements CommentsService {

	@Autowired
	private CommentsDAO commentsDAO;
	
	@Autowired
	private HttpSession session;
	
	public CommentsServiceImpl() {}
	
	// 내 채널
	@Override
	public int getMyChannelCommentsCount(Map<String, String> map) {
		return commentsDAO.getMyChannelCommentsCount(map);
	}
	@Override
	public int getMyCommentCount(Map<String, String> map) {
		return commentsDAO.getMyCommentCount(map);
	}
	@Override
	public int getMyCommentCountOne(Map<String, String> map) {
		return commentsDAO.getMyCommentCountOne(map);
	}
	@Override
	public List<CommentsVO> getMyChannelCommentsList(Map<String, String> map) {
		Paging p = new Paging();
		
		// 페이지 당 행(row) 수
		p.setNumPerPage(Integer.parseInt(map.get("rows")));
				
		// 블록 당 페이지 수
		p.setPagePerBlock(3);
		
		p.setTotalRecord(getMyChannelCommentsCount(map));
		
		p.setTotalPage();
		
		String cPage = map.get("cPage");
		
		if (cPage != null) {
			p.setNowPage(Integer.parseInt(cPage));
		} else {
			p.setNowPage(1);
		}
		
		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호 구하기
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
				
		//3-1.(선택적) 끝 번호가 데이터 건수보다 많아지면 데이터 건수와 동일하게 설정
		if (p.getEnd() > p.getTotalRecord()) {
			p.setEnd(p.getTotalRecord());
		}
		
		System.out.println(">> 시작번호(begin) : " + p.getBegin());
		System.out.println(">> 끝번호(end) : " + p.getEnd());
		
		//----- 블록(block) 계산하기 -----------
		//4. 블록 시작페이지, 끝페이지 구하기(현재페이지 번호 사용)
		//4-1. 시작페이지 구하기
		int beginPage = (p.getNowPage() - 1) / p.getPagePerBlock() * p.getPagePerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getPagePerBlock() - 1);
				
		//4-2. 끝페이지(endPage)가 전체 페이지 수(totalPage) 보다 크면
		// 끝페이지를 전체 페이지 수로 변경처리(설정)
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
		}
				
		System.out.println(">> 시작페이지(beginPage) : " + p.getBeginPage());
		System.out.println(">> 끝페이지(endPage) : " + p.getEndPage());
		
		p.setNowBlock(p.getNowPage() / p.getPagePerBlock() + 1);
		p.setTotalBlock(p.getTotalPage() / p.getPagePerBlock());
		
		// map에 저장
		map.put("begin", p.getBegin() + "");
		map.put("end", p.getEnd() + "");
		
		session.setAttribute("pvo", p);
		
		return commentsDAO.getMyChannelCommentsList(map);
	}
	// ---------------------------------------------------------------------
	
	@Override
	public List<CommentsVO> viewComments(VideoVO vo) {
		System.out.println(">> CommnetsImpl List<CommentsVO> viewComments(CommentsVO vo) 실행");
		return commentsDAO.viewComments(vo);
	}
	
	@Override
	public void insertComments(CommentsVO vo) {
		System.out.println(">> CommentsVO insertComments(VideoVO vo) 실행");
		commentsDAO.insertComments(vo);
	}

	@Override
	public void deleteComments(CommentsVO vo) {
		System.out.println(">> CommentsVO deleteComments(CommentsVO vo) 실행");
		commentsDAO.deleteCommetns(vo);
	}
	
	public CommentsVO upSelectComment(CommentsVO vo) {
		System.out.println(">> CommentsVO upSelectComment(CommentsVO vo) 실행");
		return commentsDAO.upSelectComment(vo);
	}
	
	@Override
	public void updateComment(CommentsVO vo) {
		System.out.println(">> CommetnsVO updateComments(CommentsVO vo) 실행");
		commentsDAO.updateComment(vo);
	}

	
	
	
}
