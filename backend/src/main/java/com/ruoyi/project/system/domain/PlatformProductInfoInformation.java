package com.ruoyi.project.system.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 产品的多语言文本信息对象 platform_product_info_information
 *
 * @author none
 * @date 2023-02-05
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("platform_product_info_information")
public class PlatformProductInfoInformation extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * $column.columnComment
     */
    private Long id;

    /**
     * 产品ID
     */
    @Excel(name = "产品ID")
    private Long pid;

    /**
     * 产品简介
     */
    @Excel(name = "产品简介")
    private String briefIntroduction;

    /**
     * 发行平台
     */
    @Excel(name = "发行平台")
    private String distributionPlatform;

    /**
     * 产品信息
     */
    @Excel(name = "产品信息")
    private String informations;

    /**
     * 印刷工艺
     */
    @Excel(name = "印刷工艺")
    private String printingProcess;

    /**
     * 印刷商
     */
    @Excel(name = "印刷商")
    private String printer;

    /**
     * 语言标识
     */
    @Excel(name = "语言标识")
    private String identification;

    private Long languageId;


}
