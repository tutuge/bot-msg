package com.ruoyi.framework.task.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 充值网络包含币种信息
 */
@Data
@ApiModel("充值网络和币种信息")
public class NetworkCurrencyVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("主键")
    private Long id;

    @ApiModelProperty("关联币种")
    private Long currencyId;

    @ApiModelProperty("充值网络")
    private String networkName;

    @ApiModelProperty("币种名称")
    private String currencyName;

    @ApiModelProperty("网络类型")
    private String type;

    @ApiModelProperty("提现手续费")
    private String serviceCharge;

    @ApiModelProperty("最低提款金额")
    private BigDecimal minWithdrawal;

    @ApiModelProperty("对USD汇率")
    private BigDecimal exchangeRate;

    @ApiModelProperty("平台的充值地址")
    private String address;
}
