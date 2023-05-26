package com.ruoyi.project.system.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.project.system.domain.PlatformMsg;
import com.ruoyi.project.system.domain.PlatformMsgGroup;
import com.ruoyi.project.system.domain.PlatformUser;
import com.ruoyi.project.system.domain.bo.MsgBo;
import com.ruoyi.project.system.mapper.PlatformMsgGroupMapper;
import com.ruoyi.project.system.service.IPlatformMsgGroupService;
import com.ruoyi.project.system.service.IPlatformMsgService;
import com.ruoyi.project.system.service.IPlatformUserService;
import com.ruoyi.project.system.service.MsgMatchService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 消息组群Service业务层处理
 *
 * @author ruoyi
 * @date 2023-05-25
 */
@Service
public class PlatformMsgGroupServiceImpl implements IPlatformMsgGroupService {
    @Resource
    private PlatformMsgGroupMapper platformMsgGroupMapper;
    @Resource
    private IPlatformUserService platformUserService;
    @Resource
    private IPlatformMsgService platformMsgService;
    @Resource
    private MsgMatchService msgMatchService;

    /**
     * 查询消息组群
     *
     * @param msgGroupId 消息组群ID
     * @return 消息组群
     */
    @Override
    public PlatformMsgGroup selectPlatformMsgGroupById(Long msgGroupId) {
        return platformMsgGroupMapper.selectPlatformMsgGroupById(msgGroupId);
    }

    /**
     * 查询消息组群列表
     *
     * @param platformMsgGroup 消息组群
     * @return 消息组群
     */
    @Override
    public List<PlatformMsgGroup> selectPlatformMsgGroupList(PlatformMsgGroup platformMsgGroup) {
        return platformMsgGroupMapper.selectPlatformMsgGroupList(platformMsgGroup);
    }

    /**
     * 新增消息组群
     *
     * @param platformMsgGroup 消息组群
     * @return 结果
     */
    @Override
    public int insertPlatformMsgGroup(PlatformMsgGroup platformMsgGroup) {
        platformMsgGroup.setCreateTime(DateUtils.getNowDate());
        return platformMsgGroupMapper.insertPlatformMsgGroup(platformMsgGroup);
    }

    /**
     * 修改消息组群
     *
     * @param platformMsgGroup 消息组群
     * @return 结果
     */
    @Override
    public int updatePlatformMsgGroup(PlatformMsgGroup platformMsgGroup) {
        Long msgGroupId = platformMsgGroup.getMsgGroupId();
        if (ObjectUtil.isNull(msgGroupId)) {
            throw new RuntimeException("消息组群id不得为空");
        }
        String msgGroupName = platformMsgGroup.getMsgGroupName();
        if (StrUtil.isBlank(msgGroupName)) {
            throw new RuntimeException("消息组群名称不得为空");
        }
        PlatformMsgGroup old = platformMsgGroupMapper.selectPlatformMsgGroupById(msgGroupId);
        String oldGroupName = old.getMsgGroupName();
        if (StrUtil.isBlank(oldGroupName)) {
            throw new RuntimeException("原始组群名称缺失，请联系管理员");
        }
        //修改组群名称
        platformMsgGroupMapper.updatePlatformMsgGroup(platformMsgGroup);
        //查询使用了这个组群名的具体的人
        List<PlatformUser> list = platformUserService.selectByMsgGroupId(msgGroupId);
        List<MsgBo> msgBos = new ArrayList<>();
        //根据人再查消息
        for (PlatformUser user : list) {
            PlatformMsg platformMsg = new PlatformMsg();
            platformMsg.setCreateUserId(user.getUserId());
            List<PlatformMsg> platformMsgs = platformMsgService.selectPlatformMsgList(platformMsg);
            for (PlatformMsg msg : platformMsgs) {
                //查到的旧消息先删除
                MsgBo msgBo = new MsgBo();
                msgBo.setId(msg.getId());
                msgBo.setSender(oldGroupName);
                msgBo.setReceiver(user.getUserName());
                msgBo.setMessage(msg.getMessage());
                msgBo.setMsg(msg.getMsg());
                msgBos.add(msgBo);
            }
        }
        msgMatchService.removeMsg(msgBos);
        //将旧的组群名换成新的
        msgBos.forEach(v -> v.setSender(msgGroupName));
        //再进行添加
        msgMatchService.addMsg(msgBos);
        return 1;
    }

    /**
     * 批量删除消息组群
     *
     * @param msgGroupIds 需要删除的消息组群ID
     * @return 结果
     */
    @Override
    public int deletePlatformMsgGroupByIds(Long[] msgGroupIds) {
        for (Long id : msgGroupIds) {
            List<PlatformUser> list = platformUserService.selectByMsgGroupId(id);
            if (CollUtil.isNotEmpty(list)) {
                throw new RuntimeException("当前消息分组仍然被使用中，无法删除");
            }
        }
        return platformMsgGroupMapper.deletePlatformMsgGroupByIds(msgGroupIds);
    }

    /**
     * 删除消息组群信息
     *
     * @param msgGroupId 消息组群ID
     * @return 结果
     */
    @Override
    public int deletePlatformMsgGroupById(Long msgGroupId) {
        List<PlatformUser> list = platformUserService.selectByMsgGroupId(msgGroupId);
        if (CollUtil.isNotEmpty(list)) {
            throw new RuntimeException("当前消息分组仍然被使用中，无法删除");
        }
        return platformMsgGroupMapper.deletePlatformMsgGroupById(msgGroupId);
    }
}
