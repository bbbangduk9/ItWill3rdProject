package com.spring.ft.video;

import java.util.List;
import java.util.Map;

import com.spring.ft.members.MembersVO;

public interface VideoService {
	// (내 채널)
	int getMyVideoCount(MembersVO vo);
	List<VideoVO> getMyVideoList(MembersVO vo);

	int getMyContentsTotalCount(Map<String, String> map);
	List<VideoVO> getMyContentsVideoList(Map<String, String> map);
	
	void deleteMyVideos(List<String> list);
	int getAllViews(String memberId);
	// ---------------------------------------------------------
	
	// 비디오
	List<VideoVO> getVideoList(VideoVO vo);
	//수정할 데이터 담아오는 메소드
	void viewUp(VideoVO vo);
	VideoVO getVideo(VideoVO vo);
	List<VideoVO> rightVideoList(VideoVO vo);
	VideoVO fixVideoVO(VideoVO vo);
	void updateVideo(VideoVO vo);
	void insertVideo(VideoVO vo);
	void deleteVideo(VideoVO vo);
	List<VideoMembersVO> videoSearchMain(String searchText);
	List<VideoVO> myLikesSelect(String memberId);
	
}
