package com.ruoyi.project.system.domain;

import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 产品开市时间对象 platform_open_time
 *
 * @author none
 * @date 2020-06-08
 */
public class OpenTime extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 开市时间ID
     */
    private Long id;

    /**
     * 产品ID
     */
    @Excel(name = "产品ID")
    private Long pid;

    /**
     * 开市时间对应的周几
     */
    @Excel(name = "开市时间对应的周几")
    private String type;

    /**
     * 开市时间
     */
    @Excel(name = "开市时间")
    private String openTime;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Long getPid() {
        return pid;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setOpenTime(String openTime) {
        this.openTime = openTime;
    }

    public String getOpenTime() {
        return openTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("pid", getPid())
                .append("type", getType())
                .append("opentime", getOpenTime())
                .toString();
    }
}
