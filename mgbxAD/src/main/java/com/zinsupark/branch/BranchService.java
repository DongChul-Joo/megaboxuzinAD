package com.zinsupark.branch;

import java.util.List;
import java.util.Map;

public interface BranchService {

	public List<Branch> listArea() throws Exception;
	public void insertBranch(Branch dto,String pathname) throws Exception;
	public List<Branch> listBranch(Map<String,Object> map) throws Exception;
	public Branch readBranch(int branCode) throws Exception;
	public void updateBranch(Branch dto,String pathname)throws Exception;
	public int branchCount(Map<String,Object> map) throws Exception;
}
