package com.ruoyi.project.monitor.service.impl;

import com.ruoyi.common.constant.ScheduleConstants;
import com.ruoyi.common.exception.job.TaskException;
import com.ruoyi.common.utils.job.CronUtils;
import com.ruoyi.common.utils.job.ScheduleUtils;
import com.ruoyi.framework.redis.RedisCache;
import com.ruoyi.project.monitor.domain.SysJob;
import com.ruoyi.project.monitor.mapper.SysJobMapper;
import com.ruoyi.project.monitor.service.ISysJobService;
import com.ruoyi.project.system.domain.SysConfig;
import com.ruoyi.project.system.service.ISysConfigService;
import org.quartz.JobDataMap;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 定时任务调度信息 服务层
 *
 * @author none
 */
@Service
public class SysJobServiceImpl implements ISysJobService {
    @Autowired
    public RedisTemplate redisTemplate;
    @Autowired
    private Scheduler scheduler;
    @Autowired
    private RedisCache redisCache;
    @Autowired
    private SysJobMapper jobMapper;
    @Autowired
    private ISysConfigService sysConfigService;

    public static Date getCronToDate(String cron) {
        String dateFormat = "ss mm HH dd MM ? yyyy";
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
        Date date = null;
        try {
            date = sdf.parse(cron);
        } catch (ParseException e) {
            return null;
        }
        return date;
    }

