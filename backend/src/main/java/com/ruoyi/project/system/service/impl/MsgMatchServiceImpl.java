package com.ruoyi.project.system.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import com.google.common.collect.Sets;
import com.ruoyi.project.system.domain.PlatformMsg;
import com.ruoyi.project.system.domain.bo.MsgArrBo;
import com.ruoyi.project.system.domain.bo.MsgBo;
import com.ruoyi.project.system.service.IPlatformMsgService;
import com.ruoyi.project.system.service.MsgMatchService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

@Slf4j
@Service
public class MsgMatchServiceImpl implements MsgMatchService, ApplicationRunner {

    @Autowired
    private IPlatformMsgService platformMsgService;

    /**
     * 消息承接的数据结构
     */
    private final CopyOnWriteArrayList<MsgArrBo> msgs = new CopyOnWriteArrayList<>();

    /**
     * 项目启动的时候查所有的消息，将消息放进来
     *
     * @param args incoming application arguments
     * @throws Exception
     */
    @Override
    public void run(ApplicationArguments args) throws Exception {
        PlatformMsg platformMsg = new PlatformMsg();
        List<PlatformMsg> platformMsgs = platformMsgService.selectPlatformMsgList(platformMsg);
        Map<Integer, Set<MsgBo>> map = new HashMap<>();
        for (PlatformMsg platformMsg1 : platformMsgs) {
            MsgBo msgBo = convert(platformMsg1);
            int hashCode = msgBo.hashCode();
            Set<MsgBo> msgBos = map.get(hashCode);
            if (CollUtil.isEmpty(msgBos)) {
                Set<MsgBo> set = new HashSet<>();
                set.add(msgBo);
                map.put(hashCode, set);
            } else {
                msgBos.add(msgBo);
            }
        }
        Set<Integer> integers = map.keySet();
        List<MsgArrBo> list = new ArrayList<>();
        for (Integer key : integers) {
            MsgArrBo msgArrBo = new MsgArrBo();
            msgArrBo.setHash(key);
            msgArrBo.setSet(map.get(key));
            list.add(msgArrBo);
        }
        msgs.addAll(list);
        msgs.sort(Comparator.comparing(MsgArrBo::getHash));
    }


    /**
     * 对于每一条消息来说，都必须有发送人和接收人
     * 接收人是从接口这里获取的token对应的用户
     */
    @Override
    public String reply(String app, String sender, String message, String groupName, String receiver) {
        MsgBo msgBo = new MsgBo();
        msgBo.setAppName(app);
        msgBo.setSender(sender);
        msgBo.setMessage(message);
        msgBo.setGroupName(groupName);
        msgBo.setReceiver(receiver);

        MsgArrBo msgArr = getMsgArr(msgs, msgBo.hashCode());
        log.info("前置匹配到的消息为--->{}", msgArr);
        if (ObjectUtil.isNotNull(msgArr)) {
            Set<MsgBo> set = msgArr.getSet();
            for (MsgBo msg : set) {
                if (msg.equals(msgBo)) {
                    return msg.getMsg();
                }
            }
        }
        return null;
    }

    private MsgBo convert(PlatformMsg platformMsg) {
        MsgBo msgBo = new MsgBo();
        msgBo.setId(platformMsg.getId());
        msgBo.setAppName(platformMsg.getAppName());
        msgBo.setSender(platformMsg.getSender());
        msgBo.setMessage(platformMsg.getMessage());
        msgBo.setGroupName(platformMsg.getGroupName());
        msgBo.setReceiver(platformMsg.getReceiver());
        msgBo.setMsg(platformMsg.getMsg());
        return msgBo;
    }

    @Override
    public void addMsg(PlatformMsg platformMsg) {
        MsgBo convert = convert(platformMsg);
        int hashCode = convert.hashCode();
        MsgArrBo msgArr = getMsgArr(msgs, hashCode);
        if (ObjectUtil.isNotNull(msgArr)) {
            Set<MsgBo> set = msgArr.getSet();
            set.add(convert);
        } else {
            MsgArrBo bo = new MsgArrBo();
            bo.setHash(hashCode);
            bo.setSet(Sets.newHashSet(convert));
            msgs.add(bo);
            msgs.sort(Comparator.comparing(MsgArrBo::getHash));
        }
    }

    @Override
    public void removeMsg(PlatformMsg platformMsg) {
        MsgBo convert = convert(platformMsg);
        MsgArrBo msgArr = getMsgArr(msgs, convert.hashCode());
        if (ObjectUtil.isNotNull(msgArr)) {
            Set<MsgBo> set = msgArr.getSet();
            set.remove(convert);
            if (set.size() == 0) {
                msgs.remove(msgArr);
            }
            log.info("remove后消息剩余-->{}", msgs.size());
        }
    }

    @Override
    public void updateMsg(PlatformMsg platformMsg) {
        MsgBo convert = convert(platformMsg);
        int hashCode = convert.hashCode();
        MsgArrBo msgArr = getMsgArr(msgs, hashCode);
        if (ObjectUtil.isNotNull(msgArr)) {
            Set<MsgBo> set = msgArr.getSet();
            for (MsgBo msgBo : set) {
                if (msgBo.getId().equals(convert.getId())) {
                    set.remove(msgBo);
                    set.add(convert);
                }
            }
        } else {
            MsgArrBo bo = new MsgArrBo();
            bo.setHash(hashCode);
            bo.setSet(Sets.newHashSet(convert));
            msgs.add(bo);
            msgs.sort(Comparator.comparing(MsgArrBo::getHash));
        }
    }

    /**
     * 使用二分查找确定对应的消息
     *
     * @param arr         消息对象
     * @param selectValue 比对的值
     * @return 消息结果
     */
    public MsgArrBo getMsgArr(CopyOnWriteArrayList<MsgArrBo> arr, int selectValue) {
        //初始化最小值的索引为0
        int left = 0;
        //初始化最大值的索引为arr.length-1
        int right = arr.size() - 1;

        //首尾相加再除以2得出中间索引
        int mid = (left + right) / 2;

        while (left <= right) {
            //确保程序不会重复查询，不会越界
            MsgArrBo msgArrBo = arr.get(mid);
            if (selectValue > msgArrBo.getHash()) {
                //如果查询的值比中间值大，则往右边区域找，就把最小索引改为中间索引右移一位
                left = mid + 1;
            } else if (selectValue < msgArrBo.getHash()) {
                //如果查询的值比中间值小，则往左边区域找，就把最大索引改为中间索引左移一位
                right = mid - 1;
            } else {
                //剩余的情况就是查询到了结果，那么就直接返回索引。
                return arr.get(mid);
            }
            mid = (left + right) / 2;
        }
        //没有查询到，则返回-1
        return null;
    }
}
