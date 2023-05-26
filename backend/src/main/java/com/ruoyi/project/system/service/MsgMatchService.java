package com.ruoyi.project.system.service;

import com.ruoyi.project.system.domain.PlatformMsg;
import com.ruoyi.project.system.domain.bo.MsgBo;

import java.util.List;

/**
 * 消息匹配
 */
public interface MsgMatchService {

    /**
     * @param app       消息发送的app名
     * @param sender    发送人
     * @param message   消息体
     * @param groupName 组群名
     * @param receiver  接收人名称
     * @return 要回复的消息
     */
    String reply(String app,
                 String sender,
                 String message,
                 String groupName,
                 String receiver);

    /**
     * 新增消息
     *
     * @param platformMsg 消息体
     */
    void addMsg(PlatformMsg platformMsg);

    void addMsg(List<MsgBo> msgBos);

    /**
     * 删除消息
     *
     * @param platformMsg 消息体
     */
    void removeMsg(PlatformMsg platformMsg);

    /**
     * 直接删除
     *
     * @param msgBos
     */
    void removeMsg(List<MsgBo> msgBos);

    /**
     * 直接删除
     *
     * @param msgBo
     */
    void removeMsg(MsgBo msgBo);
}
