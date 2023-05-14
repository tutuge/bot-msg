package com.ruoyi.framework.task.service;

public interface TaskService {

    /**
     * 定时任务刷新平台币种价格数据
     */
    void refreshCurrencyPrice();

    /**
     * 定时更新产品的实时价格-10s一次
     */
    void updateRealTimePrice();

    /**
     * 根据时间类型更新K线数据
     *
     * @param timeType
     */
    void updateProdKLine(String timeType);

}
