package DAO;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncriptPassword {

	public static void main(String[] args) {

		 String data = "";
		         MessageDigest messageDigest;
		         try {
		             messageDigest = MessageDigest.getInstance("MD5");
		             messageDigest.update(data.getBytes());
		             byte[] messageDigestMD5 = messageDigest.digest();
		             StringBuffer stringBuffer = new StringBuffer();
		             for (byte bytes : messageDigestMD5) {
		                 stringBuffer.append(String.format("%02x", bytes & 0xff));
		             }
		             System.out.println("data:" + data);
		             System.out.println("digestedMD5(hex):" + stringBuffer.toString());
		         } catch (NoSuchAlgorithmException exception) {
		             exception.printStackTrace();
		         }
	}

}
