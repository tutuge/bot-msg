package com.ruoyi.project.system.domain.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class RemindEmailOrder {

    private String email;//邮件

    private Long id;//订单ID

    private BigDecimal loanAmount;//订单金额

    private Long userId;
}
