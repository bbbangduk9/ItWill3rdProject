package com.spring.ft.view.video;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.ft.comments.CommentsService;
import com.spring.ft.comments.CommentsVO;
import com.spring.ft.likes.LikesService;
import com.spring.ft.likes.LikesVO;
import com.spring.ft.members.MembersService;
import com.spring.ft.members.MembersVO;
import com.spring.ft.sub.SubService;
import com.spring.ft.video.VideoMembersVO;
import com.spring.ft.video.VideoService;
import com.spring.ft.video.VideoVO;

@Controller
public class VideoController {

	@Autowired
	private VideoService videoService;
	
	@Autowired
	private MembersService membersService;
	
	@Autowired
	private SubService subService;
	
	@Autowired
	private CommentsService commentsService;
	
	@Autowired
	private LikesService likesService;
	
	public VideoController(VideoService videoService) {
		System.out.println(">>>> VideoController(videoService) 객체 생성");
		System.out.println(":::::: VideoService videoService : " + videoService);
		this.videoService = videoService;
	}
	
	@RequestMapping("/getVideoList.do")
	public String getVideoList(VideoVO vo, Model model) {
		System.out.println(">> 게시물 전체 목록 보여주기");
		System.out.println(">> VideoController vo : " + vo);
		
		List<VideoVO> videoList = videoService.getVideoList(vo);
		System.out.println("List<VideoVO> videoList : " + videoList);
		
		model.addAttribute("videoList", videoList);
		
		return "video/mainVideoList";
	}
	
	@RequestMapping("/getVideo.do")
	public String getVideo(VideoVO vo, LikesVO likesVO, Model model, HttpSession session) {
		MembersVO mvo = (MembersVO)session.getAttribute("vo");
		System.out.println("MembersVO : " + mvo);
		
		System.out.println(">> 게시글 상세 보여주기");
		System.out.println("getVideo() vo : " + vo);
		
		// 추가된 코드: videoIdx 값을 확인
		System.out.println("videoIdx: " + vo.getVideoIdx());
		
		videoService.viewUp(vo);
		VideoVO video = videoService.getVideo(vo);
		System.out.println("video : " + video);
		MembersVO vo2 = membersService.getMem(video.getMemberId());
		
		int svo2 = subService.getAllSubCount(video.getMemberId());
	      
	      model.addAttribute("subCount", svo2);
		
		model.addAttribute("video", video);
		model.addAttribute("vo2",vo2);
		
		List<CommentsVO> comments = null;
		comments = commentsService.viewComments(vo);
		System.out.println("VideoController comments : " + comments);
		model.addAttribute("comments", comments);
		System.out.println("model comments : " + model);
		
		// likes
		int numberOfLikes = 0; 
		int likesStatus = -1;
		try {
			numberOfLikes = likesService.checkNumberOfLikesOnVideo(likesVO.getVideoIdx());
			likesVO.setMemberId(mvo.getMemberId());
			likesStatus = likesService.checkLikesStatusOfMember(likesVO);

		} catch (NullPointerException e) {
			System.out.println("VideoController -> NullPointerException");
		}	
		model.addAttribute("video", video); // Model 객체 사용 View로 데이터 전달
		model.addAttribute("likesCount", numberOfLikes);	
		
		if (likesVO.getMemberId() == null) {
	         return "/video/emptyHeartLogin";
		}
		else if (likesStatus != 1) return "video/emptyLikesDetail";
		else return "video/detail";
	}
	
	@RequestMapping("/getMyVideo.do")
	public String getVideo(String videoIdx, HttpSession session, Model model) {
		
		VideoVO vo = new VideoVO();
		vo.setVideoIdx(Integer.parseInt(videoIdx));

		LikesVO likesVO = new LikesVO();
		likesVO.setVideoIdx(Integer.parseInt(videoIdx));
		
		videoService.viewUp(vo);
		VideoVO video = videoService.getVideo(vo);
		
		model.addAttribute("video", video);
		
		List<CommentsVO> comments = null;
		comments = commentsService.viewComments(vo);
		model.addAttribute("comments", comments);
		
		// likes
		int numberOfLikes = 0; 
		int likesStatus = -1;
		try {
			numberOfLikes = likesService.checkNumberOfLikesOnVideo(likesVO.getVideoIdx());
			likesVO.setMemberId((String) session.getAttribute("memberId"));
			likesStatus = likesService.checkLikesStatusOfMember(likesVO);
		} catch (NullPointerException e) {
			System.out.println("VideoController -> NullPointerException");
		}	
		model.addAttribute("video", video); // Model 객체 사용 View로 데이터 전달
		model.addAttribute("likesCount", numberOfLikes);		
		if (likesStatus != 1) return "video/emptyLikesDetail";
		else return "video/detail";
	}
	
