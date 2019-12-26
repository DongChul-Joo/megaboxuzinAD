package com.zinsupark.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	public void insertNotice(Notice dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Notice> listNotice(Map<String, Object> map);
	
	public Notice readNotice(int code);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
	
	public void updateNotice(Notice dto, String pathname) throws Exception;
	public void deleteNotice(int code, String pathname) throws Exception;
	
	public void insertFile(Notice dto) throws Exception;
	public List<Notice> listFile(int code);
	public Notice readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
}
