package com.ruoyi.project.system.util;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Objects;

/**
 * 加密工具类
 */
@Slf4j
public class CoinpayEncrypt {

    public static final String ALGORITHM_SHA = "SHA";
    public static final String ALGORITHM_MD5 = "MD5";
    public static final String ALGORITHM_MAC = "HmacMD5";
    public static final String ALGORITHM_AES = "AES";

    /**
     * sun不推荐使用它们自己的base64,用apache的挺好
     * BASE64解密
     */
    public static byte[] decryptBASE64(String dest) {
        if (StringUtils.isBlank(dest)) {
            return null;
        }
        return Base64.decodeBase64(dest);
    }

    /**
     * BASE64加密
     */
    public static String encryptBASE64(byte[] origin) {
        if (origin == null) {
            return null;
        }
        return Base64.encodeBase64String(origin);
    }

    /**
     * MD5加密
     *
     * @throws NoSuchAlgorithmException
     */
    public static byte[] encryptMD5(byte[] data)
            throws NoSuchAlgorithmException {
        if (data == null) {
            return null;
        }
        MessageDigest md5 = MessageDigest.getInstance(ALGORITHM_MD5);
        md5.update(data);
        return md5.digest();
    }

    /**
     * SHA加密
     *
     * @throws NoSuchAlgorithmException
     */
    public static byte[] encryptSHA(byte[] data)
            throws NoSuchAlgorithmException {
        if (data == null) {
            return null;
        }
        MessageDigest sha = MessageDigest.getInstance(ALGORITHM_SHA);
        sha.update(data);
        return sha.digest();
    }

    /**
     * 初始化HMAC密钥
     *
     * @throws NoSuchAlgorithmException
     */
    public static String initMacKey() throws NoSuchAlgorithmException {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGORITHM_MAC);
        SecretKey secretKey = keyGenerator.generateKey();
        return encryptBASE64(secretKey.getEncoded());
    }

    /**
     * HMAC加密
     *
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeyException
     */
    public static String encryptHMAC(byte[] data, String key)
            throws NoSuchAlgorithmException, InvalidKeyException {
        SecretKey secretKey = new SecretKeySpec(Objects.requireNonNull(decryptBASE64(key)),
                ALGORITHM_MAC);
        Mac mac = Mac.getInstance(secretKey.getAlgorithm());
        mac.init(secretKey);
        byte[] bytes = mac.doFinal(data);
        return Base64.encodeBase64String(bytes);

    }

    /**
     * 加密字符串
     *
     * @param content  原始字符串
     * @param password 密钥
     * @return 加密内容base64编码之后字符串
     * @throws Exception
     */
    public static String encryptAES(String content, String password) {
        if (password == null) {
            log.error("Password为空null");
            return null;
        }
        // 判断Key是否为16位
        if (password.length() != 16) {
            log.error("Password长度不是16位");
            return null;
        }
        try {
            byte[] raw = password.getBytes(StandardCharsets.UTF_8);
            SecretKeySpec skeySpec = new SecretKeySpec(raw, ALGORITHM_AES);
            //"算法/模式/补码方式"
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
            byte[] encrypted = cipher.doFinal(content.getBytes(StandardCharsets.UTF_8));
            //此处使用BASE64做转码功能，同时能起到2次加密的作用。
            return encryptBASE64(encrypted);
        } catch (Exception e) {
            log.error("AES 加密失败", e);
        }
        return null;
    }

    /**
     * 解密字符串
     *
     * @param base64Str base64编码后的加密内容
     * @param password  密钥
     * @return
     * @throws Exception
     */
    public static String decryptAES(String base64Str, String password) {
        try {
            // 判断Key是否正确
            if (password == null) {
                log.error("Password为空null");
                return null;
            }
            // 判断Key是否为16位
            if (password.length() != 16) {
                log.error("Password长度不是16位");
                return null;
            }
            byte[] raw = password.getBytes(StandardCharsets.UTF_8);
            SecretKeySpec skeySpec = new SecretKeySpec(raw, ALGORITHM_AES);
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, skeySpec);
            //先用base64解密
            byte[] encrypted = decryptBASE64(base64Str);
            try {
                assert encrypted != null;
                byte[] original = cipher.doFinal(encrypted);
                return new String(original, StandardCharsets.UTF_8);
            } catch (Exception e) {
                log.error("AES 解密失败1", e);
                return null;
            }
        } catch (Exception ex) {
            log.error("AES 解密失败2", ex);
            return null;
        }
    }

    /**
     * 对open-api的参数值使用appSecret通过HmacMD5加密后进行2次base64加密
     *
     * @param src       参数值拼接起来的字符串
     * @param appSecret 商户app私钥
     * @return
     * @throws InvalidKeyException
     * @throws NoSuchAlgorithmException
     */
    public static String signParameters(String src, String appSecret) throws InvalidKeyException, NoSuchAlgorithmException {
        // 签名前
        log.info("签名前字符串：{}", src);
        // 签名后
        String signStr = Base64.encodeBase64String(encryptHMAC(src.getBytes(), appSecret).getBytes());
        log.info("签名后字符串：{}", signStr);
        return signStr;
    }

    public static void main(String[] args) throws Exception {
        String data = "a12A_1111111qwert(*&";
        System.out.println(encryptBASE64(data.getBytes()));
        System.out.println(new String(Objects.requireNonNull(decryptBASE64(encryptBASE64(data.getBytes())))));

        System.out.println(new BigInteger(encryptMD5(data.getBytes())));
        System.out.println(new BigInteger(encryptSHA(data.getBytes())));
        System.out.println(new BigInteger(encryptHMAC(data.getBytes(), initMacKey())));
    }

}
