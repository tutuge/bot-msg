package com.ruoyi.project.system.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
@ApiModel("用户消息前端展示实体类")
public class PtMessageApiVo {

    @ApiModelProperty("主键")
    private Long id;

    @ApiModelProperty("内容")
    private String content;

    @ApiModelProperty("标题-key")
    private String type;

    @ApiModelProperty("文本Key值")
    private String messageKey;

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /**
     * 使用的多语言文本标识值
     */
    private String languageKey;

    @ApiModelProperty("已读未读，0：未读，1：已读")
    private String isRead;

    /**
     * title要替换的key
     */
    private String titleReplaceKey;

    /**
     * title要替换的值
     */
    private String titleReplaceValue;
}
