package com.ruoyi.project.system.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class MathUtil {
    /**
     * 获取两个数之间的随机数
     *
     * @param begin
     * @param end
     * @return
     */
    public static double getRandomaDouble(Double begin, Double end) {
        if (begin.equals(end)) {
            return begin;
        }
        Double rtn = begin + (Double) (Math.random() * (end - begin));
        if (rtn.equals(begin) || rtn.equals(end)) {
            return getRandomaDouble(begin, end);
        }
        BigDecimal b = new BigDecimal(rtn);
        rtn = b.setScale(2, RoundingMode.HALF_UP).doubleValue();
        return rtn;
    }

    /**
     * 获取两个数之间的随机数
     *
     * @param begin
     * @param end
     * @return
     */
    public static long getRandomaLong(long begin, long end) {
        long rtn = begin + (long) (Math.random() * (end - begin));
        if (rtn == begin || rtn == end) {
            return getRandomaLong(begin, end);
        }
        return rtn;
    }

    public static double div(double v1, double v2, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException(
                    "The scale must be a positive integer or zero");
        }
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.divide(b2, scale, RoundingMode.HALF_UP).doubleValue();
    }

    public static double mul(double v1, double v2, int scale) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        double c = b1.multiply(b2).doubleValue();
        BigDecimal b = new BigDecimal(c);
        c = b.setScale(scale, RoundingMode.HALF_UP).doubleValue();
        return c;
    }


}
