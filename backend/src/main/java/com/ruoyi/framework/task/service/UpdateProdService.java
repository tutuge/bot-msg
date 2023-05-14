package com.ruoyi.framework.task.service;

import com.ruoyi.project.system.domain.PlatformProductInfo;

import java.util.List;

public interface UpdateProdService {

    /**
     * 更新外汇产品的实时价格
     */
    void updateForeignExchangePrice(List<PlatformProductInfo> productInfoList);

    /**
     * 更新外汇产品的K线数据
     */
    void updateForeignExchangeKLine(List<PlatformProductInfo> productInfoList, String timeType);

    /**
     * 更新加密货币的实时行情
     */
    void updateEncryptionCurrencyPrice(List<PlatformProductInfo> productInfoList);

    /**
     * 更新加密货币的K线数据
     */
    void updateEncryptionCurrencyKLine(List<PlatformProductInfo> productInfoList, String timeType);

    /**
     * 更新美股产品的实时行情
     */
    void updateUSSharesPrice(List<PlatformProductInfo> productInfoList);

    /**
     * 更新期货产品的实时行情
     */
    void updateFuturePrice(List<PlatformProductInfo> productInfoList);

    /**
     * 更新ETF产品的实时行情
     */
    void updateETFPrice(List<PlatformProductInfo> productInfoList);

    /**
     * 更新美股产品的K线数据
     */
    void updateUSSharesKLine(List<PlatformProductInfo> productInfoList, String timeType);

    /**
     * 更新ETF产品的K线数据
     */
    void updateETFKLine(List<PlatformProductInfo> productInfoList, String timeType);

    /**
     * 更新期货产品的K线
     *
     * @param productInfoList
     * @param timeType
     */
    void updateFutureKLine(List<PlatformProductInfo> productInfoList, String timeType);

}
