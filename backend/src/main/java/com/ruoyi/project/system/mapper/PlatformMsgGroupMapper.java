package com.ruoyi.project.system.mapper;

import java.util.List;
import com.ruoyi.project.system.domain.PlatformMsgGroup;

/**
 * 消息组群Mapper接口
 * 
 * @author ruoyi
 * @date 2023-05-25
 */
public interface PlatformMsgGroupMapper 
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
     * 删除消息组群
     * 
     * @param msgGroupId 消息组群ID
     * @return 结果
     */
    public int deletePlatformMsgGroupById(Long msgGroupId);

    /**
     * 批量删除消息组群
     * 
     * @param msgGroupIds 需要删除的数据ID
     * @return 结果
     */
    public int deletePlatformMsgGroupByIds(Long[] msgGroupIds);
}
