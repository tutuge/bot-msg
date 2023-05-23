package com.ruoyi.project.system.service;

import com.ruoyi.project.system.domain.PlatformMsg;

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


    /**
     * 删除消息
     *
     * @param platformMsg 消息体
     */
    void removeMsg(PlatformMsg platformMsg);

    /**
     * 修改消息
     *
     * @param platformMsg 消息体
     */
    void updateMsg(PlatformMsg platformMsg);
}
