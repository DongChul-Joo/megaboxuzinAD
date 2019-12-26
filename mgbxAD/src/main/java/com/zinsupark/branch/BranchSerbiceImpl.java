package com.zinsupark.branch;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zinsupark.common.FileManager;
import com.zinsupark.common.dao.CommonDAO;

@Service("branch.branchService")
public class BranchSerbiceImpl implements BranchService {
	@Autowired
	CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public List<Branch> listArea() throws Exception {
		List<Branch> list=null;
		try {
			list=dao.selectList("branch.listArea");
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public void insertBranch(Branch dto,String pathname) throws Exception{
		try {
			if(! dto.getUpload().isEmpty()) {
				String imageFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
				dto.setImageFilename(imageFilename);
		}
			dao.insertData("branch.insertBranch", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public List<Branch> listBranch(Map<String,Object> map) throws Exception {
		List<Branch> list = null;
		try {
			list=dao.selectList("branch.listBranch",map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Branch readBranch(int branCode) throws Exception {
		Branch dto=null;
		try {
			dto=dao.selectOne("branch.readBranch",branCode);
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

	@Override
	public void updateBranch(Branch dto, String pathname) throws Exception {
		try {
			if(! dto.getUpload().isEmpty()) {
				fileManager.doFileDelete(dto.getImageFilename(), pathname);
				String imageFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
				dto.setImageFilename(imageFilename);
		}
			dao.updateData("branch.updateBranch",dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public int branchCount(Map<String, Object> map) throws Exception {
		int result=0;
		try {
			result=dao.selectOne("branch.branchCount",map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}
	
	

	
	
	

}
