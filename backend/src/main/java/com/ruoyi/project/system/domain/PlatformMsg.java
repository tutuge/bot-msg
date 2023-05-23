package com.ruoyi.project.system.domain;

import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 【请填写功能名称】对象 platform_msg
 *
 * @author ruoyi
 * @date 2023-05-23
 */
public class PlatformMsg extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Long id;

    /**
     * app名称
     */
    @Excel(name = "app名称")
    private String appName;

    /**
     * 发送人
     */
    @Excel(name = "发送人")
    private String sender;

    /**
     * 发送人id
     */
    @Excel(name = "发送人id")
    private Long senderId;

    /**
     * 发送过来的消息体
     */
    @Excel(name = "发送过来的消息体")
    private String message;

    /**
     * 组群名
     */
    @Excel(name = "组群名")
    private String groupName;

    /**
     * 接收人
     */
    @Excel(name = "接收人")
    private String receiver;

    /**
     * 接送人id
     */
    @Excel(name = "接送人id")
    private Long receiverId;

    /**
     * 要回复的消息
     */
    @Excel(name = "要回复的消息")
    private String msg;

    /**
     * 相关的上一条消息id，没有上一条就是1
     */
    @Excel(name = "相关的上一条消息id，没有上一条就是1")
    private Long pid;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public String getAppName() {
        return appName;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSender() {
        return sender;
    }

    public void setSenderId(Long senderId) {
        this.senderId = senderId;
    }

    public Long getSenderId() {
        return senderId;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiverId(Long receiverId) {
        this.receiverId = receiverId;
    }

    public Long getReceiverId() {
        return receiverId;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getMsg() {
        return msg;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Long getPid() {
        return pid;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("appName", getAppName())
                .append("sender", getSender())
                .append("senderId", getSenderId())
                .append("message", getMessage())
                .append("groupName", getGroupName())
                .append("receiver", getReceiver())
                .append("receiverId", getReceiverId())
                .append("msg", getMsg())
                .append("pid", getPid())
                .toString();
    }
}
