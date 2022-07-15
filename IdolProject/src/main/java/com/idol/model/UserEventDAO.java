package com.idol.model;

import java.util.HashMap;
import java.util.List;

//희원님
public interface UserEventDAO {
	
	public int getListCount(HashMap<String, String> map);

	public List<EventDTO> eventList(HashMap<String, Object> map);

	public List<EventDTO> concertList(HashMap<String, Object> map);
	
	public List<EventDTO> allList();

	public void readCount(int no);

	public EventDTO eventCont(int no);
}
