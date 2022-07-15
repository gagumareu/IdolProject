package com.idol.model;

import java.util.List;

public interface CommunityDAO {

	List<CommunityDTO> getCommunityList(String id);
	int getCommTotalRecord(String id);
}