	@RequestMapping("/putInsertData.do")
	public String putData(VideoVO vo, Model model) {
		VideoVO video = videoService.getVideo(vo);
	    model.addAttribute("video", video);
	    model.addAttribute("videoIdx", vo.getVideoIdx());
		
		return "comments/insertComments";
	}

	@RequestMapping("rightVideoList.do")
	public String rightVideoList(VideoVO vo, Model model) {
		System.out.println(">> 게시물 전체 목록 보여주기");
		System.out.println(">> VideoController(rightVideoList) vo : " + vo);
		
		List<VideoVO> rvideoList = videoService.rightVideoList(vo);
		System.out.println("List<VideoVO> rightVideoList : " + rvideoList);
		
		model.addAttribute("rvideoList", rvideoList);
		
		return "video/rightList";
	}
	
	@RequestMapping("/insert.do")
	public String insertBoardP() {
		System.out.println("insert.jsp로 이동");
		return "video/insert";
	}
	
	@RequestMapping("/insertVideo.do")
	public String insertVideo(@RequestParam("uploadFile") MultipartFile uploadFile,
							  @RequestParam("addUploadFile") MultipartFile adduploadFile,
							  VideoVO vo,
							  RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {
		System.out.println(">>> 게시글 입력");
		System.out.println("vo : " + vo);
		
		uploadFile = vo.getUploadFile();
		System.out.println("> uploadFile : " + uploadFile);
		adduploadFile = vo.getAddUploadFile();
		System.out.println("> adduploadFile : " + adduploadFile);
		
		if (adduploadFile == null) {
			System.out.println("::: uploadFile 파라미터가 전달되지 않은 경우");
		} else if (adduploadFile.isEmpty()) {
			System.out.println("::: 전달받은 파일 데이터가 없는 경우");
		} else { //업로드 파일이 존재하는 경우
			String filename2 = adduploadFile.getOriginalFilename();
			// 고유한 파일명 생성
			String uniqueFilename2 = System.currentTimeMillis() + "_" + filename2;
			
			
			// 예시: 허용되는 문자 [A-Za-z0-9_] 외의 문자 제거
			uniqueFilename2 = uniqueFilename2.replaceAll("[^A-Za-z0-9_\\.]", ""); // 허용되는 문자 패턴으로 변경
			//물리적 파일 복사
			//uploadFile.transferTo(new File("C:/MyStudy/temp/" + savedFilename));
			String destPathFile2 = "C:/MyStudy/70_Spring/project_sum/videos/" + uniqueFilename2;
			adduploadFile.transferTo(new File(destPathFile2));
			vo.setVideo(uniqueFilename2);
			
			//원본파일명 구하기
			
			
			if (uploadFile == null) {
				System.out.println("::: adduploadFile 파라미터가 전달되지 않은 경우");
			} else if (uploadFile.isEmpty()) {
				System.out.println("::: 전달받은 파일 데이터가 없는 경우");
			} else {
				String filename = uploadFile.getOriginalFilename();
				String uniqueFilename = System.currentTimeMillis() + "_" + filename;
				uniqueFilename = uniqueFilename.replaceAll("[^A-Za-z0-9_\\.]", ""); // 허용되는 문자 패턴으로 변경 
				String destPathFile = "C:/MyStudy/70_Spring/project_sum/thumimgs/" + uniqueFilename;
				uploadFile.transferTo(new File(destPathFile));
				vo.setVimage(uniqueFilename);
			}
			
		}
		
		videoService.insertVideo(vo);
		
		return "redirect:filter.jsp";
	}
	
	@RequestMapping("/deleteVideo.do")
	public String deleteVideo(VideoVO vo) throws IOException {
		System.out.println("vo: "+ vo);
		VideoVO video = videoService.getVideo(vo);
		videoService.deleteVideo(vo);
		String oldVideo = "C:/MyStudy/70_Spring/project_sum/videos/" + video.getVideo();
		String oldVimage = "C:/MyStudy/70_Spring/project_sum/thumimgs/" + video.getVimage();
		Files.deleteIfExists(new File(oldVideo).toPath());
		Files.deleteIfExists(new File(oldVimage).toPath());
		
		return "main";
	}
	
	@RequestMapping("/fixMyVideo.do")
	   public String fixVideo(String memberId, String videoIdx, Model model) {
	      VideoVO vo = new VideoVO();
	      vo.setMemberId(memberId);
	      vo.setVideoIdx(Integer.parseInt(videoIdx));
	      
	      VideoVO video = videoService.fixVideoVO(vo);
	      
	      model.addAttribute("video", video);
	      
	      return "video/myfix";
	   }
	
	@RequestMapping("/fixVideo.do")
	public String fixVideo(VideoVO vo, Model model) {
		System.out.println(">> 게시물 수정전 원본 보여주기");
		System.out.println("fixVideo() vo : " + vo);
		
		VideoVO video = videoService.fixVideoVO(vo);
		System.out.println("게시물 수정전 원본 video : " + video);
		model.addAttribute("video", video);
	
		System.out.println("게시물 수정전 원본 model : " + model);
		
		return "video/myfix";
	}
	
	@RequestMapping("/updateVideo.do")
	public String updateVideo(@RequestParam("uploadFile") MultipartFile uploadFile,
			  				  @RequestParam("addUploadFile") MultipartFile addUploadFile,
			  				  @ModelAttribute("video") VideoVO vo,
			  				  RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {
		System.out.println(">>> 게시글 입력");
		System.out.println("vo : " + vo);
		VideoVO oovideo = videoService.getVideo(vo);
		
		String oldVideo = "C:/MyStudy/70_Spring/project_sum/videos/" + oovideo.getVideo();
		String oldVimage = "C:/MyStudy/70_Spring/project_sum/thumimgs/" + oovideo.getVimage();
		
		uploadFile = vo.getUploadFile();
		System.out.println("> uploadFile : " + uploadFile);
		addUploadFile = vo.getAddUploadFile();
		System.out.println("> adduploadFile : " + addUploadFile);
		
		Files.deleteIfExists(new File(oldVideo).toPath());
		Files.deleteIfExists(new File(oldVimage).toPath());
		
		if (addUploadFile == null) {
			System.out.println("::: uploadFile 파라미터가 전달되지 않은 경우");
		} else if (addUploadFile.isEmpty()) {
			System.out.println("::: 전달받은 파일 데이터가 없는 경우");
		} else { //업로드 파일이 존재하는 경우
			String filename2 = addUploadFile.getOriginalFilename();
			// 고유한 파일명 생성
			String uniqueFilename2 = System.currentTimeMillis() + "_" + filename2;
			
			
			// 예시: 허용되는 문자 [A-Za-z0-9_] 외의 문자 제거
			uniqueFilename2 = uniqueFilename2.replaceAll("[^A-Za-z0-9_\\.]", ""); // 허용되는 문자 패턴으로 변경
			
			//물리적 파일 복사
			//uploadFile.transferTo(new File("C:/MyStudy/temp/" + savedFilename));
			String destPathFile2 = "C:/MyStudy/70_Spring/project_sum/videos/" + uniqueFilename2;
			addUploadFile.transferTo(new File(destPathFile2));
			vo.setVideo(uniqueFilename2);
			
			//원본파일명 구하기
			
			
			if (uploadFile == null) {
				System.out.println("::: adduploadFile 파라미터가 전달되지 않은 경우");
			} else if (uploadFile.isEmpty()) {
				System.out.println("::: 전달받은 파일 데이터가 없는 경우");
			} else {
				String filename = uploadFile.getOriginalFilename();
				String uniqueFilename = System.currentTimeMillis() + "_" + filename;
				uniqueFilename = uniqueFilename.replaceAll("[^A-Za-z0-9_\\.]", ""); // 허용되는 문자 패턴으로 변경 
				String destPathFile = "C:/MyStudy/70_Spring/project_sum/thumimgs/" + uniqueFilename;
				uploadFile.transferTo(new File(destPathFile));
				vo.setVimage(uniqueFilename);
			}
			
		}
		videoService.updateVideo(vo);
		
		return "redirect:getVideo.do?videoIdx=" + vo.getVideoIdx();
	}

   //메인-검색
  @RequestMapping("/videoSearchMain.do")
  public String videoSearchMain(@RequestParam String searchText, Model model) {
     List<VideoMembersVO> videoSearch = videoService.videoSearchMain(searchText);
     System.out.println(searchText);
     System.out.println(videoSearch);
     model.addAttribute("videoSearch", videoSearch);
     return "member/videoSearch";
  }
  
//  좋아요 표시한 동영상
  @RequestMapping("/myLikesSelect.do")
  public String myLikesSelect(@RequestParam("memberId") String memberId, Model model) {
    System.out.println("memberId : " + memberId);
    List<VideoVO> list = videoService.myLikesSelect(memberId);
    System.out.println("list : " + list);
    model.addAttribute("myLikesSelect", list);
     return "member/myLikesSelect";
  }
	
}
