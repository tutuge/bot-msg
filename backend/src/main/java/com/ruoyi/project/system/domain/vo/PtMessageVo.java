package com.ruoyi.project.system.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


/**
 * 平台消息通知视图对象 pt_message
 *
 * @author none
 * @date 2022-06-05
 */
@Data
@ApiModel("平台消息通知视图对象")
public class PtMessageVo {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ApiModelProperty("主键ID")
    private Long id;

    /**
     * 用户id
     */
    @ApiModelProperty("用户id")
    private Long userId;

    /**
     * 用户昵称
     */
    @ApiModelProperty("用户昵称")
    private String nickName;

    /**
     * 内容
     */
    @ApiModelProperty("内容")
    private String content;

    /**
     * 类型
     */
    @ApiModelProperty("类型")
    private String type;

    /**
     * 备注信息
     */
    @ApiModelProperty("备注信息")
    private String remark;

    /**
     * 文本对应的key值
     */
    @ApiModelProperty("文本对应的key值")
    private String messageKey;

    /**
     * 使用的多语言文本标识值
     */
    private String languageKey;

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
