package com.ruoyi.project.system.api.bo;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

@Data
public class QueryBo {
    /**
     * 传入消息应用名称
     */
    private String app;
    /**
     *传入的消息发件人名称
     */
    private String sender;
    /**
     * 留言内容
     */
    private String message;

    /**
     * 传入消息的组名
     */
    @JSONField(name = "group_name")
    private String groupName;
    /**
     * 联系人列表中发件人的电话号码
     */
    private String phone;

}
