package com.ruoyi.project.system.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;


/**
 * 币种充值网络视图对象 currency_network
 *
 * @author none
 * @date 2022-05-10
 */
@Data
@ApiModel("币种充值网络视图对象")
public class CurrencyNetworkVo {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ApiModelProperty("主键ID")
    private Long id;

    /**
     * 关联币种ID
     */
    @ApiModelProperty("关联币种ID")
    private Long parentId;

    /**
     * 充值网络
     */
    @ApiModelProperty("充值网络")
    private String networkName;

    /**
     * 钱包地址
     */
    @ApiModelProperty("钱包地址")
    private String address;

    /**
     * 钱包二维码地址
     */
    @ApiModelProperty("钱包二维码地址")
    private String qrcode;

    private Long seqNum;

    /**
     * 网络类型，1：充值网络，2：提现网络
     */
    private String type;

    /**
     * 提现网络手续费，*代表从链上获取手续费
     */
    private String serviceCharge;

    /**
     * 最低提款金额
     */
    private BigDecimal minWithdrawal;

    /**
     * 别名
     */
    private String aliasName;


}
