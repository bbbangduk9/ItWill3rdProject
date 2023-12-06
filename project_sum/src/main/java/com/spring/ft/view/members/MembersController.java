package com.spring.ft.view.members;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.spring.ft.members.MailSendService;
import com.spring.ft.members.MembersService;
import com.spring.ft.members.MembersVO;
import com.spring.ft.members.SubscribeVO;

@Controller
@SessionAttributes({"vo","pwvo","email"})
public class MembersController {

	@Autowired
	MembersService membersService;
	
	@Autowired
	private MailSendService mailSendService;
	String finalEmail = "";
	
	public MembersController() {
		System.out.println("MembersController() 객체 생성");
	}
	
	@PostMapping("loginCheck.do")
	@ResponseBody
	public MembersVO login(MembersVO vo, Model model) {
		MembersVO member = membersService.getMembers(vo);
		System.out.println("member : " + member);
		//로그인 성공
		if(member != null) {
			System.out.println("로그인 성공");
			model.addAttribute("vo", member);
			membersService.updateLog(vo);
			return member;
		}
		else{
			System.out.println("로그인 실패");
			return null;	
		}
	}
	
	//1년 이상 미접속 회원 삭제
	@RequestMapping("/main.do")
	public String UserTimeDelete() {
		membersService.userTimeDelete();
		return "main";
	}
	
	//회원등록화면 이동
	@RequestMapping("/memberRegistGO.do")
	public String memberRegistGO() {
		return "member/memberRegist";
	}
	
	//회원등록
	@RequestMapping("/memberRegist.do")
   public String memberRegist(MembersVO vo, @RequestParam("imageFile") MultipartFile uploadFile) {
      // 업로드된 이미지가 있을 경우에만 처리
      if (uploadFile != null && !uploadFile.isEmpty()) {
          try {
              // 이미지를 업로드 폴더에 저장
              String uploadFolderPath = "C:/MyStudy/70_Spring/project_sum/profileImage/";
              String upLoadFileName = uploadFile.getOriginalFilename();
              //파일 이름의 특수문자 삭제 정규식
              upLoadFileName = upLoadFileName.replaceAll("[^A-Za-z0-9_\\.]", "");
              String filename = UUID.randomUUID().toString() + "_" + upLoadFileName;
              Path filepath = Paths.get(uploadFolderPath, filename);
              Files.write(filepath, uploadFile.getBytes());
      
              // DB에는 파일의 상대 경로를 저장 (예: /uploads/filename.jpg)
              vo.setImage(filename);
          } catch (IOException e) {
              e.printStackTrace();
          }
      }
      membersService.memberRegist(vo);
      return "main";
   }
	
	@RequestMapping("/subscribe.do")
	public String subscribe(HttpSession session, Model model) {
		List<MembersVO> titles = subscribeListFinal(session);
	    model.addAttribute("titles", titles);
		return "member/subscribe";
	}
	
		//ID 중복값 확인
	@RequestMapping("/duplicationCheck.do")
	@ResponseBody
	public String duplicationCheck(@RequestParam String memberId) {
		int isDuplicate = membersService.duplicationCheck(memberId);
		System.out.println(isDuplicate);
		if (isDuplicate == 0) {
			return "ID_OK";
		} else {
			return "DUPLICATE";
		}
	}
	
	//email 인증
	   @RequestMapping("/emailConfirm.do")
	   @ResponseBody
	   public String emailConfirm(@RequestParam("email") String email, Model model) {
	      System.out.println("이메일  : " + email);
	      model.addAttribute("email",email);
	      return mailSendService.joinEmail(email);
	   }
	
