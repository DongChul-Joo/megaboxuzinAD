package com.zinsupark.item;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zinsupark.common.FileManager;
import com.zinsupark.common.dao.CommonDAO;

@Service("item.ItemServiceImpl")
public class ItemServiceImpl implements ItemService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertItem(Item dto, String pathname) throws Exception {
		try {
			if(! dto.getUpload().isEmpty()) {
					String itemImg = fileManager.doFileUpload(dto.getUpload(), pathname);
					dto.setItemImg(itemImg);
			}
			dao.insertData("item.insertItem", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("item.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Item> listItem(Map<String, Object> map) {
		List<Item> list =null;
		
		try {
			list=dao.selectList("item.listItem", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateItem(Item dto, String pathname) throws Exception {
		try {
			String saveFileName = fileManager.doFileUpload(dto.getUpload(), pathname);
			
			if (saveFileName != null) {
				if(dto.getItemImg().length()!=0) {
					fileManager.doFileDelete(dto.getItemImg(), pathname);
				}
				dto.setItemImg(saveFileName);
			}
			dao.updateData("item.updateItem", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteItem(int itemCode, String pathname) throws Exception {
		try {
			Item dto = readItem(itemCode);
			
			
			if(dto.getItemImg()!=null)
				fileManager.doFileDelete(dto.getItemImg(), pathname);
			
			dao.deleteData("item.deleteItem", itemCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Item readItem(int itemCode) {
		Item dto = null;
		try {
			dto=dao.selectOne("item.readItem", itemCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
