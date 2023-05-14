package com.ruoyi.project.system.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel("语言信息")
public class LanguageVo implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
    @ApiModelProperty("主键")
    private Long id;

    /**
     * 语言名称
     */
    @ApiModelProperty("语言名称")
    private String languageName;

    /**
     * 语言标识
     */
    @ApiModelProperty("语言标识")
    private String identification;

    @ApiModelProperty("LOGO图片")
    private String picUrl;
}
