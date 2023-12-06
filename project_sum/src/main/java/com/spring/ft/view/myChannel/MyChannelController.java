package com.spring.ft.view.myChannel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.ft.comments.CommentsService;
import com.spring.ft.comments.CommentsVO;
import com.spring.ft.members.MembersService;
import com.spring.ft.members.MembersVO;
import com.spring.ft.sub.SubService;
import com.spring.ft.video.VideoService;
import com.spring.ft.video.VideoVO;

@Controller
public class MyChannelController {

	@Autowired
	MembersService membersService;
	
	@Autowired
	VideoService videoService;
	
	@Autowired
	CommentsService commentsService;
	
	@Autowired
	SubService subService;
	
	// 내 채널
	@RequestMapping("myChannel.do")
	public String goMyChannel(HttpSession session) {
		
		// 로그인한 사용자 객체
		MembersVO vo = (MembersVO) session.getAttribute("vo");

		if (vo == null)
			return "redirect:login.do";
		
		// 동영상 갯수
		int myVideoCount = videoService.getMyVideoCount(vo);
		
		// 동영상 갯수 세션에 저장
		session.setAttribute("myVideoCount", myVideoCount);
		// -----------------------------------------------------------
		
		// 내 동영상 리스트
		List<VideoVO> list = videoService.getMyVideoList(vo);
		
		session.setAttribute("myVideoList", list);
		
		// 조회수
		int views = videoService.getAllViews(vo.getMemberId());
		session.setAttribute("myViews", views);
				
		// 구독자
		int subs = subService.getAllSubCount(vo.getMemberId());
		session.setAttribute("mySub", subs);
		
		// myChannel.jsp로 이동
		return "myChannel/myChannel";
	}
	
	// 남의 채널
	@RequestMapping("channel.do")
	public String goChannel(String memberid, String memberId, HttpSession session) {
		// 전달받은게 없음
		if (memberid == null && memberId == null) {
			return "redirect:main.do";
		}
		
		MembersVO you = null;
		
		// 채널 주인
		if (memberid != null)
			you = membersService.getMem(memberid);
		
		if (memberId != null)
			you = membersService.getMem(memberId);
		
		// 그런 아이디가 없음
		if (you == null) {
			return "redirect:main.do";
		}
		
		// 전달받은 아이디가 로그인한 회원 아이디와 동일하면 내 채널 가기
		if (you != null && session.getAttribute("vo") != null &&
				you.getMemberId().equals(((MembersVO) session.getAttribute("vo")).getMemberId())) {
			return "redirect:myChannel.do";
		}
		session.setAttribute("you", you);
		
		// 동영상 갯수
		int videoCount = videoService.getMyVideoCount(you);
		
		// 동영상 갯수 세션에 저장
		session.setAttribute("videoCount", videoCount);
		// -----------------------------------------------------------
		
		// 동영상 리스트
		List<VideoVO> list = new ArrayList<>(); 
				
		list = videoService.getMyVideoList(you);
		
		session.setAttribute("videoList", list);
		
		// 조회수
		int views = videoService.getAllViews(memberId);
		session.setAttribute("yourViews", views);
		
		// 구독자
		int subs = subService.getAllSubCount(memberId);
		session.setAttribute("yourSub", subs);
		
		// yourChannel.jsp로 이동
		return "myChannel/yourChannel";
	}
	
	// 내 채널 세부정보 창 띄우는 
	@RequestMapping("showMyChannelDetail.do")
	public String showMyChannelDetail() {
		return "myChannel/myChannelDetail";
	}

	// 남의 채널 세부정보 창 띄우는 
	@RequestMapping("showYourChannelDetail.do")
	public String showYourChannelDetail() {
		return "myChannel/yourChannelDetail";
	}

	// 채널 콘텐츠 화면 가기 전
	@RequestMapping("beforeMyChannelContents.do")
	public String beforeMyChannelContents(HttpSession session) {
		
		session.removeAttribute("pvo");
		session.removeAttribute("rows");
		session.removeAttribute("search_select");
		session.removeAttribute("search_filter");
		session.removeAttribute("search_value");
		
		return "redirect:myChannelContents.do?cPage=1&search_select=VTITLE&rows=5";
	}
	
	// 채널 분석 화면 가기 전
	@RequestMapping("beforeMyChannelAnalysis.do")
	public String beforeMyChannelAnalysis(HttpSession session) {
		
		session.removeAttribute("search_select");
		session.removeAttribute("search_value");
		
		return "redirect:myChannelAnalysis.do?search_select=7&search_value=SUB";
	}
	
