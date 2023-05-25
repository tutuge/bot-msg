package com.ruoyi.project.system.service.impl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.project.system.domain.PlatformGroup;
import com.ruoyi.project.system.mapper.PlatformGroupMapper;
import com.ruoyi.project.system.service.IPlatformGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 平台前端用户Service业务层处理
 *
 * @author ruoyi
 * @date 2023-05-25
 */
@Service
public class PlatformGroupServiceImpl implements IPlatformGroupService {
    @Autowired
    private PlatformGroupMapper platformGroupMapper;

    /**
     * 查询平台前端用户
     *
     * @param groupId 平台前端用户ID
     * @return 平台前端用户
     */
    @Override
    public PlatformGroup selectPlatformGroupById(Long groupId) {
        return platformGroupMapper.selectPlatformGroupById(groupId);
    }

    /**
     * 查询平台前端用户列表
     *
     * @param platformGroup 平台前端用户
     * @return 平台前端用户
     */
    @Override
    public List<PlatformGroup> selectPlatformGroupList(PlatformGroup platformGroup) {
        return platformGroupMapper.selectPlatformGroupList(platformGroup);
    }

    /**
     * 新增平台前端用户
     *
     * @param platformGroup 平台前端用户
     * @return 结果
     */
    @Override
    public int insertPlatformGroup(PlatformGroup platformGroup) {
        platformGroup.setCreateTime(DateUtils.getNowDate());
        return platformGroupMapper.insertPlatformGroup(platformGroup);
    }

    /**
     * 修改平台前端用户
     *
     * @param platformGroup 平台前端用户
     * @return 结果
     */
    @Override
    public int updatePlatformGroup(PlatformGroup platformGroup) {
        return platformGroupMapper.updatePlatformGroup(platformGroup);
    }

    /**
     * 批量删除平台前端用户
     *
     * @param groupIds 需要删除的平台前端用户ID
     * @return 结果
     */
    @Override
    public int deletePlatformGroupByIds(Long[] groupIds) {
        return platformGroupMapper.deletePlatformGroupByIds(groupIds);
    }

    /**
     * 删除平台前端用户信息
     *
     * @param groupId 平台前端用户ID
     * @return 结果
     */
    @Override
    public int deletePlatformGroupById(Long groupId) {
        return platformGroupMapper.deletePlatformGroupById(groupId);
    }
}