    /**
     * 项目启动时，初始化定时器 主要是防止手动修改数据库导致未同步到定时任务处理（注：不能手动修改数据库ID和任务组名，否则会导致脏数据）
     */
    @PostConstruct
    public void init() throws SchedulerException, TaskException {
        //初始化job的时候，首先删除扫块的key
        redisCache.deleteObject("current_update_checkblock");
        redisCache.deleteObject("current_checkblock");
        redisCache.deleteObject("max_block_number");
        List<SysConfig> list = sysConfigService.selectConfigListAll(null);
        //清除缓存
        for (int i = 0; i < list.size(); i++) {
            SysConfig config = list.get(i);
            String configKey = config.getConfigKey();
            if (redisTemplate.hasKey(configKey)) {
                redisCache.deleteObject(configKey);
            }
        }
        scheduler.clear();
        SysJob jobmodel = new SysJob();
        jobmodel.setJobGroup("DEFAULT");
        List<SysJob> jobList = jobMapper.selectJobList(jobmodel);
        for (SysJob job : jobList) {
            ScheduleUtils.createScheduleJob(scheduler, job);
        }
        SysJob jobmodel_1 = new SysJob();
        jobmodel_1.setJobGroup("BBZD");
        List<SysJob> jobList_1 = jobMapper.selectJobList(jobmodel_1);
        for (SysJob job : jobList_1) {
            ScheduleUtils.createScheduleJob(scheduler, job);
        }
        //获取未跑完的限时
        SysJob jobmodel_ = new SysJob();
        jobmodel_.setJobGroup("SYSTEM");
        jobmodel_.setStatus("0");
        List<SysJob> jobList_ = jobMapper.selectJobList(jobmodel_);
        for (SysJob job : jobList_) {
            Date date = getCronToDate(job.getCronExpression());
            if (date != null) {
                //这里不判断任务有没有过期了，只要是限时任务还未结算，统一延迟1min处理，防止到达临界值启动报错
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Calendar nowTime = Calendar.getInstance();
                //随机延迟1-5min避免同一时间任务执行太多
                int num = (int) (Math.random() * 5 + 1);
                nowTime.add(Calendar.MINUTE, Integer.valueOf(num));
                String date_status1 = sdf.format(nowTime.getTime());
                String cron = "";
                try {
                    cron = getCron(sdf.parse(date_status1));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                job.setCronExpression(cron);
                this.updateJob(job);
                ScheduleUtils.createScheduleJob(scheduler, job);
            } else {
                ScheduleUtils.createScheduleJob(scheduler, job);
            }
        }

        SysJob jobmodel_BZ = new SysJob();
        jobmodel_BZ.setJobGroup("BZCP");
        List<SysJob> jobList_BZ = jobMapper.selectJobList(jobmodel_BZ);
        for (SysJob job : jobList_BZ) {
            ScheduleUtils.createScheduleJob(scheduler, job);
        }

        SysJob jobmodel_KJ = new SysJob();
        jobmodel_KJ.setJobGroup("KJCP");
        List<SysJob> jobList_KJ = jobMapper.selectJobList(jobmodel_KJ);
        for (SysJob job : jobList_KJ) {
            ScheduleUtils.createScheduleJob(scheduler, job);
        }
    }

    public String getCron(Date date) {
        String dateFormat = "ss mm HH dd MM ? yyyy";
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
        String formatTimeStr = null;
        if (date != null) {
            formatTimeStr = sdf.format(date);
        }

        return formatTimeStr;
    }

    /**
     * 获取quartz调度器的计划任务列表
     *
     * @param job 调度信息
     * @return
     */
    @Override
    public List<SysJob> selectJobList(SysJob job) {
        return jobMapper.selectJobList(job);
    }

    /**
     * 通过调度任务ID查询调度信息
     *
     * @param jobId 调度任务ID
     * @return 调度任务对象信息
     */
    @Override
    public SysJob selectJobById(Long jobId) {
        return jobMapper.selectJobById(jobId);
    }

    /**
     * 暂停任务
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int pauseJob(SysJob job) throws SchedulerException {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        int rows = jobMapper.updateJob(job);
        if (rows > 0) {
            scheduler.pauseJob(ScheduleUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 恢复任务
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int resumeJob(SysJob job) throws SchedulerException {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        job.setStatus(ScheduleConstants.Status.NORMAL.getValue());
        int rows = jobMapper.updateJob(job);
        if (rows > 0) {
            scheduler.resumeJob(ScheduleUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 删除任务后，所对应的trigger也将被删除
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteJob(SysJob job) throws SchedulerException {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        int rows = jobMapper.deleteJobById(jobId);
        if (rows > 0) {
            scheduler.deleteJob(ScheduleUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 批量删除调度信息
     *
     * @param jobIds 需要删除的任务ID
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteJobByIds(Long[] jobIds) throws SchedulerException {
        for (Long jobId : jobIds) {
            SysJob job = jobMapper.selectJobById(jobId);
            deleteJob(job);
        }
    }

    /**
     * 任务调度状态修改
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int changeStatus(SysJob job) throws SchedulerException {
        int rows = 0;
        String status = job.getStatus();
        if (ScheduleConstants.Status.NORMAL.getValue().equals(status)) {
            rows = resumeJob(job);
        } else if (ScheduleConstants.Status.PAUSE.getValue().equals(status)) {
            rows = pauseJob(job);
        }
        return rows;
    }

    /**
     * 立即运行任务
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void run(SysJob job) throws SchedulerException {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        SysJob properties = selectJobById(job.getJobId());
        //判断任务有没有过期
        try {
            if ("SYSTEM".equals(properties.getJobGroup())) {
                Date date = getCronToDate(properties.getCronExpression());
                if (date != null) {
                    if (date.before(new Date())) {
                        //过期了，立即执行一次，状态置为已失效
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Calendar nowTime = Calendar.getInstance();
                        nowTime.add(Calendar.MINUTE, Integer.valueOf(1));
                        String date_status1 = sdf.format(nowTime.getTime());
                        String cron = "";
                        try {
                            cron = getCron(sdf.parse(date_status1));
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        job.setCronExpression(cron);
                        job.setStatus("1");
                        this.updateJob(job);
                        ScheduleUtils.createScheduleJob(scheduler, job);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 参数
        JobDataMap dataMap = new JobDataMap();
        dataMap.put(ScheduleConstants.TASK_PROPERTIES, properties);
        scheduler.triggerJob(ScheduleUtils.getJobKey(jobId, jobGroup), dataMap);
    }

    /**
     * 新增任务
     *
     * @param job 调度信息 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertJob(SysJob job) throws SchedulerException, TaskException {
        if (job.getStatus() != null && "0".equals(job.getStatus())) {
            System.out.println("不需要指定暂停");
        } else {
            job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        }
        int rows = jobMapper.insertJob(job);
        if (rows > 0) {
            ScheduleUtils.createScheduleJob(scheduler, job);
        }
        return rows;
    }

    /**
     * 更新任务的时间表达式
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateJob(SysJob job) throws SchedulerException, TaskException {
        SysJob properties = selectJobById(job.getJobId());
        int rows = jobMapper.updateJob(job);
        if (rows > 0) {
            updateSchedulerJob(job, properties.getJobGroup());
        }
        return rows;
    }

    /**
     * 更新任务
     *
     * @param job      任务对象
     * @param jobGroup 任务组名
     */
    public void updateSchedulerJob(SysJob job, String jobGroup) throws SchedulerException, TaskException {
        Long jobId = job.getJobId();
        // 判断是否存在
        JobKey jobKey = ScheduleUtils.getJobKey(jobId, jobGroup);
        if (scheduler.checkExists(jobKey)) {
            // 防止创建时存在数据问题 先移除，然后在执行创建操作
            scheduler.deleteJob(jobKey);
        }
        ScheduleUtils.createScheduleJob(scheduler, job);
    }

    /**
     * 校验cron表达式是否有效
     *
     * @param cronExpression 表达式
     * @return 结果
     */
    @Override
    public boolean checkCronExpressionIsValid(String cronExpression) {
        return CronUtils.isValid(cronExpression);
    }

    @Override
    public SysJob selectJobByName(String jobName) {
        // TODO Auto-generated method stub
        return jobMapper.selectJobByName(jobName);
    }
}