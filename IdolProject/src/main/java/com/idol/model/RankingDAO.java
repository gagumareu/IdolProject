package com.idol.model;

import java.util.HashMap;
import java.util.List;

public interface RankingDAO {
	
	/* **********************희원님 *************************/
	public List<RankingDTO> mostMessages(HashMap<String, String> map);

	public List<RankingDTO> mostMileage(HashMap<String, String> map);
	
	public List<MemberDTO> todayBirth(HashMap<String, String> map);
	
	public List<RankingDTO> mostPurchase(HashMap<String, String> map);
	
	public List<RankingDTO> mostReferrals(HashMap<String, String> map);
	
	public List<RankingDTO> mostComment(HashMap<String, String> map);
	
}
