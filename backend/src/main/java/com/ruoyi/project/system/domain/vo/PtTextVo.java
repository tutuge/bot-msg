package com.ruoyi.project.system.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;


/**
 * 文本信息主视图对象 pt_text
 *
 * @author none
 * @date 2022-05-10
 */
@Data
@ApiModel("文本信息主视图对象")
public class PtTextVo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ApiModelProperty("主键ID")
    private Long id;

    /**
     * 文本类型
     */
    @ApiModelProperty("文本类型")
    private String type;

    /**
     * 备注信息
     */
    @ApiModelProperty("备注信息")
    private String remark;

    private List<PtTextLanguageVo> details;

}
