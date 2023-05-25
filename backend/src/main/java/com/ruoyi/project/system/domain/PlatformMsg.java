package com.ruoyi.project.system.domain;

import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 【请填写功能名称】对象 platform_msg
 *
 * @author ruoyi
 * @date 2023-05-23
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class PlatformMsg extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Long id;
    /**
     * 发送过来的消息体
     */
    @Excel(name = "发送过来的消息体")
    private String message;


    /**
     * 要回复的消息
     */
    @Excel(name = "要回复的消息")
    private String msg;
    /**
     * 创建人id
     */
    private Long createUserId;

}
