package com.idol.model;

import java.util.List;

public interface GroupDAO {

	GroupDTO getGroupInfo(String celeb_group);

	List<GroupDTO> searchGroup(String group);
}
