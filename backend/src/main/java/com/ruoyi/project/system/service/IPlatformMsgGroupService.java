package com.ruoyi.project.system.service;

import java.util.List;
import com.ruoyi.project.system.domain.PlatformMsgGroup;

/**
 * 消息组群Service接口
 * 
 * @author ruoyi
 * @date 2023-05-25
 */
public interface IPlatformMsgGroupService 
{
    /**
     * 查询消息组群
     * 
     * @param msgGroupId 消息组群ID
     * @return 消息组群
     */
    public PlatformMsgGroup selectPlatformMsgGroupById(Long msgGroupId);

    /**
     * 查询消息组群列表
     * 
     * @param platformMsgGroup 消息组群
     * @return 消息组群集合
     */
    public List<PlatformMsgGroup> selectPlatformMsgGroupList(PlatformMsgGroup platformMsgGroup);

    /**
     * 新增消息组群
     * 
     * @param platformMsgGroup 消息组群
     * @return 结果
     */
    public int insertPlatformMsgGroup(PlatformMsgGroup platformMsgGroup);

    /**
     * 修改消息组群
     * 
     * @param platformMsgGroup 消息组群
     * @return 结果
     */
    public int updatePlatformMsgGroup(PlatformMsgGroup platformMsgGroup);

    /**
     * 批量删除消息组群
     * 
     * @param msgGroupIds 需要删除的消息组群ID
     * @return 结果
     */
    public int deletePlatformMsgGroupByIds(Long[] msgGroupIds);

    /**
     * 删除消息组群信息
     * 
     * @param msgGroupId 消息组群ID
     * @return 结果
     */
    public int deletePlatformMsgGroupById(Long msgGroupId);
}
