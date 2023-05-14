package com.ruoyi.project.system.domain;

import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * 订单对象 platform_order
 *
 * @author none
 * @date 2020-06-18
 */
@Data
public class PlatformOrder extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private Long oid;

    @Excel(name = "下单人ID")
    private Long userId;

    /**
     * 订单编号
     */
    @Excel(name = "订单编号")
    private String orderno;

    /**
     * 产品ID
     */
    @Excel(name = "产品ID")
    private Long pid;

    /**
     * 商品名称
     */
    @Excel(name = "商品名称")
    private String ptitle;

    /**
     * 0涨 1跌，
     */
    @Excel(name = "0涨 1跌，")
    private Long ostyle;

    /**
     * 建仓时间
     */
    @Excel(name = "建仓时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date buytime;

    private String buytimeStr;

    /**
     * 手数
     */
    @Excel(name = "手数")
    private Double onumber;

    /**
     * 平仓时间
     */
    @Excel(name = "平仓时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date selltime;

    private String selltimeStr;

    /**
     * 0交易，1平仓
     */
    @Excel(name = "0交易，1待执行,2平仓")
    private Long ostaus;

    /**
     * 入仓价
     */
    @Excel(name = "入仓价")
    private Double buyprice;

    /**
     * 平仓价
     */
    @Excel(name = "平仓价")
    private Double sellprice;

    /**
     * 点数/分钟数
     */
    @Excel(name = "点数/分钟数")
    private String endprofit;

    /**
     * 盈亏比例
     */
    @Excel(name = "盈亏比例")
    private Double endloss;

    /**
     * 总费用
     */
    @Excel(name = "总费用")
    private Double fee;

    /**
     * 1点位、2时间
     */
    @Excel(name = "1点位、2时间")
    private String eid;

    /**
     * 下单后余额
     */
    @Excel(name = "下单后余额")
    private Double commission;

    /**
     * 盈亏
     */
    @Excel(name = "盈亏")
    private Double ploss;

    /**
     * 是否盈利1盈利2亏损3无效
     */
    @Excel(name = "1盈利2亏损3无效")
    private Integer isWin;

    /**
     * 0不空1盈利2亏损
     */
    @Excel(name = "0不空1盈利2亏损")
    private Integer kongType;

    /**
     * 手续费
     */
    @Excel(name = "手续费")
    private Double sxFee;

    /**
     * $column.columnComment
     */
    @Excel(name = "未知")
    private Integer isNotice;

    @Excel(name = "目标价格")
    private Double targetmoney;

    @Excel(name = "止盈价格")
    private Double stopyingmoney;

    @Excel(name = "止损价格")
    private Double stopLossmoney;

    @Excel(name = "1:期权订单，2：合约订单-市价，3：合约订单-限价")
    private String orderType;

    @Excel(name = "杠杆倍数")
    private Double gearing;

    @Excel(name = "保证金")
    private Double earnestmoney;

    @Excel(name = "平仓类型")
    private String positiontype;

    private String orderTypes;

    private String ostausin;

    private String userCode;

    private String userType;

    private Date settleTime;//限时订单的结算时间

    private String useAccount;//使用账户，0：正常账户，1：测试账户

    @ApiModelProperty("涨跌点-实时")
    private int pips;

    @ApiModelProperty("利润")
    private String profit;

}
