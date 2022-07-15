package com.idol.model;

import java.util.HashMap;
import java.util.List;

public interface OrderDAO {
	int addOrder(OrderDTO orderdto);

	List<OrderDTO> getOrderList(String member_id);

	List<String> getOrderDates(String login_id);
	List<String> getOrderDates(HashMap<String, Object> map);
	List getOrderDateList(HashMap<String, String> params);
	
	
	
	// 원석
	int newGroupNo();
	List<OrderDTO> getLastOrderList(String memid);

	OrderDTO getOrderCont(int parseInt);
	List<OrderDTO> getOrderGroup(int ogno);

	int deleteOgno(int ogno);

	int get3daysOrder(String member_id);

	
}
