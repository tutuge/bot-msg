package com.ruoyi.project.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.project.system.controller.vo.PlatformUserVo;
import com.ruoyi.project.system.domain.PlatformUser;

import java.util.List;

/**
 * 平台前端用户Service接口
 *
 * @author none
 * @date 2020-04-06
 */
public interface IPlatformUserService extends IService<PlatformUser> {
    /**
     * 查询平台前端用户
     *
     * @param userId 平台前端用户ID
     * @return 平台前端用户
     */
    PlatformUser selectPlatformUserById(Long userId);

    /**
     * 查询平台前端用户
     *
     * @param accessToken token
     * @return 平台前端用户
     */
    PlatformUser selectPlatformUserByAccessToken(String accessToken);

    /**
     * 查询平台前端用户列表
     *
     * @param platformUser 平台前端用户
     * @return 平台前端用户集合
     */
    List<PlatformUserVo> selectPlatformUserList(PlatformUser platformUser);

    /**
     * 新增平台前端用户
     *
     * @param platformUser 平台前端用户
     * @return 结果
     */
    int insertPlatformUser(PlatformUser platformUser);

    /**
     * 修改平台前端用户
     *
     * @param platformUser 平台前端用户
     * @return 结果
     */
    int updatePlatformUser(PlatformUser platformUser);

    /**
     * 批量删除平台前端用户
     *
     * @param userIds 需要删除的平台前端用户ID
     * @return 结果
     */
    int deletePlatformUserByIds(Long[] userIds);

    /**
     * 删除平台前端用户信息
     *
     * @param userId 平台前端用户ID
     * @return 结果
     */
    int deletePlatformUserById(Long userId);

    /**
     * 获取平台用户简易信息
     *
     * @return 平台用户简易信息
     */
    List<PlatformUserVo> selectPlatformUserVoList();

    /**
     * @param msgGroupId 消息分组id
     * @return 根据消息分组id差出来的用户
     */
    List<PlatformUser> selectByMsgGroupId(Long msgGroupId);
}
