package com.idol.model;

import java.util.List;

public interface MusicDAO {

	MusicDTO getMusicCont(int no);

	List<MusicDTO> getMusicList_group(String group);

	List<MusicDTO> getMusicList_solo(String name);

	List<MusicDTO> musicSearch(String name);

	List<MusicDTO> getAllList();

	List<MusicDTO> getAlbumList_group(String group_name);

	List<MusicDTO> getAlbumList_solo(String celeb_name);

}
