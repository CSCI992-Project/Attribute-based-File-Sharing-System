package com.ecpbm.service;

public interface AESCoderService {
	public byte[] getRawKey(byte[] seed) throws Exception;
	
	public byte[] encrypt(byte[] seed, byte[] plaintext) throws Exception;
	
	public byte[] decrypt(byte[] seed, byte[] ciphertext) throws Exception;
}
