package com.ruoyi.project.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.framework.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;


/**
 * 平台币种对象 currency
 *
 * @author none
 * @date 2022-05-10
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("currency")
public class Currency extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 币种ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;
    /**
     * 币种名称
     */
    private String currencyName;
    /**
     * 图片
     */
    private String picUrl;

    /**
     * 币种全称
     */
    private String fullName;

    /**
     * 对USD汇率
     */
    private BigDecimal exchangeRate;
    /**
     * 排序值
     */
    private Long seqNum;

    /**
     * 是否开启充值，0：未开启，1：开启
     */
    private String isRecharge;

    /**
     * 是否开启提现，0：未开启，1：开启
     */
    private String isCash;

    /**
     * 是否开启兑换，0：未开启，1：开启
     */
    private String isExchange;

    /**
     * 最高投注金额
     */
    private BigDecimal maxBetMoney;

    /**
     * 最高利润
     */
    private BigDecimal maxProfit;

    /**
     * 最低投注额
     */
    private BigDecimal minBetMoney;

}
