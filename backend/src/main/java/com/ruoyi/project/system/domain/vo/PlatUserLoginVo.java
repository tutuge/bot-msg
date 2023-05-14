package com.ruoyi.project.system.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("用户登录信息")
public class PlatUserLoginVo {

    @ApiModelProperty("token")
    private String token;

    @ApiModelProperty("用户ID")
    private Long userId;

    @ApiModelProperty("用户名")
    private String nickName;

    @ApiModelProperty("头像")
    private String headPicUrl;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("用户余额")
    private String money;

}
