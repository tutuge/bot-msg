package com.ruoyi.project.system.controller.vo;

import lombok.Data;

import java.util.List;

@Data
public class PlatformUserVo {
    /**
     * 用户id
     */
    private Long userId;
    /**
     * 用户名
     */
    private String userName;
    /**
     * token
     */
    private String accessToken;

    /**
     * 用户组id
     */
    private Long userGroupId;
    /**
     * 用户组
     */
    private String userGroupName;

    /**
     * 回复指定组群id
     */
    private List<Long> msgGroupIds;

    /**
     * 回复指定组群
     */
    private String msgGroupName;
}
