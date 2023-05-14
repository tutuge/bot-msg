package com.ruoyi.framework.task.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 首页产品数据
 */
@Data
@ApiModel("产品展示类")
public class ProdVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("名称")
    private String name;

    @ApiModelProperty("产品代码")
    private String proCode;

    @ApiModelProperty("产品全称")
    private String fullName;

    @ApiModelProperty("涨跌幅")
    private String rands;

    @ApiModelProperty("买入价")
    private String bidPrice;

    @ApiModelProperty("卖出价")
    private String askPrice;

    @ApiModelProperty("产品ID")
    private Long pid;

    @ApiModelProperty("位数")
    private String decimalPlaces;

    @ApiModelProperty("当前价")
    private String price;

    @ApiModelProperty("产品LOGO")
    private String picUrl;

    @ApiModelProperty("产品类型")
    private String type;

    @ApiModelProperty("15min钟K线")
    private KData kData;

}
