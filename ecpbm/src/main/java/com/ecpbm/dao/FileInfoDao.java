package com.ecpbm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.DeleteProvider;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import com.ecpbm.dao.provider.FileInfoDynaSqlProvider;
import com.ecpbm.dao.provider.UserInfoDynaSqlProvider;
import com.ecpbm.pojo.FileInfo;
import com.ecpbm.pojo.UserInfo;

public interface FileInfoDao {
	
	//分页获取文件信息
	@SelectProvider(type = FileInfoDynaSqlProvider.class, method = "selectWithParam")
	List<FileInfo> selectByPage(Map<String, Object> params);
	
	//查询文件总数
	@SelectProvider(type = FileInfoDynaSqlProvider.class, method = "count")
	Integer count(Map<String, Object> params);
	
	//分页获取个人文件信息
	@SelectProvider(type = FileInfoDynaSqlProvider.class, method = "selectByUserIdWithParam")
	List<FileInfo> selectByUserId(Map<String, Object> params,  @Param("uid")Integer userId);
	
	//获取个人文件总数
	@Select("select count(*) from file_info where user_id = #{userId}")
	Integer counByUserId(Integer userId);
	
	//select file id by title
	@Select("select id from file_info where file_title = #{file_title}")
	Integer findFileIdByTitle(String file_title);
	
	//select file path by id
	@Select("select file_path from file_info where id = #{id}")
	String findFilePathById(Integer id);
	
	//add file
	@Insert("insert into file_info(file_title,file_describe,user_id,file_path) "
			+ "values(#{file_title},#{file_describe},#{user_id},#{file_path})")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	void add(FileInfo fi);
	@Insert("insert into file_att(file_id,category_id,attribute_id)"
			+ "values(#{fid},#{cid},#{aid})")
	void addAttributes(@Param("fid")Integer fid, @Param("cid")Integer cid, @Param("aid")Integer aid);
	
	//delete file
	@DeleteProvider(type = FileInfoDynaSqlProvider.class, method = "deleteFileInfo")
	void deleteFileInfo(Integer id);
	
	//update user information
	@Update("update file_info set file_title=#{file_title},file_describe=#{file_describe},file_path=#{file_path} where id=#{file_id}")
	void edit(FileInfo fi);
	@Update("update file_att set category_id=#{category_id},attribute_id=#{attribute_id} where file_id=#{file_id}")
	void updateAtt(FileInfo fi);
}
