package com.ruoyi.project.system.service;

import com.ruoyi.project.system.domain.PlatformMsg;

import java.util.List;

/**
 * 【请填写功能名称】Service接口
 *
 * @author ruoyi
 * @date 2023-05-23
 */
public interface IPlatformMsgService {
    /**
     * 查询【请填写功能名称】
     *
     * @param id 【请填写功能名称】ID
     * @return 【请填写功能名称】
     */
    PlatformMsg selectPlatformMsgById(Long id);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param platformMsg 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    List<PlatformMsg> selectPlatformMsgList(PlatformMsg platformMsg);

    /**
     * 新增【请填写功能名称】
     *
     * @param platformMsg 【请填写功能名称】
     * @return 结果
     */
    int insertPlatformMsg(PlatformMsg platformMsg);

    /**
     * 修改【请填写功能名称】
     *
     * @param platformMsg 【请填写功能名称】
     * @return 结果
     */
    int updatePlatformMsg(PlatformMsg platformMsg);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的【请填写功能名称】ID
     * @return 结果
     */
    int deletePlatformMsgByIds(Long[] ids);

    /**
     * 删除【请填写功能名称】信息
     *
     * @param id 【请填写功能名称】ID
     * @return 结果
     */
    int deletePlatformMsgById(Long id);
}
