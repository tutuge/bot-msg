package com.ruoyi.framework.task;

import com.ruoyi.framework.task.service.TaskService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 定时任务调度逻辑
 *
 * @author none
 */
@Component("ryTask")
@Slf4j
public class RyTask {

    @Autowired
    private TaskService taskService;

    /**
     * 定时更新汇率
     */
    public void cacheCurrencyRateHandler() {
        log.info("更新所有币种对USD汇率开始...");
        taskService.refreshCurrencyPrice();
        log.info("更新所有币种对USD汇率结束...");
    }

    /**
     * 定时更新产品的实时价格-接口（10s一次）
     */
    public void updateRealTimePrice() {
        log.info("更新所有产品的实时价格开始...");
        taskService.updateRealTimePrice();
        log.info("更新所有产品的实时价格结束...");
    }

    /**
     * 按照时间类型更新产品的对应K线数据
     */
    public void updateProdKLine(String timeType) {
        //timeType:0-1分钟，1-5min，2-30min，3-1week，4-1Mon，5-15min，6-1H，7：4-H，8-1D
        log.info("按照时间类型更新产品的对应K线数据开始...");
        taskService.updateProdKLine(timeType);
        log.info("按照时间类型更新产品的对应K线数据结束...");
    }
}
