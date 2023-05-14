package com.ruoyi.project.system.domain.enumd;

/**
 * 用户资金变动的类型值
 *
 * @author nobody
 * @date 2022/5/12
 */
public enum AccountRecordTypeEnum {
    /**
     * 充值
     */
    RECHARGE("1"),
    /**
     * 提现
     */
    CASH_OUT("2"),
    /**
     * 提现退回
     */
    CASH_OUT_CANCEL("3"),
    /**
     * 系统充值
     */
    SYS_RECHARGE("4"),
    /**
     * 系统扣费
     */
    SYS_CASH("5"),
    /**
     * 邮票交易-买进
     */
    BUY("6"),
    /**
     * 邮票交易-卖出
     */
    SELL("7"),
    /**
     * 邮票交易-挂单取消
     */
    CANCEL_ORDER("8");

    private final String value;

    AccountRecordTypeEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
