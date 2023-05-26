package com.ruoyi.project.system.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Sets;
import com.ruoyi.framework.redis.RedisCache;
import com.ruoyi.project.system.domain.PlatformMessage;
import com.ruoyi.project.system.domain.PlatformMsg;
import com.ruoyi.project.system.domain.PlatformMsgGroup;
import com.ruoyi.project.system.domain.PlatformUser;
import com.ruoyi.project.system.domain.bo.MsgArrBo;
import com.ruoyi.project.system.domain.bo.MsgBo;
import com.ruoyi.project.system.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Slf4j
@Service
public class MsgMatchServiceImpl implements MsgMatchService, ApplicationRunner {

    @Autowired
    private IPlatformMsgService platformMsgService;
    @Autowired
    private IPlatformMessageService platformMessageService;
    @Resource
    private IPlatformUserService platformUserService;
    @Resource
    private RedisCache redisCache;

    @Resource
    private IPlatformMsgGroupService platformMsgGroupService;

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
            List<MsgBo> msgBos = convert(platformMsg1);
            for (MsgBo msgBo : msgBos) {
                int hashCode = msgBo.hashCode();
                Set<MsgBo> msgBos0 = map.get(hashCode);
                if (CollUtil.isEmpty(msgBos0)) {
                    Set<MsgBo> set = new HashSet<>();
                    set.add(msgBo);
                    map.put(hashCode, set);
                } else {
                    msgBos0.add(msgBo);
                }
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
        if (StrUtil.isNotBlank(message)) {
            PlatformMessage platformMessage = new PlatformMessage();
            platformMessage.setMessage(message);
            platformMessageService.insertPlatformMessage(platformMessage);
        } else {
            return null;
        }
        //下面执行加锁，同样的消息就回一条
        String joinKey = StrUtil.join(":", sender, message, receiver);
        Integer lock = redisCache.getCacheObject(joinKey);
        if (ObjectUtil.isNotNull(lock) && lock == 1) {
            return null;
        }
        synchronized (MsgMatchServiceImpl.class) {
            lock = redisCache.getCacheObject(joinKey);
            if (ObjectUtil.isNotNull(lock) && lock == 1) {
                return null;
            }
            redisCache.setCacheObject(joinKey, 1, 2, TimeUnit.SECONDS);
            MsgBo msgBo = new MsgBo();
            msgBo.setSender(sender);
            msgBo.setMessage(message);
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
        }
        return null;
    }

    private List<MsgBo> convert(PlatformMsg platformMsg) {
        // 1、 根据创建人id获得创建人信息
        Long createUserId = platformMsg.getCreateUserId();
        PlatformUser platformUser = platformUserService.selectPlatformUserById(createUserId);
        // 2、 根据创建人信息得接收人信息和组群信息
        String receiver = platformUser.getUserName();
        String msgGroupIds = platformUser.getMsgGroupIds();
        //查询消息分组
        List<PlatformMsgGroup> platformMsgGroups = platformMsgGroupService.selectPlatformMsgGroupList(new PlatformMsgGroup());
        Map<Long, PlatformMsgGroup> msgGroupMap = platformMsgGroups.stream().collect(Collectors.toMap(PlatformMsgGroup::getMsgGroupId, a -> a, (k1, k2) -> k1));
        //如果用户对应多个组群，那么就是需要创建多个对象
        List<MsgBo> msg = new ArrayList<>();
        if (StrUtil.isNotBlank(msgGroupIds)) {
            String[] split = msgGroupIds.split(",");
            List<Long> msgGroupIdsLong = Arrays.stream(split).map(Long::valueOf).collect(Collectors.toList());
            for (Long msgGroupId : msgGroupIdsLong) {
                PlatformMsgGroup platformMsgGroup = msgGroupMap.get(msgGroupId);
                if (ObjectUtil.isNotNull(platformMsgGroup)) {
                    String msgGroupName = platformMsgGroup.getMsgGroupName();
                    if (StrUtil.isNotBlank(msgGroupName)) {
                        MsgBo msgBo = new MsgBo();
                        msgBo.setId(platformMsg.getId());
                        msgBo.setSender(msgGroupName);
                        msgBo.setReceiver(receiver);
                        msgBo.setMessage(platformMsg.getMessage());
                        msgBo.setMsg(platformMsg.getMsg());
                        msg.add(msgBo);
                    }
                }
            }
        }
        return msg;
    }

    @Override
    public void addMsg(PlatformMsg platformMsg) {
        List<MsgBo> msgBos = convert(platformMsg);
        addMsg(msgBos);
    }

    @Override
    public void addMsg(List<MsgBo> msgBos) {
        for (MsgBo msgBo : msgBos) {
            int hashCode = msgBo.hashCode();
            MsgArrBo msgArr = getMsgArr(msgs, hashCode);
            if (ObjectUtil.isNotNull(msgArr)) {
                Set<MsgBo> set = msgArr.getSet();
                set.add(msgBo);
            } else {
                MsgArrBo bo = new MsgArrBo();
                bo.setHash(hashCode);
                bo.setSet(Sets.newHashSet(msgBo));
                msgs.add(bo);
            }
        }
        msgs.sort(Comparator.comparing(MsgArrBo::getHash));
        printMsg();
    }


    @Override
    public void removeMsg(PlatformMsg platformMsg) {
        List<MsgBo> msgBos = convert(platformMsg);
        removeMsg(msgBos);
    }

    @Override
    public void removeMsg(List<MsgBo> msgBos) {
        for (MsgBo convert : msgBos) {
            removeMsg(convert);
        }
    }

    @Override
    public void removeMsg(MsgBo msgBo) {
        MsgArrBo msgArr = getMsgArr(msgs, msgBo.hashCode());
        if (ObjectUtil.isNotNull(msgArr)) {
            Set<MsgBo> set = msgArr.getSet();
            set.remove(msgBo);
            if (set.size() == 0) {
                msgs.remove(msgArr);
            }
            log.info("remove后消息剩余-->{}", msgs.size());
            msgs.sort(Comparator.comparing(MsgArrBo::getHash));
            printMsg();
        }
    }

    private void printMsg() {
        msgs.forEach((v) -> {
            Set<MsgBo> set1 = v.getSet();
            set1.forEach(z -> {
                log.info("消息-->{}", z);
            });
        });
        log.info("打印完毕------------------------------");
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
