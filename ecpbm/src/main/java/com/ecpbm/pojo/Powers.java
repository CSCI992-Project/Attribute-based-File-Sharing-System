package com.ecpbm.pojo;

public class Powers {
	private UserInfo ui;
	private Functions f;

	public UserInfo getUi() {
		return ui;
	}

	public void setAi(UserInfo ui) {
		this.ui = ui;
	}

	public Functions getF() {
		return f;
	}

	public void setF(Functions f) {
		this.f = f;
	}

	@Override
	public String toString() {
		return "Powers [ui=" + ui + ", f=" + f + "]";
	}
}
