package com.ruoyi.project.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;

/**
 * 平台前端用户对象 platform_group
 * 
 * @author ruoyi
 * @date 2023-05-25
 */
public class PlatformGroup extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户组id */
    private Long groupId;

    /** 用户组名称 */
    @Excel(name = "用户组名称")
    private String groupName;

    public void setGroupId(Long groupId) 
    {
        this.groupId = groupId;
    }

    public Long getGroupId() 
    {
        return groupId;
    }
    public void setGroupName(String groupName) 
    {
        this.groupName = groupName;
    }

    public String getGroupName() 
    {
        return groupName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("groupId", getGroupId())
            .append("groupName", getGroupName())
            .append("createTime", getCreateTime())
            .toString();
    }
}
