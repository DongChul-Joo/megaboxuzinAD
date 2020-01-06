package com.zinsupark.event;

import java.util.List;
import java.util.Map;

public interface EventService {
	public void insertEvent (Event dto, String pathname) throws Exception;
	public List<Event> listEvent(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public void eventRequest(Event dto) throws Exception;
	public void eventPic(Event dto) throws Exception;
	
	public Event readEvent(int num);
	public void updateEvent(Event dto, String pathname) throws Exception;
	public void deleteEvent(int num, String pathname, String userId) throws Exception;
	public List<Event> listCategory();
	
	public List<Event> listDott(Map<String, Object> map);
	public int DottCount(Map<String, Object> map);
	
	
}
