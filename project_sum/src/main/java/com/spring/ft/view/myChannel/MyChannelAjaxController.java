package com.spring.ft.view.myChannel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.ft.comments.CommentsService;
import com.spring.ft.members.MembersVO;
import com.spring.ft.sub.SubService;

@RestController
public class MyChannelAjaxController {

	@Autowired
	private SubService subService;
	
	@Autowired
	private CommentsService commentsService;
	
	@RequestMapping("/getJsonSubCount.do")
	public int getJsonSubCount(@RequestBody List<String> dateList, HttpSession session) {
		Map<String, String> map = new HashMap<>();
		map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
		map.put("start_day", dateList.get(0));
		map.put("end_day", dateList.get(dateList.size() - 1));

		// 수정
		int subCountAll = subService.getMySubCount(map) + subService.getMySubCountOne(map);
		
		return subCountAll;
	}
	
	@RequestMapping("/getJsonCommentCount.do")
	public int getJsonCommentCount(@RequestBody List<String> dateList, HttpSession session) {
		Map<String, String> map = new HashMap<>();
		map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
		map.put("start_day", dateList.get(0));
		map.put("end_day", dateList.get(dateList.size() - 1));
		
		for (String str : dateList)
			System.out.println("날짜 : " + str);
		System.out.println("댓글 COUNT " + commentsService.getMyCommentCount(map));
		
		int commentCountAll = commentsService.getMyCommentCount(map) + commentsService.getMyCommentCountOne(map);
		
		return commentCountAll;
	}
	
	@RequestMapping("/getJsonChartSub.do")
	public List<Integer> getAjaxSubList(@RequestBody List<String> dateList, HttpSession session) {
		
		// 값 배열	
		List<Integer> valueList = new ArrayList<>();

		// 지난 7일, 365일 동안이면
		if (dateList.size() != 8) {
			for (int i = 0; i < dateList.size(); i++) {
				Map<String, String> map = new HashMap<>();
				map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
				map.put("start_day", dateList.get(i));
				valueList.add(subService.getMySubCountOne(map));
			}
		} 
		else if (dateList.size() == 8) {
			// 첫 값
			Map<String, String> map0 = new HashMap<>();
			map0.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
			map0.put("start_day", dateList.get(0));
			valueList.add(subService.getMySubCountOne(map0));
			
			// 나머지 값
			for (int i = 0; i < dateList.size() - 1; i++) {
				Map<String, String> map = new HashMap<>();
				map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
				map.put("start_day", dateList.get(i));
				map.put("end_day", dateList.get(i + 1));
				
				valueList.add(subService.getMySubCount(map));
			}
		}
		return valueList;
	}
	
	@RequestMapping("/getJsonChartComment.do")
	public List<Integer> getAjaxCommentList(@RequestBody List<String> dateList, HttpSession session) {
		
		// 값 배열
		List<Integer> valueList = new ArrayList<>();
		
		// 지난 7일, 365일 동안이면
		if (dateList.size() != 8) {
			for (int i = 0; i < dateList.size(); i++) {
				Map<String, String> map = new HashMap<>();
				map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
				map.put("start_day", dateList.get(i));
				valueList.add(commentsService.getMyCommentCountOne(map));
			}
		} 
		else if (dateList.size() == 8) {
			// 첫 값
			Map<String, String> map0 = new HashMap<>();
			map0.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
			map0.put("start_day", dateList.get(0));
			valueList.add(commentsService.getMyCommentCountOne(map0));
			
			// 나머지 값
			for (int i = 0; i < dateList.size() - 1; i++) {
				Map<String, String> map = new HashMap<>();
				map.put("memberId", ((MembersVO) session.getAttribute("vo")).getMemberId());
				map.put("start_day", dateList.get(i));
				map.put("end_day", dateList.get(i + 1));
				
				valueList.add(commentsService.getMyCommentCount(map));
			}
		}
		return valueList;
	}
	
}
