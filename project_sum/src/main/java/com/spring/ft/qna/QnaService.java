package com.spring.ft.qna;

import java.util.List;
import java.util.Map;

public interface QnaService {
	//CRUD 기능 구현 메소드 정의
	void insertQna(QnaVO vo);
	void updateQna(QnaVO vo);
	void deleteQna(QnaVO vo);
	void increaseCnt(QnaVO qna);
	QnaVO getQna(QnaVO vo);
    List<QnaVO> getSearchedQnaList(QnaVO vo);
    int getTotalRecordCount(Map<String, String> map);
	List<QnaVO> getPagedQnaList(Map<String, Object> map);
}
