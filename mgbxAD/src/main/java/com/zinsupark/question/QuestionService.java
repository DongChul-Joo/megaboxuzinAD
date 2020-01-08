package com.zinsupark.question;

import java.util.List;
import java.util.Map;

public interface QuestionService {
	
	public void insertQuestion(Question dto, String mode) throws Exception;
	public void insertQuestionAnswer(Question dto, String mode) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Question> listQuestion(Map<String, Object> map);
	public List<Question> relationQuestion(int num);
	
	public Question readQuestion1(int code);
	public Question readQuestion2(int code);
	
	public void updateQuestionQisanswer(Map<String, Object> map) throws Exception;
	public void updateQuestion(Question dto) throws Exception;
	public void deleteQuestion(int num) throws Exception;
	public List<Question> listCategory(Map<String, Object> map);

}
