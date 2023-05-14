package com.ruoyi.project.system.domain.vo;

import com.ruoyi.project.system.domain.po.FilePo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;


/**
 * 平台币种视图对象 currency
 *
 * @author none
 * @date 2022-05-10
 */
@Data
@ApiModel("平台币种视图对象")
public class CurrencyVo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 币种ID
     */
    @ApiModelProperty("币种ID")
    private Long id;

    /**
     * 币种名称
     */
    @ApiModelProperty("币种名称")
    private String currencyName;

    /**
     * 币种名称
     */
    @ApiModelProperty("币种全称")
    private String fullName;

    @ApiModelProperty("图片地址")
    private String picUrl;

    @ApiModelProperty("对USD汇率")
    private BigDecimal exchangeRate;

    @ApiModelProperty("币种的充值网络")
    private List<NetworkVo> networkVos;

    @ApiModelProperty("币种的提现网络")
    private List<NetworkVo> networkVosCash;

    @ApiModelProperty("排序值")
    private Long seqNum;

    /**
     * 是否开启充值，0：未开启，1：开启
     */
    @ApiModelProperty("是否开启充值")
    private String isRecharge;

    /**
     * 是否开启提现，0：未开启，1：开启
     */
    @ApiModelProperty("是否开启提现")
    private String isCash;

    /**
     * 是否开启兑换，0：未开启，1：开启
     */
    @ApiModelProperty("是否开启兑换")
    private String isExchange;

    private String balanceFormat;

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
