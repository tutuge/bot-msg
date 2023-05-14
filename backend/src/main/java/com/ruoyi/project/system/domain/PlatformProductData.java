package com.ruoyi.project.system.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 产品相关数据对象 platform_productdata
 *
 * @author none
 * @date 2020-06-08
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("platform_product_data")
public class PlatformProductData extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 数据ID
     */
    private Long id;

    /**
     * 产品ID
     */
    @Excel(name = "产品ID")
    private Long pid;

    /**
     * 产品名称
     */
    @Excel(name = "产品名称")
    private String name;

    /**
     * 当前市价
     */
    @Excel(name = "当前市价")
    private String price;

    /**
     * 开盘价
     */
    @Excel(name = "开盘价")
    private String open;

    /**
     * 收盘价
     */
    @Excel(name = "收盘价")
    private String close;

    /**
     * 最高市价
     */
    @Excel(name = "最高市价")
    private String high;

    /**
     * 最低市价
     */
    @Excel(name = "最低市价")
    private String low;

    /**
     * 振幅
     */
    @Excel(name = "振幅")
    private String diff;

    /**
     * 波幅
     */
    @Excel(name = "波幅")
    private String diffrate;

    /**
     * $column.columnComment
     */
    @Excel(name = "涨跌幅")
    private String rands;

    /**
     * $column.columnComment
     */
    private String point;

    /**
     * 昨收
     */
    private String pre;

    /**
     * 是否删除
     */
    @Excel(name = "是否删除")
    private Integer isdelete;

    /**
     * 买入价
     */
    private String bidPrice;
    /**
     * 卖出价
     */
    private String askPrice;

}
