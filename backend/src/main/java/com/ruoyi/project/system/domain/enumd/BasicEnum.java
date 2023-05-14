package com.ruoyi.project.system.domain.enumd;

/**
 * 基础信息用于redis存储的枚举值
 *
 * @author nobody
 * @date 2022/5/12
 */
public enum BasicEnum {
    /**
     * 币种
     */
    CURRENCY("basic:currency:"),
    /**
     * 所有币种
     */
    CURRENCY_ALL("basic:currency:all"),
    /**
     * 所有币种汇率
     */
    CURRENCY_RATE_ALL("basic:currencyRate:all"),
    /**
     * 网络
     */
    NETWORK("basic:network"),
    /**
     * 所有网络
     */
    NETWORK_ALL("basic:network:all"),
    /**
     * 等级信息
     */
    LEVEL("basic:level"),
    /**
     * 头像信息
     */
    HEAD_PORTRAIT("basic:head"),
    /**
     * 所有等级信息
     */
    LEVEL_ALL("basic:level:all"),

    /**
     * 所有语言信息
     */
    LANGUAGE_ALL("basic:language:all"),
    /**
     * 缓存所有开市产品数据
     */
    OPEN_PROD_ALL("openProd:all"),

    /**
     * 缓存所有的置顶产品
     */
    TOP_PROD_ALL("topProd:all"),

    /**
     * 缓存所有产品数据包含未开市的产品
     */
    PROD_ALL("prod:all"),

    /**
     * 缓存所有产品数据包含未开市的产品
     */
    PROD_PC("prod:pc"),

    CHANNEL_ALL("basic:channel:all");

    private final String value;

    BasicEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
