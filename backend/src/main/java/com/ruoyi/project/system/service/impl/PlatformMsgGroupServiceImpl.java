package com.ruoyi.project.system.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.project.system.domain.PlatformMsgGroup;
import com.ruoyi.project.system.domain.PlatformUser;
import com.ruoyi.project.system.mapper.PlatformMsgGroupMapper;
import com.ruoyi.project.system.service.IPlatformMsgGroupService;
import com.ruoyi.project.system.service.IPlatformUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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
