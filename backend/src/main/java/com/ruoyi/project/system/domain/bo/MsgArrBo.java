package com.ruoyi.project.system.domain.bo;


import lombok.Data;

import java.util.List;

/**
 * 承载具体消息的对象，因为string的hash是可能重复的
 */
@Data
public class MsgArrBo {
    /**
     * hash值
     */
    private int hash;
    /**
     * 对应的消息列表
     */
    private List<MsgBo> list;
}
