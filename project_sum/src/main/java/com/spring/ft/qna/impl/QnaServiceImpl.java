package com.spring.ft.qna.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.ft.qna.QnaService;
import com.spring.ft.qna.QnaVO;

// @Service : @Component 상속 확장 어노테이션
//		비즈니스 로직 처리 서비스 영역에 사용
@Service("qnaService")
public class QnaServiceImpl implements QnaService {
	@Autowired //타입이 일치하는 객체(인스턴스) 주입
	private QnaDAO qnaDAO;

	public QnaServiceImpl() {
		System.out.println(">> QnaServiceImpl() 객체 생성");
	}
	
	@Override
	public void insertQna(QnaVO vo) {
		qnaDAO.insertQna(vo);
	}

	@Override
	public void updateQna(QnaVO vo) {
		qnaDAO.updateQna(vo);
	}

	@Override
	public void deleteQna(QnaVO vo) {
		qnaDAO.deleteQna(vo);
	}
	
	@Override
	public QnaVO getQna(QnaVO vo) {
		return qnaDAO.getQna(vo);
	}

    @Override
    public List<QnaVO> getSearchedQnaList(QnaVO vo) {
        return qnaDAO.getSearchedQnaList(vo);
    }

//    @Override
//    public int getTotalRecordCount() {
//        return qnaDAO.getTotalRecordCount();
//    }

//    @Override
//    public List<QnaVO> getPagedQnaList(PageVO page) {
//        return qnaDAO.getPagedQnaList(page);
//    }
	@Override
	public void increaseCnt(QnaVO vo) {
	   qnaDAO.increaseCnt(vo);
	}

	@Override
	public List<QnaVO> getPagedQnaList(Map<String, Object> map) {
	    System.out.println("===> MyBatis JDBC로 getPagedQnaList() 실행");
	    return qnaDAO.getPagedQnaList(map);
	}

	@Override
	public int getTotalRecordCount(Map<String, String> map) {
		return qnaDAO.getTotalRecordCount(map);
	}
	

}
