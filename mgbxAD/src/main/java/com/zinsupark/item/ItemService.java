package com.zinsupark.item;

import java.util.List;
import java.util.Map;

public interface ItemService {
	public void insertItem(Item dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Item> listItem(Map<String, Object> map);
	public void updateItem(Item dto, String pathname) throws Exception;
	public void deleteItem(int itemCode, String pathname) throws Exception; 
	public Item readItem(int itemCode);
}
