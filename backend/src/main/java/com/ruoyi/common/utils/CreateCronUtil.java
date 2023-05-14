package com.ruoyi.common.utils;

import org.quartz.CronExpression;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.TriggerBuilder;

import java.util.Date;

public class CreateCronUtil {

    /**
     * 方法摘要：构建Cron表达式
     *
     * @param taskScheduleModel
     * @return String
     */
    public static String createCronExpression(TaskScheduleModel taskScheduleModel) {
        StringBuffer cronExp = new StringBuffer();

        if (null == taskScheduleModel.getJobType()) {
            System.out.println("执行周期未配置");//执行周期未配置
        }

        if (null != taskScheduleModel.getSecond()
                && null == taskScheduleModel.getMinute()
                && null == taskScheduleModel.getHour()) {
            //每隔几秒
            if (taskScheduleModel.getJobType().intValue() == 0) {
                cronExp.append("0/").append(taskScheduleModel.getSecond());
                cronExp.append(" ");
                cronExp.append("* ");
                cronExp.append("* ");
                cronExp.append("* ");
                cronExp.append("* ");
                cronExp.append("?");
            }

        }

        if (null != taskScheduleModel.getSecond()
                && null != taskScheduleModel.getMinute()
                && null == taskScheduleModel.getHour()) {
            //每隔几分钟
            if (taskScheduleModel.getJobType().intValue() == 4) {
                cronExp.append("* ");
                cronExp.append("0/").append(taskScheduleModel.getMinute());
                cronExp.append(" ");
                cronExp.append("* ");
                cronExp.append("* ");
                cronExp.append("* ");
                cronExp.append("?");
            }

        }

        if (null != taskScheduleModel.getSecond()
                && null != taskScheduleModel.getMinute()
                && null != taskScheduleModel.getHour()) {
            //秒
            cronExp.append(taskScheduleModel.getSecond()).append(" ");
            //分
            cronExp.append(taskScheduleModel.getMinute()).append(" ");
            //小时
            cronExp.append(taskScheduleModel.getHour()).append(" ");

            //每天
            if (taskScheduleModel.getJobType().intValue() == 1) {
                cronExp.append("* ");//日
                cronExp.append("* ");//月
                cronExp.append("?");//周
            }

            //按每周
            else if (taskScheduleModel.getJobType().intValue() == 3) {
                //一个月中第几天
                cronExp.append("? ");
                //月份
                cronExp.append("* ");
                //周
                Integer[] weeks = taskScheduleModel.getDayOfWeeks();
                for (int i = 0; i < weeks.length; i++) {
                    if (i == 0) {
                        cronExp.append(weeks[i]);
                    } else {
                        cronExp.append(",").append(weeks[i]);
                    }
                }

            }

            //按每月
            else if (taskScheduleModel.getJobType().intValue() == 2) {
                //一个月中的哪几天
                Integer[] days = taskScheduleModel.getDayOfMonths();
                for (int i = 0; i < days.length; i++) {
                    if (i == 0) {
                        cronExp.append(days[i]);
                    } else {
                        cronExp.append(",").append(days[i]);
                    }
                }
                //月份
                cronExp.append(" * ");
                //周
                cronExp.append("?");
            }

            //按每年
            else if (taskScheduleModel.getJobType().intValue() == 5) {
                //一个月中的哪几天
                Integer[] days = taskScheduleModel.getDayOfMonths();
                for (int i = 0; i < days.length; i++) {
                    if (i == 0) {
                        cronExp.append(days[i]);
                    } else {
                        cronExp.append(",").append(days[i]);
                    }
                }
                Integer[] months = taskScheduleModel.getYearOfMonths();
                for (int i = 0; i < days.length; i++) {
                    if (i == 0) {
                        cronExp.append(" " + months[i]);
                    } else {
                        cronExp.append(",").append(months[i]);
                    }
                }
                //周
                cronExp.append(" ?");
            }

        } else {
            System.out.println("时或分或秒参数未配置");//时或分或秒参数未配置
        }
        return cronExp.toString();
    }


    /**
     * 方法摘要：生成计划的详细描述
     *
     * @param taskScheduleModel
     * @return String
     */
    public static String createDescription(TaskScheduleModel taskScheduleModel) {
        StringBuffer description = new StringBuffer();
        //计划执行开始时间
//    Date startTime = taskScheduleModel.getScheduleStartTime();

        if (null != taskScheduleModel.getSecond()
                && null != taskScheduleModel.getMinute()
                && null != taskScheduleModel.getHour()) {
            //按每天
            if (taskScheduleModel.getJobType().intValue() == 1) {
                description.append("每天");
                description.append(taskScheduleModel.getHour()).append("时");
                description.append(taskScheduleModel.getMinute()).append("分");
                description.append(taskScheduleModel.getSecond()).append("秒");
                description.append("执行");
            }

            //按每周
            else if (taskScheduleModel.getJobType().intValue() == 3) {
                if (taskScheduleModel.getDayOfWeeks() != null && taskScheduleModel.getDayOfWeeks().length > 0) {
                    String days = "";
                    for (int i : taskScheduleModel.getDayOfWeeks()) {
                        days += "周" + i;
                    }
                    description.append("每周的").append(days).append(" ");
                }
                if (null != taskScheduleModel.getSecond()
                        && null != taskScheduleModel.getMinute()
                        && null != taskScheduleModel.getHour()) {
                    description.append(",");
                    description.append(taskScheduleModel.getHour()).append("时");
                    description.append(taskScheduleModel.getMinute()).append("分");
                    description.append(taskScheduleModel.getSecond()).append("秒");
                }
                description.append("执行");
            }

            //按每月
            else if (taskScheduleModel.getJobType().intValue() == 2) {
                //选择月份
                if (taskScheduleModel.getDayOfMonths() != null && taskScheduleModel.getDayOfMonths().length > 0) {
                    String days = "";
                    for (int i : taskScheduleModel.getDayOfMonths()) {
                        days += i + "号";
                    }
                    description.append("每月的").append(days).append(" ");
                }
                description.append(taskScheduleModel.getHour()).append("时");
                description.append(taskScheduleModel.getMinute()).append("分");
                description.append(taskScheduleModel.getSecond()).append("秒");
                description.append("执行");
            }

        }
        return description.toString();
    }


    //上次执行时间
    public static long getLastTriggerTime(String cron) {
        if (!CronExpression.isValidExpression(cron)) {
            return 0;
        }
        CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity("Caclulate Date").withSchedule(CronScheduleBuilder.cronSchedule(cron)).build();
        Date time0 = trigger.getStartTime();
        Date time1 = trigger.getFireTimeAfter(time0);
        Date time2 = trigger.getFireTimeAfter(time1);
        Date time3 = trigger.getFireTimeAfter(time2);
        long l = time1.getTime() - (time3.getTime() - time2.getTime());
        return l;
    }

    //获取下次执行时间（getFireTimeAfter，也可以下下次...）
    public static long getNextTriggerTime(String cron) {
        if (!CronExpression.isValidExpression(cron)) {
            return 0;
        }
        CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity("Caclulate Date").withSchedule(CronScheduleBuilder.cronSchedule(cron)).build();
        Date time0 = trigger.getStartTime();
        Date time1 = trigger.getFireTimeAfter(time0);
        return time1.getTime();
    }


}
