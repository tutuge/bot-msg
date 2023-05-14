package com.ruoyi.project.system.domain.vo;

import com.ruoyi.project.system.domain.po.FilePo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;


/**
 * 平台语言视图对象 pt_language
 *
 * @author none
 * @date 2022-05-10
 */
@Data
@ApiModel("平台语言视图对象")
public class PtLanguageVo {

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

    @ApiModelProperty("图片地址")
    private String picUrl;

    private List<FilePo> fileList;

    private Long seqNum;
}