	//Email 중복값 확인
	@RequestMapping("/duplicationEmailCheck.do")
	@ResponseBody
	public String duplicationEmailCheck(@RequestParam String email) {
	    if (!isValidEmailFormat(email)) {
	        return "INVALID_FORMAT";
	    }

	    int isDuplicate = membersService.duplicationEmailCheck(email);
	    System.out.println(isDuplicate);
	    if (isDuplicate == 0) {
	        return "Email_OK";
	    } else {
	        return "DUPLICATE";
	    }
	}
	private boolean isValidEmailFormat(String email) {
	    // 이메일 형식 검사 정규 표현식
	    String emailPattern = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	    Pattern pattern = Pattern.compile(emailPattern);
	    Matcher matcher = pattern.matcher(email);
	    return matcher.matches();
	}
	//회원정보 리스트 확인-관리자용
	@RequestMapping("/getMasterList.do")
	public String membersListMaster(Model model, String searchID) {
		List<MembersVO> memberList = membersService.membersListMaster(searchID);
		List<MembersVO> masterList = new ArrayList<MembersVO>();
	      for (MembersVO mvo : memberList) {
	         if(mvo.getStatus() != 0) {
	            masterList.add(mvo);
	         }
	      }
		model.addAttribute("masterList", masterList);
		return "member/membersListMaster";
	}
	//회원 상태 수정-관리자
	@RequestMapping("/statusUpdate.do")
	@ResponseBody
	public String statusUpdate(MembersVO vo) {
		System.out.println(vo);
	    membersService.statusUpdate(vo);
	    return "success";
	}
	//메인-검색
	   @RequestMapping("/titleSearch.do")
	   public String titleSearch(@RequestParam String searchText, Model model) {
	      List<MembersVO> titleSearch = membersService.titleSearch(searchText);
	      System.out.println(searchText);
	      System.out.println(titleSearch);
	      model.addAttribute("titleSearch", titleSearch);
	      
	        return "member/titleSearch";
	   }
	
	 //구독
	   @RequestMapping("/subscribeSelect.do")
	   @ResponseBody
	   public String subscribeSelect(@RequestParam("memberId") String memberId, HttpSession session, Model model) {
	      MembersVO mvo = (MembersVO) session.getAttribute("vo");
	      System.out.println("channel Id : " + memberId);
	      System.out.println("membersVO : " + mvo);
	      String Logged = null;
	      if (mvo == null || memberId.equals(mvo.getMemberId())) {
	          //model.addAttribute("isLogged", c);
	         Logged = "subscribeFalse";
	       } else {
	           // 채널주인과 로그인한 회원이 다른 경우
	           MembersVO loggedInMember = new MembersVO(); // 예시로 MembersVO 클래스를 사용했다고 가정
	           loggedInMember.setMemberId(mvo.getMemberId());

	           MembersVO channelOwner = new MembersVO(); // 예시로 MembersVO 클래스를 사용했다고 가정
	           channelOwner.setMemberId(memberId);

	           // 해당 회원이 이미 구독 중인지 확인
	           List<SubscribeVO> subscribeList = membersService.subscribeSelect(mvo.getMemberId());
	           boolean isSubscribed = false;
	           for (SubscribeVO subscribeVO : subscribeList) {
	               if (subscribeVO.getSubscribeId().equals(memberId)) {
	                   isSubscribed = true;
	                   break;
	               }
	           }

	           SubscribeVO subscribeVO = new SubscribeVO(); // 예시로 SubscribeVO 클래스를 사용했다고 가정
	           subscribeVO.setMemberId(mvo.getMemberId());
	           subscribeVO.setSubscribeId(memberId);

	           // 이미 구독 중인 경우: 구독 취소
	           if (isSubscribed) {
	               membersService.subscribeDel(subscribeVO);
	               //model.addAttribute("isLogged", "subscribeOn");
	               Logged = "subscribeOn";
	               System.out.println("구독이 취소되었습니다: " + mvo.getMemberId() + " -> " + memberId);
	           } else {
	               // 구독 중이 아닌 경우: 구독 추가
	               membersService.subscribeIn(subscribeVO);
	              // model.addAttribute("isLogged", "subscribeOff");
	               Logged = "subscribeOff";
	               System.out.println("구독이 추가되었습니다: " + mvo.getMemberId() + " -> " + memberId);
	           }
	       }
	       // 원하는 처리 후에는 해당하는 페이지로 이동하도록 설정해주세요.
	       return Logged; // 이동할 페이지의 URL을 입력해주세요.
	   }
	   @RequestMapping("/subscribeConfirm.do")
	   @ResponseBody
	   public String subscribeConfirm(@RequestParam("memberId") String memberId, HttpSession session) {
	      MembersVO mvo = (MembersVO) session.getAttribute("vo");
	      System.out.println("channel Id : " + memberId);
	      System.out.println("membersVO__ : " + mvo);
	      String Logged = null;
	      if (mvo == null || memberId.equals(mvo.getMemberId())) {
	         Logged = "subscribeFalse";
	      } else {
	         // 채널주인과 로그인한 회원이 다른 경우
	         // 해당 회원이 이미 구독 중인지 확인
	         List<SubscribeVO> subscribeList = membersService.subscribeSelect(mvo.getMemberId());
	         boolean isSubscribed = false;
	         for (SubscribeVO subscribeVO : subscribeList) {
	            if (subscribeVO.getSubscribeId().equals(memberId)) {
	               isSubscribed = true;
	               break;
	            }
	         }
	         SubscribeVO subscribeVO = new SubscribeVO(); // 예시로 SubscribeVO 클래스를 사용했다고 가정
	         subscribeVO.setMemberId(mvo.getMemberId());
	         subscribeVO.setSubscribeId(memberId);
	         
	         // 이미 구독 중인 경우
	         if (isSubscribed) {
	            Logged = "subscribeOff";
	         } else {
	            // 구독 중이 아닌 경우
	            Logged = "subscribeOn";
	         }
	      }
	      return Logged; 
	   }
	//leftFrame 로딩
	@RequestMapping("/leftFrame.do")
	   public String subscribeList (HttpSession session, Model model){
	      MembersVO mvo = (MembersVO) session.getAttribute("vo");
	      
	      if (mvo != null && mvo.getStatus() == 0) {
	         return "frame/masterFrame";
	      } else if(mvo != null && mvo.getStatus() == 1){
	         List<MembersVO> titles = subscribeListFinal(session);
	         model.addAttribute("titles", titles);
	         return "frame/leftFrame";
	      }else {
	    	  return "frame/notMember";
	      }
	   }
	
