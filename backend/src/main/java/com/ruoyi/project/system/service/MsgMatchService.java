package com.ruoyi.project.system.service;

public interface MsgMatchService {

    /**
     * @param app       消息发送的app名
     * @param sender    发送人
     * @param message   消息体
     * @param groupName 组群名
     * @param username  接收人名称
     * @return 要回复的消息
     */
    String reply(String app,
                 String sender,
                 String message,
                 String groupName,
                 String username);
}
