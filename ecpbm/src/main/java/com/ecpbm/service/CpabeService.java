package com.ecpbm.service;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

public interface CpabeService {
	//generate public key and master key at the first time
	public void setup(String pubfile, String mskfile) throws IOException;
	
	//generate private key by att and return public key byte[]
	public byte[] keygen(String pubfile, String mskfile, String attr_str) throws IOException, NoSuchAlgorithmException;
	
	//encrypt the file
	public void enc(String pubfile, String policy, String inputfile,
			String encfile) throws Exception;
	
	//decrypt the file
	public void dec(String pubfile, String prvfile, String encfile,
			String decfile) throws Exception;
}
