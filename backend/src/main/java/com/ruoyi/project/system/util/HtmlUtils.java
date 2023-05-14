package com.ruoyi.project.system.util;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

public class HtmlUtils {

    /**
     *  读取本地html文件里的html代码
     * @return
     */
    public static String toHtmlString(File file) {
        // 获取HTML文件流
        StringBuilder htmlSb = new StringBuilder();
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    Files.newInputStream(file.toPath()), StandardCharsets.UTF_8));
            while (br.ready()) {
                htmlSb.append(br.readLine());
            }
            br.close();
            // 删除临时文件
            //file.delete();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // HTML文件字符串
        // 返回经过清洁的html文本
        return htmlSb.toString();
    }

    public static void main(String[] args) {
        String filePath = "D:\\model\\google.html";
        //读取.html文件为字符串
        String htmlStr = toHtmlString(new File(filePath));
        String htmlStr_ = htmlStr.replace("#url#","http://www.baidu.com");
        System.out.print(htmlStr_);

        SendMail mail = new SendMail();
        String msg = htmlStr_;
        String subject = "重置密码";
        try {
            mail.sendEmail("gagakefu@gmail.com", msg, subject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
