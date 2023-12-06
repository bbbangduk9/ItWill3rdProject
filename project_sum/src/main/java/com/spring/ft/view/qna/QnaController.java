package com.spring.ft.view.qna;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.ft.members.MembersVO;
import com.spring.ft.qna.PageVO;
import com.spring.ft.qna.QnaService;
import com.spring.ft.qna.QnaVO;

/* 
@SessionAttributes : 같은 컨트롤러에서 모델객체 공유해서 사용(session)
   단, 현재(동일) 컨트롤러에서만 사용 가능
   사용완료되면 SessionStatus 객체의 setComplete() 메소드 사용해서 해제
@SessionAttribute : HttpSession 에 데이터 저장 및 읽기
*/
@Controller
@SessionAttributes({"vo","qna"})
//@RequestMapping("/board")
public class QnaController {
   //@Autowired
   private QnaService qnaService;
   

   
   public QnaController() {
      System.out.println("===========> QnaController() 객체 생성");
   }
   
   @Autowired
   public QnaController(QnaService qnaService) {
      System.out.println("===========> QnaController(qnaService) 객체 생성");
      System.out.println("::: QnaService qnaService : " + qnaService);
      this.qnaService = qnaService;
   }
   @GetMapping("/faqQna.do")
   public String faqview() {
      return "qna/faq";
   }
   @RequestMapping("/getQnaList.do")
   public String getQnaList() {
       return "redirect:/getPagedQnaList.do?nowPage=1";
   }
   // 메소드 선언부에 선언된 @ModelAttribute 는 리턴된 데이터를 VIEW 에 전달
   // @ModelAttribute 선언된 메소드는 @RequestMapping 메소드보다 먼저 실행
   // 뷰에 전달될 때 설정된 명칭(예: conditionMap)
   @ModelAttribute("conditionMap")
   public Map<String, String> searchConditionMap() {
      System.out.println("====> Map searchConditionMap() 실행");
      Map<String, String> conditionMap = new HashMap<String, String>();
      conditionMap.put("제목", "QTITLE");
      conditionMap.put("내용", "CONTENT");
      return conditionMap;
   }
   
   //리턴타입 : ModelAndView ---> String
   @RequestMapping("/getQna.do")
   public String getQna(QnaVO qnavo, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
       System.out.println(">>> 게시글 상세 보여주기");
       System.out.println("qnavo : " + qnavo);

       MembersVO vo = (MembersVO) session.getAttribute("vo");
       System.out.println("members : " + vo);
       
       // DB에서 글 정보 가져오기
       QnaVO qna = qnaService.getQna(qnavo);
       System.out.println("qna : " + qna);

       if(vo == null) {
           // 로그인하지 않은 사용자는 로그인 페이지로 리다이렉트
           return "redirect:/login.do";
       }

       // 권한 확인
       if (!"Y".equals(qna.getSecret()) || vo.getStatus() == 0 || 
           (vo.getStatus() == 1 && vo.getMemberId().equals(qna.getMemberId()))) {
           // 비밀글이 아니거나, status가 0인 관리자거나, status가 1이면서 작성자와 로그인 아이디가 동일한 경우
          // 조회수 증가
           qna.setCnt(qna.getCnt() + 1);
           // 조회수 증가를 DB에 업데이트
           qnaService.increaseCnt(qna);
          
          model.addAttribute("qna", qna); //Model 객체 사용 View로 데이터 전달
           System.out.println("qna : " + qna);
           return "/qna/getQna";
       } else {
           // 그 외의 경우
           redirectAttributes.addFlashAttribute("message", "권한이 없습니다");
           return "redirect:getQnaList.do";
       }
   }

    @RequestMapping("/searchQnaList.do")
    public String searchQnaList(Model model, QnaVO vo) {
        List<QnaVO> qnaList = qnaService.getSearchedQnaList(vo);
        model.addAttribute("qnaList", qnaList);
        return "redirect:/getPagedQnaList.do?nowPage=1";
    }

