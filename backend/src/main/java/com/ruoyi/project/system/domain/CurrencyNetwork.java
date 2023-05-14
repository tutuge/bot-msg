package com.ruoyi.project.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.framework.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;


/**
 * 币种充值网络对象 currency_network
 *
 * @author none
 * @date 2022-05-10
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("currency_network")
public class CurrencyNetwork extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;
    /**
     * 关联币种ID
     */
    private Long parentId;
    /**
     * 充值网络
     */
    private String networkName;
    /**
     * 钱包地址
     */
    private String address;
    /**
     * 钱包二维码地址
     */
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
