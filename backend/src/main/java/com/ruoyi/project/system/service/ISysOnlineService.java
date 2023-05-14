package com.ruoyi.project.system.service;

import com.ruoyi.project.system.domain.SysOnline;

import java.util.List;

/**
 * 用户在线情况Service接口
 *
 * @author none
 * @date 2022-10-06
 */
public interface ISysOnlineService {
    /**
     * 查询用户在线情况
     *
     * @param id 用户在线情况ID
     * @return 用户在线情况
     */
    SysOnline selectSysOnlineById(Long id);

    /**
     * 查询用户在线情况列表
     *
     * @param sysOnline 用户在线情况
     * @return 用户在线情况集合
     */
    List<SysOnline> selectSysOnlineList(SysOnline sysOnline);

    /**
     * 新增用户在线情况
     *
     * @param sysOnline 用户在线情况
     * @return 结果
     */
    int insertSysOnline(SysOnline sysOnline);

    /**
     * 修改用户在线情况
     *
     * @param sysOnline 用户在线情况
     * @return 结果
     */
    int updateSysOnline(SysOnline sysOnline);

    /**
     * 批量删除用户在线情况
     *
     * @param ids 需要删除的用户在线情况ID
     * @return 结果
     */
    int deleteSysOnlineByIds(Long[] ids);

    /**
     * 删除用户在线情况信息
     *
     * @param id 用户在线情况ID
     * @return 结果
     */
    int deleteSysOnlineById(Long id);
}
