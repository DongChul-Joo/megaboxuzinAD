package com.zinsupark.event;

import java.util.List;
import java.util.Map;

public interface EventService {
	public void insertEvent (Event dto, String pathname) throws Exception;
	public List<Event> listEvent(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Event readEvent(int num);
	public void updateEvent(Event dto, String pathname) throws Exception;
	public void deleteEvent(int num, String pathname, String userId) throws Exception;
	
	public void insertCategory(Map<String, Object> map) throws Exception;
	public void updateCategory(Map<String, Object> map) throws Exception;
	public List<Event> listCategory(Map<String, Object> map);
	public void deleteCategory(int categoryNum) throws Exception;
}
