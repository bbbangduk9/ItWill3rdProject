package com.spring.ft.sub.impl;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SubDAO {

	private SqlSessionTemplate mybatis;

	public SubDAO() {}
	
	@Autowired
	public SubDAO(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	public int getMySubCount(Map<String, String> map) {
		return mybatis.selectOne("subDAO.getMySubCount", map);
	}
	
	public int getMySubCountOne(Map<String, String> map) {
		return mybatis.selectOne("subDAO.getMySubCountOne", map);
	}
	
	public int getAllSubCount(String memberId) {
		return mybatis.selectOne("subDAO.getAllSubCount", memberId);
	}
	
}
