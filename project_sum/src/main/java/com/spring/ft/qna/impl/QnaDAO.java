package com.spring.ft.qna.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.ft.qna.QnaVO;

@Repository
public class QnaDAO {
		
		@Autowired
		private SqlSessionTemplate mybatis;
	
		public QnaDAO() {
			System.out.println(">>> QnaDAO() 객체 생성");
		}
		@Autowired
		public QnaDAO(SqlSessionTemplate mybatis) {
			System.out.println(">>> QnaDAO(SqlSessionTemplate) 객체 생성");
			this.mybatis = mybatis;
		}
		
		//글입력
		public void insertQna(QnaVO vo) {
			System.out.println("===> mybatis JDBC로 insertQna() 실행");
			mybatis.insert("qnaDAO.insertQna", vo);
		}

		//글수정
		public void updateQna(QnaVO vo) {
			System.out.println("===> mybatis JDBC로 updateQna() 실행");
			mybatis.update("qnaDAO.updateQna", vo);
		}

		//글삭제
		public void deleteQna(QnaVO vo) {
			System.out.println("===> mybatis JDBC로 deleteQna() 실행");
			mybatis.delete("qnaDAO.deleteQna", vo);
		}

		//게시글 1개 조회
		public QnaVO getQna(QnaVO vo) {
			System.out.println("===> mybatis JDBC로 getQna() 실행");
			return mybatis.selectOne("qnaDAO.getQna",vo);
			
		}
		
	    // 검색 조건에 맞는 게시물 목록 조회
	    public List<QnaVO> getSearchedQnaList(QnaVO vo) {
	        System.out.println("===> MyBatis JDBC로 getSearchedQnaList() 실행");
	        if (vo.getSearchCondition() == null) {
	            vo.setSearchCondition("QTITLE");
	        }
	        if (vo.getSearchKeyword() == null) {
	            vo.setSearchKeyword("");
	        }
	        String sql = "";
	        if ("QTITLE".equals(vo.getSearchCondition())) {
	            sql = "qnaDAO.getSearchedQnaList_T";
	        } else if ("CONTENT".equals(vo.getSearchCondition())) {
	            sql = "qnaDAO.getSearchedQnaList_C";
	        }
	        return mybatis.selectList(sql, vo.getSearchKeyword());
	    }

	    // 전체 게시물 수 조회
	    public int getTotalRecordCount(Map<String, String> map) {
	        System.out.println("===> MyBatis JDBC로 getTotalRecordCount() 실행");
	        return mybatis.selectOne("qnaDAO.getTotalRecordCount", map);
	    }

	    // 페이지에 해당하는 게시물 목록 조회
	    public List<QnaVO> getPagedQnaList(Map<String, Object> map) {
	        System.out.println("===> MyBatis JDBC로 getPagedQnaList() 실행");
	        return mybatis.selectList("qnaDAO.getPagedQnaList", map);
	    }

		
		//조회수 조회
		public void increaseCnt(QnaVO vo) {
		    System.out.println("===> mybatis JDBC로 increaseCnt() 실행");
		    mybatis.update("qnaDAO.increaseCnt", vo);
		}

	}
