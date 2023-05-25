package com.ruoyi.project.system.domain;

import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 消息组群对象 platform_msg_group
 *
 * @author ruoyi
 * @date 2023-05-25
 */
public class PlatformMsgGroup extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 用户组id
     */
    private Long msgGroupId;

    /**
     * 用户组名称
     */
    @Excel(name = "消息组群名称")
    private String msgGroupName;

    public void setMsgGroupId(Long msgGroupId) {
        this.msgGroupId = msgGroupId;
    }

    public Long getMsgGroupId() {
        return msgGroupId;
    }

    public void setMsgGroupName(String msgGroupName) {
        this.msgGroupName = msgGroupName;
    }

    public String getMsgGroupName() {
        return msgGroupName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("msgGroupId", getMsgGroupId())
                .append("msgGroupName", getMsgGroupName())
                .append("createTime", getCreateTime())
                .toString();
    }
}
