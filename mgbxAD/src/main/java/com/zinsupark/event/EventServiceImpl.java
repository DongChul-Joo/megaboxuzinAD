package com.zinsupark.event;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zinsupark.common.FileManager;
import com.zinsupark.common.dao.CommonDAO;

@Service("event.eventService")
public class EventServiceImpl implements EventService{
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertEvent(Event dto, String pathname) throws Exception {
		try {
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setImageFilename(saveFilename);
				
				dao.insertData("event.insertEvent", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list=null;
		
		try {
			list=dao.selectList("event.listEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("event.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public Event readEvent(int num) {
		Event dto=null;
		
		try {
			dto=dao.selectOne("event.readEvent", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	// 이벤트 수정
	@Override
	public void updateEvent(Event dto, String pathname) throws Exception {
		try {
			// 업로드한 파일이 존재한 경우
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			
			if (saveFilename != null) {
			// 이전 파일 지우기	
				if(dto.getImageFilename().length()!=0) {
					fileManager.doFileDelete(dto.getImageFilename(), pathname);
				}
				dto.setImageFilename(saveFilename);
			}
			dao.updateData("event.updateEvent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	@Override
	public void deleteEvent(int num, String pathname, String userId) throws Exception {
		try {
			Event dto=readEvent(num);
			
			if(dto.getImageFilename()!=null)
				fileManager.doFileDelete(dto.getImageFilename(), pathname);
			
			// 게시물지우기
			dao.deleteData("event.deleteEvent", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	@Override
	public List<Event> listCategory() {
		List<Event> list=null;
		try {
			list=dao.selectList("event.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 이벤트 추첨 완료 리스트
	@Override
	public List<Event> listDott(Map<String, Object> map) {
		List<Event> list=null;
		try {
			list=dao.selectList("event.listDott", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	// 이벤트 추첨 완료 개수
	@Override
	public int DottCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("event.dottCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	// 이벤트 당첨자 리스트
	@Override
	public List<Event> selectListPic(Map<String, Object> map) {
		List<Event> list=null;
		
		try {

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 이벤트 추첨 저장
	@Override
	public Map<String, Object> insertEventPic(int ecode) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ecode", ecode);
		
		try {
			int cnt = dao.selectOne("event.selectPickCount", map);
			if(cnt>0) {
				new Exception("당첨자 처리가 이미 끝났습니다.");
			}
			
			List<Event> list = dao.selectList("event.selectRequestPick", map);
			for(Event evt : list) {
				map.put("userId", evt.getUserId());
				
				dao.insertData("event.insertPic", map);
			}
		} catch (Exception e) {
			throw e;
		}
		return map;
	}
	@Override
	public void insertEventPic(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("event.insertEventPic", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
