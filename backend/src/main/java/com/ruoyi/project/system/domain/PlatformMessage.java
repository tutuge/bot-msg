package com.ruoyi.project.system.domain;

import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 【请填写功能名称】对象 platform_msg
 *
 * @author ruoyi
 * @date 2023-05-23
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class PlatformMessage extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Long id;

    /**
     * app名称
     */
    @Excel(name = "消息")
    private String message;

}