	public List<MembersVO> subscribeListFinal(HttpSession session) {
	    List<MembersVO> titles = new ArrayList<>();
	    MembersVO mvo = (MembersVO) session.getAttribute("vo");
	    if (mvo != null) {
	        String memberId = mvo.getMemberId();
	        if (memberId != null && !memberId.isEmpty()) {
	            List<SubscribeVO> slist = membersService.subscribeSelect(memberId);
	            for (SubscribeVO svo : slist) {
	                MembersVO vo = membersService.titleList(svo.getSubscribeId());
	                titles.add(vo);
	            }
	        }
	    }
	    return titles;
	}
	//topFrame 로딩
	@RequestMapping("/topFrame.do")
	public String loadTopFrame(Model model, HttpSession session) {
	    // 세션에서 값을 가져옴
	    // 세션 값이 있다면 isLogged 값을 true로 설정하여 View로 전달
		MembersVO mvo = (MembersVO) session.getAttribute("vo");
		String sessionValue = null;
		if (mvo != null) {
			sessionValue = mvo.getMemberId();
			System.out.println("loadTopFrame sessionValue : " + sessionValue);
		}
		if (sessionValue != null && !sessionValue.isEmpty()) {
			model.addAttribute("isLogged", true);
		} else {
			model.addAttribute("isLogged", false);
		}
	    return "frame/topFrame";
	}
	@RequestMapping("/login.do")
	public String loginView(MembersVO vo, SessionStatus status, HttpSession session) {
		System.out.println(">>> 로그인 화면 이동 - loginView()");
		status.setComplete();
		session.invalidate();
		System.out.println("vo : " + vo);
		return "member/login";
	}
	
	@RequestMapping("/logout.do")
	public String logout(SessionStatus status, HttpSession session) {
		System.out.println(">>> 로그아웃 처리");
		status.setComplete();
		session.invalidate();
		
		return "main";
	}
	
	
	@PostMapping("/updateMembers.do")
	public String updateMembers(@ModelAttribute("vo")MembersVO vo) {
		System.out.println("회원정보 상세");
		System.out.println("vo : " + vo);
		return "member/updateMembers";
	}
	
	@RequestMapping("/password.do")
	public String passwordkk(@ModelAttribute("vo")MembersVO vo) {
		return "member/passwordOK";
	}
	
	@RequestMapping("/passwordOK.do")
	@ResponseBody
	public String password(@ModelAttribute("vo")MembersVO vo, @RequestParam String password) {
		System.out.println("vo : " + vo);
		System.out.println("pwd : " + password);

		if(password.equals(vo.getPwd())) {
			System.out.println("비밀번호 확인 완료!");
			return UUID.randomUUID().toString() + (Math.random() * 100);
		}else {
			System.out.println("비밀번호 확인 실패!");
			return null;
		}
	}
	
	@RequestMapping("/move.do")
	public String updateMove(@ModelAttribute("vo")MembersVO vo) {
		return "member/passwordOK";
	}
	
