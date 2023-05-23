package com.ruoyi.project.system.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.project.system.controller.vo.PlatformUserVo;
import com.ruoyi.project.system.domain.PlatformUser;
import com.ruoyi.project.system.mapper.PlatformUserMapper;
import com.ruoyi.project.system.service.IPlatformUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 平台前端用户Service业务层处理
 *
 * @author none
 * @date 2020-04-06
 */
@Service
public class PlatformUserServiceImpl extends ServiceImpl<PlatformUserMapper, PlatformUser> implements IPlatformUserService {
    @Autowired
    private PlatformUserMapper platformUserMapper;


    /**
     * 查询平台前端用户
     *
     * @param userId 平台前端用户ID
     * @return 平台前端用户
     */
    @Override
    public PlatformUser selectPlatformUserById(Long userId) {
        return platformUserMapper.selectPlatformUserById(userId);
    }

    @Override
    public PlatformUser selectPlatformUserByAccessToken(String accessToken) {
        return platformUserMapper.selectPlatformUserByAccessToken(accessToken);
    }

    /**
     * 查询平台前端用户列表
     *
     * @param platformUser 平台前端用户
     * @return 平台前端用户
     */
    @Override
    public List<PlatformUser> selectPlatformUserList(PlatformUser platformUser) {
        return platformUserMapper.selectPlatformUserList(platformUser);
    }

    /**
     * 新增平台前端用户
     *
     * @param platformUser 平台前端用户
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertPlatformUser(PlatformUser platformUser) {
        platformUser.setAccessToken(IdUtil.fastSimpleUUID());
        int num = platformUserMapper.insertPlatformUser(platformUser);
        return num;
    }

    /**
     * 修改平台前端用户
     *
     * @param platformUser 平台前端用户
     * @return 结果
     */
    @Override
    public int updatePlatformUser(PlatformUser platformUser) {
        return platformUserMapper.updatePlatformUser(platformUser);
    }


    /**
     * 批量删除平台前端用户
     *
     * @param userIds 需要删除的平台前端用户ID
     * @return 结果
     */
    @Override
    public int deletePlatformUserByIds(Long[] userIds) {
        return platformUserMapper.deletePlatformUserByIds(userIds);
    }

    /**
     * 删除平台前端用户信息
     *
     * @param userId 平台前端用户ID
     * @return 结果
     */
    @Override
    public int deletePlatformUserById(Long userId) {
        return platformUserMapper.deletePlatformUserById(userId);
    }

    @Override
    public List<PlatformUserVo> selectPlatformUserVoList() {
        return platformUserMapper.selectPlatformUserVoList();
    }
}
