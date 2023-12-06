package com.spring.ft.sub.impl;

import java.util.Calendar;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.ft.sub.SubService;

@Service("subService")
public class SubServiceImpl implements SubService {
	
	@Autowired
	private SubDAO subDAO;
	
	public SubServiceImpl() {}
	
	public SubServiceImpl(SubDAO subDAO) {
		this.subDAO = subDAO;
	}
	
	@Override
	public int getMySubCount(Map<String, String> map) {
		return subDAO.getMySubCount(map);
	}
	@Override
	public int getMySubCountOne(Map<String, String> map) {
		return subDAO.getMySubCountOne(map);
	}
	
	@Override
	public int getAllSubCount(String memberId) {
		return subDAO.getAllSubCount(memberId);
	}
	
}
