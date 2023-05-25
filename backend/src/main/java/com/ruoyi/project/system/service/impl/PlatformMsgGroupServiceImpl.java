package com.ruoyi.project.system.service.impl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.project.system.domain.PlatformMsgGroup;
import com.ruoyi.project.system.mapper.PlatformMsgGroupMapper;
import com.ruoyi.project.system.service.IPlatformMsgGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 消息组群Service业务层处理
 *
 * @author ruoyi
 * @date 2023-05-25
 */
@Service
public class PlatformMsgGroupServiceImpl implements IPlatformMsgGroupService {
    @Autowired
    private PlatformMsgGroupMapper platformMsgGroupMapper;

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
        return platformMsgGroupMapper.updatePlatformMsgGroup(platformMsgGroup);
    }

    /**
     * 批量删除消息组群
     *
     * @param msgGroupIds 需要删除的消息组群ID
     * @return 结果
     */
    @Override
    public int deletePlatformMsgGroupByIds(Long[] msgGroupIds) {
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
        return platformMsgGroupMapper.deletePlatformMsgGroupById(msgGroupId);
    }
}
