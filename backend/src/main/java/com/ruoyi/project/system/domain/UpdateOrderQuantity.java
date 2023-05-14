package com.ruoyi.project.system.domain;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class UpdateOrderQuantity {

    private Long id;

    private BigDecimal changeQuantity;

    private Double endQuantity;
}
