package com.ruoyi.project.system.util;

import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;

public class GoogleAuthUtil {

    /**
     * 生成密钥
     *
     * @return
     */
    public static String generateSecretKey() {
        GoogleAuthenticator gAuth = new GoogleAuthenticator();
        final GoogleAuthenticatorKey key = gAuth.createCredentials();
        String keyStr = key.getKey();
        return keyStr;
    }

    /**
     * 生成二维码
     * @param secret
     * @param account
     * @param issuer
     * @return
     */
	/*public static String createGoogleAuthQRCodeData(String secret, String account, String issuer) {
	    String qrCodeData = "otpauth://totp/%s?secret=%s&issuer=%s";
	    try {
	        return String.format(qrCodeData, URLEncoder.encode(issuer + ":" + account, "UTF-8").replace("+", "%20"), URLEncoder.encode(secret, "UTF-8")
	                .replace("+", "%20"), URLEncoder.encode(issuer, "UTF-8").replace("+", "%20"));
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }
	    return "";
	}*/

    /**
     * 校验code值是否正确
     *
     * @param secret
     * @param code
     * @return
     */
    public static boolean checkCode(String secret, int code) {
        GoogleAuthenticator gAuth = new GoogleAuthenticator();
        boolean isCodeValid = gAuth.authorize(secret, code);
        return isCodeValid;
    }

    public static String getQRBarcodeURL(String user, String host, String secret) {
        String format = "https://chart.googleapis.com/chart?chs=200x200&chld=M%%7C0&cht=qr&chl=otpauth://totp/%s@%s%%3Fsecret%%3D%s";
        return String.format(format, user, host, secret);
    }
}
