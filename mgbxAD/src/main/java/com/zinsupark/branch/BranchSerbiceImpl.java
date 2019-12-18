package com.zinsupark.branch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zinsupark.common.dao.CommonDAO;

@Service("branch.branchService")
public class BranchSerbiceImpl implements BranchService{
	@Autowired
	CommonDAO dao;
	
	@Override
	public List<Branch> listArea() {
		List<Branch> list=null;
		try {
			list=dao.selectList("branch.listArea");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
	
	

}
