package com.ruoyi.project.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.project.system.domain.PlatformGroup;

import java.util.List;

/**
 * 平台前端用户Mapper接口
 *
 * @author ruoyi
 * @date 2023-05-25
 */
public interface PlatformGroupMapper extends BaseMapper<PlatformGroup> {
    /**
     * 查询平台前端用户
     *
     * @param groupId 平台前端用户ID
     * @return 平台前端用户
     */
    PlatformGroup selectPlatformGroupById(Long groupId);

    /**
     * 查询平台前端用户列表
     *
     * @param platformGroup 平台前端用户
     * @return 平台前端用户集合
     */
    List<PlatformGroup> selectPlatformGroupList(PlatformGroup platformGroup);

    /**
     * 新增平台前端用户
     *
     * @param platformGroup 平台前端用户
     * @return 结果
     */
    int insertPlatformGroup(PlatformGroup platformGroup);

    /**
     * 修改平台前端用户
     *
     * @param platformGroup 平台前端用户
     * @return 结果
     */
    int updatePlatformGroup(PlatformGroup platformGroup);

    /**
     * 删除平台前端用户
     *
     * @param groupId 平台前端用户ID
     * @return 结果
     */
    int deletePlatformGroupById(Long groupId);

    /**
     * 批量删除平台前端用户
     *
     * @param groupIds 需要删除的数据ID
     * @return 结果
     */
    int deletePlatformGroupByIds(Long[] groupIds);
}
