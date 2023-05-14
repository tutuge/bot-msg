package com.ruoyi.project.system.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


/**
 * 文本多语言信息视图对象 pt_text_language
 *
 * @author none
 * @date 2022-05-10
 */
@Data
@ApiModel("文本多语言信息视图对象")
public class PtTextLanguageVo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ApiModelProperty("主键ID")
    private Long id;

    /**
     * 关联文本主表id
     */
    @ApiModelProperty("关联文本主表id")
    private Long parentId;

    /**
     * 文本信息
     */
    @ApiModelProperty("文本信息")
    private String textContent;

    /**
     * 语言标识
     */
    @ApiModelProperty("语言标识")
    private String identification;

    /**
     * 备注信息
     */
    @ApiModelProperty("备注信息")
    private String remark;

    /**
     * 关联语言id
     */
    @ApiModelProperty("关联语言id")
    private Long languageId;


}
