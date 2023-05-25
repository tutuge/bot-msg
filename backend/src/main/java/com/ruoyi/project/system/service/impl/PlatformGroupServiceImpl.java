package com.ruoyi.project.system.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.project.system.controller.vo.PlatformUserVo;
import com.ruoyi.project.system.domain.PlatformGroup;
import com.ruoyi.project.system.domain.PlatformUser;
import com.ruoyi.project.system.mapper.PlatformGroupMapper;
import com.ruoyi.project.system.service.IPlatformGroupService;
import com.ruoyi.project.system.service.IPlatformUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 平台前端用户组Service业务层处理
 *
 * @author ruoyi
 * @date 2023-05-25
 */
@Service
public class PlatformGroupServiceImpl implements IPlatformGroupService {
    @Resource
    private PlatformGroupMapper platformGroupMapper;
    @Resource
    private IPlatformUserService platformUserService;

    /**
     * 查询平台前端用户组
     *
     * @param groupId 平台前端用户组ID
     * @return 平台前端用户组
     */
    @Override
    public PlatformGroup selectPlatformGroupById(Long groupId) {
        return platformGroupMapper.selectPlatformGroupById(groupId);
    }

    /**
     * 查询平台前端用户组列表
     *
     * @param platformGroup 平台前端用户组
     * @return 平台前端用户组
     */
    @Override
    public List<PlatformGroup> selectPlatformGroupList(PlatformGroup platformGroup) {
        return platformGroupMapper.selectPlatformGroupList(platformGroup);
    }

    /**
     * 新增平台前端用户组
     *
     * @param platformGroup 平台前端用户组
     * @return 结果
     */
    @Override
    public int insertPlatformGroup(PlatformGroup platformGroup) {
        platformGroup.setCreateTime(DateUtils.getNowDate());
        return platformGroupMapper.insertPlatformGroup(platformGroup);
    }

    /**
     * 修改平台前端用户组
     *
     * @param platformGroup 平台前端用户组
     * @return 结果
     */
    @Override
    public int updatePlatformGroup(PlatformGroup platformGroup) {
        return platformGroupMapper.updatePlatformGroup(platformGroup);
    }

    /**
     * 批量删除平台前端用户组
     *
     * @param groupIds 需要删除的平台前端用户组ID
     * @return 结果
     */
    @Override
    public int deletePlatformGroupByIds(Long[] groupIds) {
        PlatformUser platformUser = new PlatformUser();
        for (Long id : groupIds) {
            platformUser.setUserGroupId(id);
            List<PlatformUserVo> list = platformUserService.selectPlatformUserList(platformUser);
            if (CollUtil.isNotEmpty(list)) {
                throw new RuntimeException("当前用户组名称仍然在被使用，无法删除");
            }
        }
        return platformGroupMapper.deletePlatformGroupByIds(groupIds);
    }

    /**
     * 删除平台前端用户组信息
     *
     * @param groupId 平台前端用户组ID
     * @return 结果
     */
    @Override
    public int deletePlatformGroupById(Long groupId) {
        PlatformUser platformUser = new PlatformUser();
        platformUser.setUserGroupId(groupId);
        List<PlatformUserVo> list = platformUserService.selectPlatformUserList(platformUser);
        if (CollUtil.isNotEmpty(list)) {
            throw new RuntimeException("当前用户组名称仍然在被使用，无法删除");
        }
        return platformGroupMapper.deletePlatformGroupById(groupId);
    }
}
