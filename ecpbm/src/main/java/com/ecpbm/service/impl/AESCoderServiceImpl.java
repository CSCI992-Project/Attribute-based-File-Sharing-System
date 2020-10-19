package com.ecpbm.service.impl;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ecpbm.service.AESCoderService;

@Service("aesCoderService")
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
public class AESCoderServiceImpl implements AESCoderService{

	@Override
	public byte[] getRawKey(byte[] seed) throws Exception {
		// TODO Auto-generated method stub
		KeyGenerator kgen = KeyGenerator.getInstance("AES");
		SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
		sr.setSeed(seed);
		kgen.init(128, sr); // 192 and 256 bits may not be available
		SecretKey skey = kgen.generateKey();
		byte[] raw = skey.getEncoded();
		return raw;
	}

	@Override
	public byte[] encrypt(byte[] seed, byte[] plaintext) throws Exception {
		// TODO Auto-generated method stub
		byte[] raw = getRawKey(seed);
		SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
		Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
		byte[] encrypted = cipher.doFinal(plaintext);
		return encrypted;
	}

	@Override
	public byte[] decrypt(byte[] seed, byte[] ciphertext) throws Exception {
		// TODO Auto-generated method stub
		byte[] raw = getRawKey(seed);
		SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
		Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE, skeySpec);
		byte[] decrypted = cipher.doFinal(ciphertext);
		
		return decrypted;
	}

}
