package com.ruoyi.common.utils.ip;

import com.ruoyi.project.system.service.impl.IPSeekerService;

/**
 * 获取地址类
 *
 * @author none
 */
public class AddressUtils {

    private final static String DOUBLE_COLON = "::";
    private final static String SINGLE_COLON = ":";

    public static String getRealAddressByIP(String ip) {
        String address = "XX XX";
        if ("IPv4".equals(validIPAddressAll(ip))) {
            address = IPSeekerService.getIpArea(ip);
            // 内网不查询
            if (IpUtils.internalIp(ip)) {
                return "内网IP";
            }
            address = IPSeekerService.getIpArea(ip);
        }
        return address;
    }


    public static String getContryAddressByIP(String ip) {
        String address = "XX XX";
        if ("IPv4".equals(validIPAddressAll(ip))) {
            // 内网不查询
            if (IpUtils.internalIp(ip)) {
                return "内网IP";
            }
            address = IPSeekerService.getCountry(ip);
        }
        return address;
    }

    /**
     * 判断所有的IP地址
     *
     * @param IP
     * @return
     */
    public static String validIPAddressAll(String IP) {
        if (!IP.contains(".") && !IP.contains(SINGLE_COLON)) {
            return "Neither";
        }
        //如果是IPV4
        if (IP.contains(".")) {
            if (IP.endsWith(".")) {
                return "Neither";
            }
            String[] arr = IP.split("\\.");
            if (arr.length != 4) {
                return "Neither";
            }
            for (int i = 0; i < 4; i++) {
                if (arr[i].length() == 0 || arr[i].length() > 3) {
                    return "Neither";
                }
                for (int j = 0; j < arr[i].length(); j++) {
                    if (arr[i].charAt(j) >= '0' && arr[i].charAt(j) <= '9') {
                        continue;
                    }
                    return "Neither";
                }
                if (Integer.parseInt(arr[i]) > 255 || (arr[i].length() >= 2 && String.valueOf(arr[i]).startsWith("0"))) {
                    return "Neither";
                }
            }
            return "IPv4";
        }
        //如果是IPV6
        if (IP.contains(SINGLE_COLON)) {
            if (IP.endsWith(SINGLE_COLON) && !IP.endsWith(DOUBLE_COLON)) {
                return "Neither";
            }
            //如果包含多个“::”，一个IPv6地址中只能出现一个“::”
            if (IP.contains(DOUBLE_COLON) && IP.indexOf(DOUBLE_COLON, IP.indexOf(DOUBLE_COLON) + 2) != -1) {
                return "Neither";
            }
            //如果含有一个“::”
            if (IP.contains(DOUBLE_COLON)) {
                String[] arr = IP.split(SINGLE_COLON);
                //"1::"是最短的字符串
                if (arr.length > 7 || arr.length < 1) {
                    return "Neither";
                }
                for (String s : arr) {
                    if ("".equals(s)) {
                        continue;
                    }
                    if (s.length() > 4) {
                        return "Neither";
                    }
                    for (int j = 0; j < s.length(); j++) {
                        if ((s.charAt(j) >= '0' && s.charAt(j) <= '9') || (s.charAt(j) >= 'A' && s.charAt(j) <= 'F')
                                || (s.charAt(j) >= 'a' && s.charAt(j) <= 'f')) {
                            continue;
                        }
                        return "Neither";
                    }
                }
                return "IPv6";
            }
            //如果不含有“::”
            if (!IP.contains(DOUBLE_COLON)) {
                String[] arr = IP.split(SINGLE_COLON);
                if (arr.length != 8) {
                    return "Neither";
                }
                for (String s : arr) {
                    if (s.length() > 4) {
                        return "Neither";
                    }
                    for (int j = 0; j < s.length(); j++) {
                        if ((s.charAt(j) >= '0' && s.charAt(j) <= '9') || (s.charAt(j) >= 'A' && s.charAt(j) <= 'F')
                                || (s.charAt(j) >= 'a' && s.charAt(j) <= 'f')) {
                            continue;
                        }
                        return "Neither";
                    }
                }
                return "IPv6";
            }
        }//如果是IPV6
        return "Neither";
    }
}