	@PostMapping("/updateMembersGO.do")
	public String updateMembersGo(@ModelAttribute("vo")MembersVO vo, @RequestParam("file") MultipartFile file) throws IllegalStateException, IOException{
		
		if(file == null) {
			System.out.println("upload할 파일이 존재하지 않음");
		}else if (file.isEmpty()) {
	        // 파일이 업로드되지 않은 경우 처리
			vo.setImage("");
	        System.out.println("file.isEmpty()");
		    } else {
		    	
		        // 파일이 업로드된 경우 처리
		        String originalFilename = file.getOriginalFilename();
		        originalFilename = originalFilename.replaceAll("[^A-Za-z0-9_\\.]", "");
		        
		        originalFilename = UUID.randomUUID().toString();
		        String savedFilename = "C:/MyStudy/70_Spring/project_sum/profileImage/" + originalFilename;  // 저장할 경로 설정
		        System.out.println("저장 경로 : " + savedFilename);
				file.transferTo(new File(savedFilename));

		        vo.setImage(originalFilename);
		        System.out.println("파일 업로드 성공: " + originalFilename);
		    }
				
		System.out.println("회원정보 수정");
		membersService.updateMembers(vo);
		return "main";
	}
	
	@RequestMapping("/joinMemberShip.do")
	public String joinMemberShip() {
		System.out.println("회원가입 약관 동의 페이지");	
		return "member/joinMemberShip";
	}
	
	@RequestMapping("/findID.do")
	public String nextID(){
		System.out.println("아이디 찾기 페이지");
        return "member/findID";
	}
	
	
	@RequestMapping("/findOK.do")
	@ResponseBody
	public String findOK(MembersVO vo, @RequestParam("email") String email, Model model) {
		System.out.println("이메일 vo : " + vo.getEmail());
		List<MembersVO> members = membersService.checkGetUser(vo);
		System.out.println("members : " + members);
		
		model.addAttribute("email",email);
		
		for(MembersVO member : members) {
			if(vo.getEmail().equalsIgnoreCase(member.getEmail())) {
				System.out.println("아이디 존재");
				System.out.println("이메일 요청 : " + email);
				System.out.println("인증번호 확인");
				return mailSendService.joinEmail(email);
			}
		}
		System.out.println("이메일이 존재하지않음");
		return null;
	}
	
	
	@RequestMapping("/findIDOK.do")
	public String findIDOK(Model model, @ModelAttribute("email") String email) {
		finalEmail = email;
		System.out.println("finalEmail : " + finalEmail);
		String id = membersService.getID(finalEmail);
		
		System.out.println("id : " + id);
		model.addAttribute("id",id);
		return "member/findIDOK";
	}
	
	@RequestMapping("findPwd.do")
	public String nextPwd() {
		System.out.println("비밀번호 찾기 페이지");
        return "member/findPwd";
	}
	
	@RequestMapping("/findOKPwd.do")
	@ResponseBody
	public String findOKPwd(MembersVO vo,
			@RequestParam("email") String email,
			@RequestParam("memberId") String memberId,Model model) {
		
		model.addAttribute("pwvo", vo);
		
		System.out.println("memberID : " + memberId); // jsp에서 입력한 아이디
		System.out.println("email : " + email); // jsp에서 입력한 email
		finalEmail = email;
		System.out.println("이메일 vo : " + vo.getEmail());
		
		System.out.println("아이디 vo : " + vo.getMemberId());
		
		MembersVO members = membersService.getPwd(vo);
		System.out.println("members : " + members);
		
		if(members == null) {
			System.out.println("정보가 올바르지않음");
			return null;
		}
		else {
			System.out.println("아이디 이메일 일치");
			return mailSendService.joinEmail(email);
			
		}
	}
	
	@RequestMapping("/findPwdOK.do")
	public String findPwdOK(@ModelAttribute("pwvo")MembersVO vo) {
		System.out.println("비밀번호 바꾸는 페이지");
		System.out.println("vo " + vo);
		return "member/findPwdOK";
	}
	
	@RequestMapping("findPwdOKOK.do")
	public String findPwdOKOK(@ModelAttribute("pwvo")MembersVO vo) {
		System.out.println("비밀번호 바꾼 후 페이지");
		System.out.println("vo : " + vo);
		membersService.changePwd(vo);
		return "member/findPwdRealOK";
	}
	
	
	
}
