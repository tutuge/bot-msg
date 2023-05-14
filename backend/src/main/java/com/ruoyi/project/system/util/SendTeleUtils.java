package com.ruoyi.project.system.util;

public class SendTeleUtils {
    public static void sendMsg(String msg, String key) {
        String url = "https://api.telegram.org/bot" + key + "/sendMessage" + msg;
        try {
            String result = HttpClientUtils.get(url);
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
