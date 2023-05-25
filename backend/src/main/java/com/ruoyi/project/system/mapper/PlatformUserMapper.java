package com.ruoyi.project.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.project.system.controller.vo.PlatformUserVo;
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
    /**
     * 获取平台用户简易信息
     *
     * @return 简易信息
     */
    List<PlatformUserVo> selectPlatformUserVoList();
}
