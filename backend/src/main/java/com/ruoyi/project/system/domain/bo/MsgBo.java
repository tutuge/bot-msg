package com.ruoyi.project.system.domain.bo;

import com.google.common.base.Objects;
import lombok.Data;

import java.io.Serializable;

/**
 * 消息发送的bo
 */
@Data
public class MsgBo implements Serializable {
    /**
     * 消息发送的app名
     */
    private String appName;
    /**
     * 发送人
     */
    private String sender;
    /**
     * 消息体
     */
    private String message;
    /**
     * 组群名
     */
    private String groupName;
    /**
     * 接收人名称
     */
    private String username;
    /**
     * 要返回的消息
     */
    private String msg;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        MsgBo msgBo = (MsgBo) o;
        return Objects.equal(appName, msgBo.appName) &&
                Objects.equal(sender, msgBo.sender) &&
                Objects.equal(message, msgBo.message) &&
                Objects.equal(groupName, msgBo.groupName) &&
                Objects.equal(username, msgBo.username);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(appName, sender, message, groupName, username);
    }
}
