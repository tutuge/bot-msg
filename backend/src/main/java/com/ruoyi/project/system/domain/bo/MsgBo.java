package com.ruoyi.project.system.domain.bo;

import com.google.common.base.Objects;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.StringJoiner;

/**
 * 消息发送的bo
 */
@Getter
@Setter
public class MsgBo implements Serializable {
    /**
     * 消息在数据库中id
     */
    private Long id;
    /**
     * 发送人
     */
    private String sender;
    /**
     * 消息体
     */
    private String message;
    /**
     * 接收人名称
     */
    private String receiver;
    /**
     * 要返回的消息
     */
    private String msg;

    /**
     * 此处使用发送人 接收人 还有消息内容来确定本对象是否包含返回的消息
     *
     * @param o
     * @return
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        MsgBo msgBo = (MsgBo) o;
        return Objects.equal(sender, msgBo.sender) &&
                Objects.equal(message, msgBo.message) &&
                Objects.equal(receiver, msgBo.receiver);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(sender, message, receiver);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", MsgBo.class.getSimpleName() + "[", "]")
                .add("id=" + id)
                .add("sender='" + sender + "'")
                .add("message='" + message + "'")
                .add("receiver='" + receiver + "'")
                .add("msg='" + msg + "'")
                .add("hashcode='" + hashCode() + "'")
                .toString();
    }
}
