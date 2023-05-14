package com.ruoyi.common;

/**
 * 随机生成字符串工具类
 */
public class RandomUtil {

    public static String getStr() {
        return generateStr(6);
    }


    public static String getKey() {
        return generateStr(10);
    }

    private static String generateStr(int i) {
        String randomCode2 = "";
        String model = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        char[] m = model.toCharArray();
        for (int j = 0; j < i; j++) {
            char c = m[(int) (Math.random() * 52)];
            randomCode2 = randomCode2 + c;
        }
        return randomCode2;
    }
}
