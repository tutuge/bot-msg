package com.ruoyi.common.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NumUtil {
    private final static Pattern pattern = Pattern.compile("[0-9]*");

    public static boolean isNumeric(String str) {
        Matcher isNum = pattern.matcher(str);
        return isNum.matches();
    }
}
