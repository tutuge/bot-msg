package com.ruoyi.project.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.project.system.domain.PlatformMsgGroup;

import java.util.List;

/**
 * 消息组群Mapper接口
 *
 * @author ruoyi
 * @date 2023-05-25
 */
public interface PlatformMsgGroupMapper extends BaseMapper<PlatformMsgGroup> {
    /**
     * 查询消息组群
     *
     * @param msgGroupId 消息组群ID
     * @return 消息组群
     */
    PlatformMsgGroup selectPlatformMsgGroupById(Long msgGroupId);

    /**
     * 查询消息组群列表
     *
     * @param platformMsgGroup 消息组群
     * @return 消息组群集合
     */
    List<PlatformMsgGroup> selectPlatformMsgGroupList(PlatformMsgGroup platformMsgGroup);

    /**
     * 新增消息组群
     *
     * @param platformMsgGroup 消息组群
     * @return 结果
     */
    int insertPlatformMsgGroup(PlatformMsgGroup platformMsgGroup);

    /**
     * 修改消息组群
     *
     * @param platformMsgGroup 消息组群
     * @return 结果
     */
    int updatePlatformMsgGroup(PlatformMsgGroup platformMsgGroup);

    /**
     * 删除消息组群
     *
     * @param msgGroupId 消息组群ID
     * @return 结果
     */
    int deletePlatformMsgGroupById(Long msgGroupId);

    /**
     * 批量删除消息组群
     *
     * @param msgGroupIds 需要删除的数据ID
     * @return 结果
     */
    int deletePlatformMsgGroupByIds(Long[] msgGroupIds);
}