	// 채널 댓글 화면 가기 전
	@RequestMapping("beforeMyChannelComments.do")
	public String beforeMyChannelComments(HttpSession session) {
		
		session.removeAttribute("pvo");
		session.removeAttribute("rows");
		session.removeAttribute("search_select");
		session.removeAttribute("search_filter");
		session.removeAttribute("search_value");
		
		return "redirect:myChannelComments.do?cPage=1&search_select=VTITLE&rows=5";
	}
	
	// 채널 콘텐츠 화면
	@RequestMapping("myChannelContents.do")
	public String goMyChannelContents(HttpSession session, String cPage, String search_select, String search_filter, String search_value, String rows) {
		Map<String, String> map = new HashMap<>();
		map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
		map.put("cPage", cPage);
		
		if (search_select == null)
			search_select = "";
		if (search_value  == null || search_value.trim().length() == 0)
			search_value  = "";
		if (rows == null)
			rows = "5";
		
		session.setAttribute("search_select", search_select);
		session.setAttribute("search_filter", search_filter);
		session.setAttribute("search_value",  search_value);
		session.setAttribute("rows",  rows);
		
		// map에 저장
		map.put("search_select", search_select);
		map.put("search_filter", search_filter);
		map.put("search_value" , search_value);
		map.put("rows" , rows);
		
		List<VideoVO> list = videoService.getMyContentsVideoList(map);
		
		session.setAttribute("myContentsVideoList", list);
		
		return "myChannel/myChannelContents";
	}
	
	@RequestMapping("deleteMyVideos.do")
	public String deleteMyVideos(String deleteArray) throws IOException {
		
		// 삭제할 videoidx 담긴 list
		List<String> list = Arrays.asList(deleteArray.split(","));

		// 삭제할 비디오 객체 담긴 리스트
		List<VideoVO> deleteList = new ArrayList<>();
		
		for (int i = 0; i < list.size(); i++) {
			VideoVO vo = new VideoVO();
			vo.setVideoIdx(Integer.parseInt(list.get(i)));

			// videoIdx에 해당하는 비디오 객체 하나씩 받아와서
			VideoVO voo = videoService.getVideo(vo);
			
			// 여기 리스트에 추가
			deleteList.add(voo);
		}
		
		// 그냥 비디오만 삭제
		videoService.deleteMyVideos(list);

		for (int i = 0; i < list.size(); i++) {
			String oldVideo = "C:/MyStudy/70_Spring/project_sum/videos/" + deleteList.get(i).getVideo();
			String oldVimage = "C:/MyStudy/70_Spring/project_sum/thumimgs/" + deleteList.get(i).getVimage();
			Files.deleteIfExists(new File(oldVideo).toPath());
			Files.deleteIfExists(new File(oldVimage).toPath());
		}
		
		return "redirect:beforeMyChannelContents.do";
	}
	
	// 채널 분석 화면
	@RequestMapping("myChannelAnalysis.do")
	public String goMyChannelAnalysis(HttpSession session, String search_select, String search_value) {
		Map<String, String> map = new HashMap<>();
		map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
		
		if (search_select == null)
			search_select = "7";
		if (search_value  == null)
			search_value  = "SUB";
		
		session.setAttribute("search_select", search_select);
		session.setAttribute("search_value",  search_value);
		
		// map에 저장
		map.put("search_select", search_select);
		map.put("search_value" , search_value);
		
		int count = subService.getMySubCount(map);
		
		session.setAttribute("mySubCount", count);
		
		return "myChannel/myChannelAnalysis";
	}
	
	// 채널 댓글 화면
	@RequestMapping("myChannelComments.do")
	public String goMyChannelComments(HttpSession session, String cPage, String search_select, String search_filter, String search_value, String rows) {
		Map<String, String> map = new HashMap<>();
		map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
		map.put("cPage", cPage);
		
		if (search_select == null)
			search_select = "";
		if (search_value == null || search_value.trim().length() == 0)
			search_value  = "";
		if (rows == null)
			rows = "5";
		
		session.setAttribute("search_select", search_select);
		session.setAttribute("search_filter", search_filter);
		session.setAttribute("search_value",  search_value);
		session.setAttribute("rows",  rows);
		
		// map에 저장
		map.put("search_select", search_select);
		map.put("search_filter", search_filter);
		map.put("search_value" , search_value);
		map.put("rows" , rows);
		
		List<CommentsVO> list = commentsService.getMyChannelCommentsList(map);
		
		session.setAttribute("myChannelCommentsList", list);
		
		return "myChannel/myChannelComments";
	}
	
	
}
