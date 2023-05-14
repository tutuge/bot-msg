package com.ruoyi.project.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.framework.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 平台前端用户对象 platform_user
 *
 * @author none
 * @date 2020-04-06
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("platform_user")
public class PlatformUser extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @TableId(type = IdType.AUTO)
    private Long userId;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 请求的token
     */
    private String accessToken;
}
