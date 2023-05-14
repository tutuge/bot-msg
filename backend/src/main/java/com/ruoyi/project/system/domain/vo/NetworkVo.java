package com.ruoyi.project.system.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 充值网络
 */
@Data
@ApiModel("充值、提现网络")
public class NetworkVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("主键")
    private Long id;

    @ApiModelProperty("关联币种")
    private Long currencyId;

    @ApiModelProperty("充值网络")
    private String networkName;

    @ApiModelProperty("网络类型")
    private String type;

    @ApiModelProperty("提现手续费")
    private String serviceCharge;

    @ApiModelProperty("最低提款金额")
    private BigDecimal minWithdrawal;

    @ApiModelProperty("别名")
    private String aliasName;
}
