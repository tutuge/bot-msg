package com.ruoyi.project.system.service.impl;

import com.ruoyi.framework.config.RuoYiConfig;
import com.ruoyi.project.system.util.IPSeekerUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;

@Service
@Slf4j
public class IPSeekerService {

    private static IPSeekerUtil ipSeeker;

    public static String getIpArea(String ip) {
        if (ipSeeker == null) {
            ClassPathResource resource = new ClassPathResource("/QQWry.Dat");
            try {
                InputStream inputStream = resource.getInputStream();
                File tempFile = File.createTempFile(RuoYiConfig.getProfile(), ".Dat");
                OutputStream outputStream = Files.newOutputStream(tempFile.toPath());
                byte[] buffer = new byte[1024];
                int length;
                while ((length = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, length);
                }
                // 关闭输入流和输出流
                inputStream.close();
                outputStream.close();
                // 将临时文件转换为File对象
                File sourceFile = new File(tempFile.getAbsolutePath());
                ipSeeker = new IPSeekerUtil(sourceFile);
            } catch (Exception e) {
                log.error("IP地址库实例化出错", e);
            }
        }
        if (ipSeeker == null) {
            return null;
        }
        return ipSeeker.getAddress(ip);
    }

    public static String getCountry(String ip) {
        if (ipSeeker == null) {
            ClassPathResource resource = new ClassPathResource("/QQWry.Dat");
            try {
                InputStream inputStream = resource.getInputStream();
                File tempFile = File.createTempFile(RuoYiConfig.getProfile(), ".Dat");
                OutputStream outputStream = Files.newOutputStream(tempFile.toPath());
                byte[] buffer = new byte[1024];
                int length;
                while ((length = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, length);
                }
                // 关闭输入流和输出流
                inputStream.close();
                outputStream.close();
                // 将临时文件转换为File对象
                File sourceFile = new File(tempFile.getAbsolutePath());
                ipSeeker = new IPSeekerUtil(sourceFile);
            } catch (Exception e) {
                log.error("IP地址库实例化出错", e);
            }
        }
        if (ipSeeker == null) {
            return null;
        }
        return ipSeeker.getCountry(ip);
    }

}
