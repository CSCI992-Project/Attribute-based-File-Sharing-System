package com.ecpbm.pojo;

import java.util.HashSet;
import java.util.Set;

public class Functions implements Comparable<Functions>{
	private int id;
	private String name;
	private int papentid;
	private boolean isleaf;
	//关联属性
	private Set uis = new HashSet();
	
	public Set getUis() {
		return uis;
	}
	public void setUis(Set uis) {
		this.uis = uis;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPapentid() {
		return papentid;
	}
	public void setPapentid(int papentid) {
		this.papentid = papentid;
	}
	public boolean isIsleaf() {
		return isleaf;
	}
	public void setIsleaf(boolean isleaf) {
		this.isleaf = isleaf;
	}
	
	@Override
	public int compareTo(Functions arg0) {
		// TODO Auto-generated method stub
		return ((Integer) this.getId()).compareTo((Integer) (arg0.getId()));
	}

}