    @RequestMapping("/getPagedQnaList.do")
    public String getPagedQnaList(Model model, PageVO page, 
            @RequestParam(value = "nowPage", defaultValue = "1") int nowPage,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            @RequestParam(value = "searchCondition", required = false) String searchCondition) {
       // 검색 조건과 검색 키워드를 맵에 추가
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("searchCondition", searchCondition);
        searchMap.put("searchKeyword", searchKeyword);

        // 검색 조건과 검색 키워드에 따른 전체 레코드 수 가져오기
        page.setTotalRecord(qnaService.getTotalRecordCount(searchMap));
        page.setNowPage(nowPage);
        System.out.println("page :  " + page);

        // 페이징 정보를 맵에 추가
        Map<String, Object> map = new HashMap<>();
        map.put("begin", page.getBegin());
        map.put("end", page.getEnd());
        map.putAll(searchMap);  // 검색 조건과 검색 키워드 추가

        // 페이징 처리된 QnA 리스트 가져오기
        List<QnaVO> qnaList = qnaService.getPagedQnaList(map);

        // 모델에 추가하기
        model.addAttribute("qnaList", qnaList);
        model.addAttribute("page", page);
        return "qna/getPagedQnaList";
    }
   
   @PostMapping("/insertQna.do")
   public String insertQna(QnaVO vo) throws IllegalStateException, IOException {
      System.out.println(">>> 게시글 입력");
      System.out.println("vo : " + vo);
      MultipartFile uploadFile= vo.getUploadFile();
      System.out.println("> uploadFile : " + uploadFile);
      
      if (uploadFile == null) {
         System.out.println("::: uploadFile 파라미터가 전달되지 않은 경우");
      } else if (uploadFile.isEmpty()) {
         System.out.println("::: 전달받은 파일 데이터가 없는 경우");
      } else {
         System.out.println("업로드 성공");
         String filename= uploadFile.getOriginalFilename();
         System.out.println("::: 원본파일명 : " + filename);
         String savedFilename = UUID.randomUUID().toString();
         System.out.println("::: 저장파일명 : " + savedFilename);
         
         //물리적 파일 복사
         String destPathFile = "C:/MyStudy/temp/" + savedFilename;
         uploadFile.transferTo(new File(destPathFile));
      }
      
      if ("Y".equals(vo.getSecret())) {
           vo.setSecret("Y");
       } else {
           vo.setSecret("N");
       }
      qnaService.insertQna(vo);
      
      return "redirect:/getPagedQnaList.do?nowPage=1";
   }
   
   @GetMapping("/insertQna.do")
   public String insertQnaview(HttpSession session, Model model) {
	   MembersVO vo = (MembersVO) session.getAttribute("vo");
	   model.addAttribute("vo", vo);
      return "/qna/insertQna";
   }
   
   // @ModelAttribute("board") : @SessionAttributes 설정으로 존재하는 "board" 데이터 사용
   @RequestMapping("/updateQna.do")
   public String updateQna(@ModelAttribute("qna") QnaVO vo2, HttpSession session, RedirectAttributes redirectAttributes) {
      System.out.println(">>> 게시글 수정");
      System.out.println("vo : " + vo2);
      
      MembersVO vo = (MembersVO) session.getAttribute("vo");
       System.out.println("members : " + vo);

       // 권한 확인
       if (vo.getStatus() == 0 || (vo.getStatus() == 1 && vo.getMemberId().equals(vo.getMemberId()))) {
           // status가 0인 관리자거나, status가 1이면서 작성자와 로그인 아이디가 동일한 경우
           qnaService.updateQna(vo2);
           return "redirect:getPagedQnaList.do?nowPage=1";
       } else {
           // 그 외의 경우
           redirectAttributes.addFlashAttribute("message", "권한이 없습니다");
           return "redirect:getPagedQnaList.do?nowPage=1";
       }
   }
   
   @RequestMapping("/deleteQna.do")
   public String deleteQna(QnaVO vo2, HttpSession session, SessionStatus sessionStatus, RedirectAttributes redirectAttributes) {
      System.out.println(">>> 게시글 삭제");
      System.out.println("vo : " + vo2);
      
      MembersVO vo = (MembersVO) session.getAttribute("vo");
       System.out.println("members : " + vo);

       // 권한 확인
       if (vo.getStatus() == 0 || (vo.getStatus() == 1 && vo.getMemberId().equals(vo2.getMemberId()))) {
           // status가 0인 관리자거나, status가 1이면서 작성자와 로그인 아이디가 동일한 경우
           qnaService.deleteQna(vo2);
           sessionStatus.setComplete();
           return "redirect:getPagedQnaList.do?nowPage=1";
       } else {
           // 그 외의 경우
           redirectAttributes.addFlashAttribute("message", "권한이 없습니다");
           return "redirect:getPagedQnaList.do?nowPage=1";
       }
   }
}