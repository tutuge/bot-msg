package com.ruoyi.project.system.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@ApiModel("求购出售列表实体")
public class OrderVo {

    @ApiModelProperty("订单ID")
    private Long orderId;

    @ApiModelProperty("产品名称")
    private String prodName;

    @ApiModelProperty("产品编号")
    private String prodCode;

    @ApiModelProperty("涨跌幅")
    private String rands;

    @ApiModelProperty("挂单价格")
    private BigDecimal orderPrice;

    @ApiModelProperty("挂单数量")
    private BigDecimal quantity;

    @ApiModelProperty("交易方向，1:买进,2:卖出")
    private String direction;

    @ApiModelProperty("订单时间")
    private Date orderTime;

    @ApiModelProperty("当前市价")
    private String price;

    @ApiModelProperty("用户ID")
    private Long userId;
}
