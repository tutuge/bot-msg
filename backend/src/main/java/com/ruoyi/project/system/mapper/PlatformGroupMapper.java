package com.ruoyi.project.system.mapper;

import java.util.List;
import com.ruoyi.project.system.domain.PlatformGroup;

/**
 * 平台前端用户Mapper接口
 * 
 * @author ruoyi
 * @date 2023-05-25
 */
public interface PlatformGroupMapper 
{
    /**
     * 查询平台前端用户
     * 
     * @param groupId 平台前端用户ID
     * @return 平台前端用户
     */
    public PlatformGroup selectPlatformGroupById(Long groupId);

    /**
     * 查询平台前端用户列表
     * 
     * @param platformGroup 平台前端用户
     * @return 平台前端用户集合
     */
    public List<PlatformGroup> selectPlatformGroupList(PlatformGroup platformGroup);

    /**
     * 新增平台前端用户
     * 
     * @param platformGroup 平台前端用户
     * @return 结果
     */
    public int insertPlatformGroup(PlatformGroup platformGroup);

    /**
     * 修改平台前端用户
     * 
     * @param platformGroup 平台前端用户
     * @return 结果
     */
    public int updatePlatformGroup(PlatformGroup platformGroup);

    /**
     * 删除平台前端用户
     * 
     * @param groupId 平台前端用户ID
     * @return 结果
     */
    public int deletePlatformGroupById(Long groupId);

    /**
     * 批量删除平台前端用户
     * 
     * @param groupIds 需要删除的数据ID
     * @return 结果
     */
    public int deletePlatformGroupByIds(Long[] groupIds);
}
