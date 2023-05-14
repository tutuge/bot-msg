package com.ruoyi.project.system.service.impl;

import com.ruoyi.project.system.util.IPSeekerUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.File;

@Service
@Slf4j
public class IPSeekerService {

    private static IPSeekerUtil ipSeeker;

    public static String getIpArea(String ip) {
        if (ipSeeker == null) {
            ClassPathResource resource = new ClassPathResource("/QQWry.Dat");
            try {
                File sourceFile = resource.getFile();
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
                File sourceFile = resource.getFile();
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
