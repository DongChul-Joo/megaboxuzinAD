package com.zinsupark.roto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zinsupark.common.dao.CommonDAO;

@Service("roto.rotoService")
public class RotoServiceImpl implements RotoService{
	@Autowired
	private CommonDAO dao;

	@Override
	public List<Roto> listRoto(Map<String, Object> map) {
		List<Roto> list=null;
		
		try {
			list=dao.selectList("roto.listRoto", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("roto.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public Roto readRoto(int num) {
			Roto dto=null;
			
			try {
				dto=dao.selectOne("roto.readRoto", num);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return dto;
	}
	
	@Override
	public void insertRoto(Roto dto) throws Exception {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ecode", dto.getEcode());
			insertEventPic(map);
			
			dao.insertData("roto.insertRoto", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
		
	@Override
	public List<Roto> listEventPic(Map<String, Object> map) {
		List<Roto> list=null;
		
		try {
			list = dao.selectList("roto.listEventPic", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertEventPic(Map<String, Object> map) throws Exception {
		try {
			int cnt = dao.selectOne("roto.eventPickCount", map);
			if(cnt>0) {
				new Exception("당첨자 처리가 이미 끝났습니다.");
			}
			
			List<Roto> list = dao.selectList("roto.listRequestPick", map);
			for(Roto evt : list) {
				map.put("userId", evt.getUserId());
				
				dao.insertData("roto.insertEventPic", map);
			}
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public int picCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("roto.eventPickCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


}
