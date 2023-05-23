package com.ruoyi.project.system.domain.bo;


import com.google.common.base.Objects;
import lombok.Data;

import java.util.Set;

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
    private Set<MsgBo> set;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        MsgArrBo msgArrBo = (MsgArrBo) o;
        return hash == msgArrBo.hash;
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(hash);
    }
}
