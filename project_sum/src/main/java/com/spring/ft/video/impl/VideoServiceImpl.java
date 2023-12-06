package com.spring.ft.video.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.ft.common.Paging;
import com.spring.ft.members.MembersVO;
import com.spring.ft.video.VideoMembersVO;
import com.spring.ft.video.VideoService;
import com.spring.ft.video.VideoVO;

@Service("videoService")
public class VideoServiceImpl implements VideoService {

	@Autowired
	private VideoDAO videoDAO;

	@Autowired
	private HttpSession session;
	
	@Override
	public List<VideoVO> getMyVideoList(MembersVO vo) {
		return videoDAO.getMyVideoList(vo);
	}
	
	@Override
	public List<VideoVO> getMyContentsVideoList(Map<String, String> map) {
		
		Paging p = new Paging();
		
		// 페이지 당 행(row) 수
		p.setNumPerPage(Integer.parseInt(map.get("rows")));
				
		System.out.println("************** " + Integer.parseInt(map.get("rows")));
		
		// 블록 당 페이지 수
		p.setPagePerBlock(3);
		
		p.setTotalRecord(getMyContentsTotalCount(map));
		
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
		
		return videoDAO.getMyContentsVideoList(map);
	}
	@Override
	public int getMyVideoCount(MembersVO vo) {
		return videoDAO.getMyVideoCount(vo);
	}
	@Override
	public int getMyContentsTotalCount(Map<String, String> map) {
		return videoDAO.getMyContentsTotalCount(map);
	}
	@Override
	public void deleteMyVideos(List<String> list) {
		for (int i = 0; i < list.size(); i++) {
			videoDAO.deleteMyVideo(list.get(i));
		}
	}
	@Override
	public int getAllViews(String memberId) {
		return videoDAO.getAllViews(memberId);
	}
	
	// -------------------------------------------------------------
	// 비디오
	@Override
	public List<VideoVO> getVideoList(VideoVO vo) {
		return videoDAO.getVideoList(vo);
	}

	@Override
	public void viewUp(VideoVO vo) {
		System.out.println("viewUp(VideoVO vo) : " + vo);
		videoDAO.viewUp(vo);
	}
	
	@Override
	public VideoVO getVideo(VideoVO vo) {
		System.out.println("getVideo(VideoVO vo) vo : " + vo);

		return videoDAO.getVideo(vo);
	}
	
	@Override
	public List<VideoVO> rightVideoList(VideoVO vo) {
		System.out.println("rightVideoList(VideoVO vo) : " + vo);
		return videoDAO.rightVideoList(vo);
	}
	
	@Override
    public void insertVideo(VideoVO vo) {
        videoDAO.insertVideo(vo);
    }

	@Override
	public void deleteVideo(VideoVO vo) {
		videoDAO.deleteVideo(vo);
		
	}
		
	@Override
	public VideoVO fixVideoVO(VideoVO vo) {
		System.out.println("fixVideoVO(VideoVO vo) : " + vo);
		return videoDAO.fixVideo(vo);
	}
	
	@Override
	public void updateVideo(VideoVO vo) {
		System.out.println("updateVideo(VideoVO vo) : " + vo);
		videoDAO.updateVideo(vo);
	}
	
	@Override
	public List<VideoMembersVO> videoSearchMain(String searchIdx) {
		return videoDAO.videoSearchMain(searchIdx);
	}
	
	@Override
	   public List<VideoVO> myLikesSelect(String memberId) {
	      return videoDAO.myLikesSelect(memberId);
	   }
	
}
