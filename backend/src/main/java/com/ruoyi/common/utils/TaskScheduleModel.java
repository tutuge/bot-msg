package com.ruoyi.common.utils;


import lombok.Data;

@Data
public class TaskScheduleModel {
    /**
     * 所选作业类型:
     * 0  -> 每秒
     * 1  -> 每天
     * 2  -> 每月
     * 3  -> 每周
     * 4  -> 每分钟
     * 5  -> 每年
     */
    Integer jobType;

    /**
     * 一年的哪几个月
     */
    Integer[] yearOfMonths;

    /**
     * 一个月的哪几天
     */
    Integer[] dayOfMonths;

    /**
     * 一周的哪几天
     */
    Integer[] dayOfWeeks;

    /**
     * 秒
     */
    Integer second;

    /**
     * 分
     */
    Integer minute;

    /**
     * 时
     */
    Integer hour;

}
