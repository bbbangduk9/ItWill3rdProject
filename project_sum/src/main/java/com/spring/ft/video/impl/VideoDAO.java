package com.spring.ft.video.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.ft.members.MembersVO;
import com.spring.ft.video.VideoMembersVO;
import com.spring.ft.video.VideoVO;

@Repository
public class VideoDAO {

	private SqlSessionTemplate mybatis;
	
	@Autowired
	public VideoDAO(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	// 내 동영상 리스트 가져옴
	public List<VideoVO> getMyVideoList(MembersVO vo) {
		return mybatis.selectList("videoDAO.getMyVideoList", vo); 
	}
	// 내 동영상 리스트 가져옴
	public List<VideoVO> getMyContentsVideoList(Map<String, String> map) {
		return mybatis.selectList("videoDAO.getMyContentsVideoList", map); 
	}
	// 내 동영상 갯수 가져옴
	public int getMyVideoCount(MembersVO vo) {
		return mybatis.selectOne("videoDAO.getTotalCount", vo);
	}
	// (채널 콘텐츠) 내 동영상 조건 지정한 거 갯수 가져옴
	public int getMyContentsTotalCount(Map<String, String> map) {
		return mybatis.selectOne("videoDAO.getMyContentsTotalCount", map);
	}
	// (채널 콘텐츠) 동영상 삭제
	public int deleteMyVideo(String videoIdx) {
		return mybatis.delete("videoDAO.deleteMyVideo", videoIdx);
	}
	// (내 채널) 총 조회수 가져옴
	public int getAllViews(String memberId) {
		return mybatis.selectOne("videoDAO.getAllViews", memberId);
	}
	// --------------------------------------------------------------
	
	// 비디오
	public List<VideoVO> getVideoList(VideoVO vo) {
		System.out.println(">> VideoDAO getVideoList() 실행 vo : " + vo);
		return mybatis.selectList("videoDAO.getVideoList", vo);
	}
	
	public void viewUp(VideoVO vo) {
		System.out.println(">> VideoDAO viewUp(VideoVO vo) 실행 vo" + vo);
		mybatis.update("videoDAO.viewUp", vo);
	}
	
	public VideoVO getVideo(VideoVO vo) {
		System.out.println(">> VideoDAO getVideoDetail() 실행 vo : " + vo);
		return mybatis.selectOne("videoDAO.getVideo", vo);
	}
	
	public List<VideoVO> rightVideoList(VideoVO vo) {
		System.out.println(">> VideoDAO rightVideoList() 실행 vo : " + vo);
		return mybatis.selectList("videoDAO.rightVideoList", vo);
	}
	
	public void insertVideo(VideoVO vo) {
		System.out.println("===> MyBatis JDBC로 insertVideo() 실행");
		mybatis.insert("videoDAO.insertVideo", vo);
	}
	
	public void deleteVideo(VideoVO vo) {
		System.out.println("===> MyBatis JDBC로 deleteVideo() 실행");
		mybatis.delete("videoDAO.deleteVideo", vo);
	}
	
	public VideoVO fixVideo(VideoVO vo) {
		System.out.println(">> VideoDAO fixVideo() 실행 vo : " + vo);
		return mybatis.selectOne("videoDAO.fixVideo", vo);
	}
	
	public int updateVideo(VideoVO vo) {
		System.out.println(">> VideoDAO updateVideo() 실행  vo : " + vo);
		return mybatis.update("videoDAO.updateVideo", vo);
	}
	
	public List<VideoMembersVO> videoSearchMain(String searchIdx) {
	      return mybatis.selectList("videoDAO.videoSearchMain", searchIdx);
	   }
	
	public List<VideoVO> myLikesSelect(String memberId) {
	      return mybatis.selectList("videoDAO.myLikesSelect", memberId);
	   }
	
}
