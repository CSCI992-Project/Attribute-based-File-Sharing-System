package com.ecpbm.service;

import java.io.IOException;

public interface CommonService {
	public byte[] suckFile(String inputfile) throws IOException;
	
	public void spitFile(String outputfile, byte[] b) throws IOException;
	
	public void writeCpabeFile(String encfile, byte[] cphBuf, byte[] aesBuf) throws IOException;
	
	public byte[][] readCpabeFile(String encfile) throws IOException;
}
