package com.ruoyi.project.system.domain.bo;

import com.ruoyi.framework.web.domain.BaseEntity;
import com.ruoyi.project.system.domain.po.FilePo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.List;


/**
 * 平台币种业务对象 currency
 *
 * @author none
 * @date 2022-05-10
 */

@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel("平台币种业务对象")
public class CurrencyBo extends BaseEntity {

    /**
     * 币种ID
     */
    @ApiModelProperty(value = "币种ID", required = true)
    private Long id;

    /**
     * 币种名称
     */
    @ApiModelProperty(value = "币种名称", required = true)
    private String currencyName;

    @ApiModelProperty(value = "币种全称", required = true)
    private String fullName;

    @ApiModelProperty(value = "币种缩略图", required = true)
    private String picUrl;

    @ApiModelProperty(value = "对USD汇率", required = true)
    private BigDecimal exchangeRate;

    @ApiModelProperty(value = "排序值", required = true)
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

    private List<FilePo> fileList;
}
