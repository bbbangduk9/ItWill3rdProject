package com.spring.ft.sub;

import java.util.Map;

public interface SubService {
	
	int getMySubCount(Map<String, String> map);
	int getMySubCountOne(Map<String, String> map);
	
	int getAllSubCount(String memberId);
}
