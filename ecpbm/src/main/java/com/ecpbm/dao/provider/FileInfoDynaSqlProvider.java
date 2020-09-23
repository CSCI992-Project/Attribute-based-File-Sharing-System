package com.ecpbm.dao.provider;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.jdbc.SQL;

import com.ecpbm.pojo.FileInfo;

public class FileInfoDynaSqlProvider {
	//分页动态查询
		public String selectWithParam(Map<String, Object> params) {
			String sql = new SQL() {
				{
					SELECT("*");
					FROM("file_info f");
					LEFT_OUTER_JOIN("user_info uf on f.user_id = uf.id");
					LEFT_OUTER_JOIN("file_att ft on f.id = ft.file_id");
					LEFT_OUTER_JOIN("attribute a on ft.attribute_id = a.attribute_id");
					LEFT_OUTER_JOIN("category c on ft.category_id = c.category_id");
					if (params.get("fileInfo") != null ) {
						FileInfo fileInfo = (FileInfo) params.get("fileInfo");
						if (fileInfo.getFile_title() != null && !fileInfo.getFile_title().equals("")) {
							WHERE(" file_title LIKE CONCAT ('%',#{fileInfo.file_title},'%') ");
						}
					}

					
				}
			}.toString();
			if (params.get("pager") != null) {
				sql += " limit #{pager.firstLimitParam} , #{pager.perPageRows }";
			}
			return sql;
			
		}
		
		//根据条件动态查询总记录条数
		public String count(Map<String, Object> params) {
			return new SQL() {
				{
					SELECT("count(*)");
					FROM("file_info");
					if (params.get("fileInfo") != null) {
						FileInfo fileInfo = (FileInfo) params.get("fileInfo");
						if (fileInfo.getFile_title() != null && !fileInfo.getFile_title().equals("")) {
							WHERE(" file_title LIKE CONCAT ('%',#{fileInfo.file_title},'%') ");
						}
					}
				}
			}.toString();
			
		}
		
		public String selectByUserIdWithParam(Map<String, Object> params,  @Param("uid")Integer userId) {
			String sql = new SQL() {
				{
					SELECT("*");
					FROM("file_info f");
					LEFT_OUTER_JOIN("user_info uf on f.user_id = uf.id");
					LEFT_OUTER_JOIN("file_att ft on f.id = ft.file_id");
					LEFT_OUTER_JOIN("attribute a on ft.attribute_id = a.attribute_id");
					LEFT_OUTER_JOIN("category c on ft.category_id = c.category_id");
					WHERE(" user_id = #{uid} ");
				}
			}.toString();
			if (params.get("pgper") != null) {
				sql += " limit #{pager.firstLimitParam} , #{pager.perPageRows }";
			}
			return sql;
			
		}
		
		//delete file info by file id
		public String deleteFileInfo(Integer id) {
			return new SQL() {
				{
					DELETE_FROM("file_info");
					if (id !=null) {
						WHERE("id = #{id}");
					}
				}
			}.toString();
		}
		
}
