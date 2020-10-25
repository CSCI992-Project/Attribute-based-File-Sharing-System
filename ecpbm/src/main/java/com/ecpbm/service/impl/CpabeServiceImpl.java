package com.ecpbm.service.impl;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ecpbm.bswabe.Bswabe;
import com.ecpbm.bswabe.BswabeCph;
import com.ecpbm.bswabe.BswabeCphKey;
import com.ecpbm.bswabe.BswabeElementBoolean;
import com.ecpbm.bswabe.BswabeMsk;
import com.ecpbm.bswabe.BswabePrv;
import com.ecpbm.bswabe.BswabePub;
import com.ecpbm.bswabe.SerializeUtils;
import com.ecpbm.service.AESCoderService;
import com.ecpbm.service.CommonService;
import com.ecpbm.service.CpabeService;
import com.ecpbm.service.LangPolicyService;

import it.unisa.dia.gas.jpbc.Element;

@Service("cpabeService")
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
public class CpabeServiceImpl implements CpabeService{
	@Autowired
	private LangPolicyService langPolicyService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private AESCoderService aesCoderService;
	
	@Override
	public void setup(String pubfile, String mskfile) throws IOException {
		// TODO Auto-generated method stub
		byte[] pub_byte, msk_byte;
		BswabePub pub = new BswabePub();
		BswabeMsk msk = new BswabeMsk();
		Bswabe.setup(pub, msk);
		
		/* store BswabePub into mskfile */
		pub_byte = SerializeUtils.serializeBswabePub(pub);
		commonService.spitFile(pubfile, pub_byte);

		/* store BswabeMsk into mskfile */
		msk_byte = SerializeUtils.serializeBswabeMsk(msk);
		commonService.spitFile(mskfile, msk_byte);
		
	}

	@Override
	public byte[] keygen(String pubfile, String mskfile, String attr_str) throws IOException, NoSuchAlgorithmException {
		// TODO Auto-generated method stub
		BswabePub pub;
		BswabeMsk msk;
		byte[] pub_byte, msk_byte, prv_byte;
		
		/* get BswabePub from pubfile */
		pub_byte = commonService.suckFile(pubfile);
		pub = SerializeUtils.unserializeBswabePub(pub_byte);
		
		/* get BswabeMsk from mskfile */
		msk_byte = commonService.suckFile(mskfile);
		msk = SerializeUtils.unserializeBswabeMsk(pub, msk_byte);
		
		/* store BswabePrv into prvfile */
		String[] attr_arr = langPolicyService.parseAttribute(attr_str);
		BswabePrv prv = Bswabe.keygen(pub, msk, attr_arr);
		
		/* store BswabePrv into prvfile */
		prv_byte = SerializeUtils.serializeBswabePrv(prv);
		return prv_byte;
	}

	@Override
	public void enc(String pubfile, String policy, String inputfile, String encfile) throws Exception {
		// TODO Auto-generated method stub
		BswabePub pub;
		BswabeCph cph;
		BswabeCphKey keyCph;
		byte[] plt;
		byte[] cphBuf;
		byte[] aesBuf;
		byte[] pub_byte;
		Element m;
		
		/* get BswabePub from pubfile */
		pub_byte = commonService.suckFile(pubfile);
	
		pub = SerializeUtils.unserializeBswabePub(pub_byte);
		
		keyCph = Bswabe.enc(pub, policy);
		cph = keyCph.cph;
		m = keyCph.key;
		System.err.println("m = " + m.toString());
		
		if (cph == null) {
			System.out.println("Error happed in enc");
			System.exit(0);
		}
		
		cphBuf = SerializeUtils.bswabeCphSerialize(cph);
		
		/* read file to encrypted */
		plt = commonService.suckFile(inputfile);
		aesBuf = aesCoderService.encrypt(m.toBytes(), plt);
		
		commonService.writeCpabeFile(encfile, cphBuf, aesBuf);
		
	}

	@Override
	public void dec(String pubfile, byte[] prvfile, String encfile, String decfile) throws Exception {
		// TODO Auto-generated method stub
		byte[] aesBuf, cphBuf;
		byte[] plt;
		byte[] prv_byte;
		byte[] pub_byte;
		byte[][] tmp;
		BswabeCph cph;
		BswabePrv prv;
		BswabePub pub;

		/* get BswabePub from pubfile */
		pub_byte = commonService.suckFile(pubfile);
		pub = SerializeUtils.unserializeBswabePub(pub_byte);
		
		/* read ciphertext */
		tmp = commonService.readCpabeFile(encfile);
		aesBuf = tmp[0];
		cphBuf = tmp[1];
		cph = SerializeUtils.bswabeCphUnserialize(pub, cphBuf);
		
		/* get BswabePrv form prvfile */
		prv_byte = prvfile;
		prv = SerializeUtils.unserializeBswabePrv(pub, prv_byte);
		
		BswabeElementBoolean beb = Bswabe.dec(pub, prv, cph);
		
		
		if (beb.b) {
			System.err.println("e = " + beb.e.toString());
			plt = aesCoderService.decrypt(beb.e.toBytes(), aesBuf);
			commonService.spitFile(decfile, plt);
		} else {
			System.out.println("function(dec) error!");
			//System.exit(0);
		}
	}

}
