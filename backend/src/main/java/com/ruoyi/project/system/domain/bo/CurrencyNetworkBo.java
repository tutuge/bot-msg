package com.ruoyi.project.system.domain.bo;

import com.ruoyi.framework.web.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;


/**
 * 币种充值网络业务对象 currency_network
 *
 * @author none
 * @date 2022-05-10
 */

@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel("币种充值网络业务对象")
public class CurrencyNetworkBo extends BaseEntity {

    /**
     * 主键ID
     */
    @ApiModelProperty(value = "主键ID", required = true)
    private Long id;

    /**
     * 关联币种ID
     */
    @ApiModelProperty(value = "关联币种ID", required = true)
    private Long parentId;

    /**
     * 充值网络
     */
    @ApiModelProperty(value = "充值网络", required = true)
    private String networkName;

    /**
     * 钱包地址
     */
    @ApiModelProperty(value = "钱包地址", required = true)
    private String address;

    /**
     * 钱包二维码地址
     */
    @ApiModelProperty(value = "钱包二维码地址", required = true)
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
