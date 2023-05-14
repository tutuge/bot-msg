package com.ruoyi.project.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.project.system.domain.PlatformUser;

import java.util.List;

/**
 * 平台前端用户Mapper接口
 *
 * @author none
 * @date 2020-04-06
 */
public interface PlatformUserMapper extends BaseMapper<PlatformUser> {
    /**
     * 查询平台前端用户
     *
     * @param userId 平台前端用户ID
     * @return 平台前端用户
     */
    PlatformUser selectPlatformUserById(Long userId);

    /**
     * 查询平台前端用户列表
     *
     * @param platformUser 平台前端用户
     * @return 平台前端用户集合
     */
    List<PlatformUser> selectPlatformUserList(PlatformUser platformUser);

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
     * 删除平台前端用户
     *
     * @param userId 平台前端用户ID
     * @return 结果
     */
    int deletePlatformUserById(Long userId);

    /**
     * 批量删除平台前端用户
     *
     * @param userIds 需要删除的数据ID
     * @return 结果
     */
    int deletePlatformUserByIds(Long[] userIds);

    PlatformUser selectPlatformUserByAccessToken(String accessToken);
}
