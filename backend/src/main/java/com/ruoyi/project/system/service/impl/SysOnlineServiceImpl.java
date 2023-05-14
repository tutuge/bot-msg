package com.ruoyi.project.system.service.impl;

import com.ruoyi.project.system.domain.SysOnline;
import com.ruoyi.project.system.mapper.SysOnlineMapper;
import com.ruoyi.project.system.service.ISysOnlineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户在线情况Service业务层处理
 *
 * @author none
 * @date 2022-10-06
 */
@Service
public class SysOnlineServiceImpl implements ISysOnlineService {
    @Autowired
    private SysOnlineMapper sysOnlineMapper;

    /**
     * 查询用户在线情况
     *
     * @param id 用户在线情况ID
     * @return 用户在线情况
     */
    @Override
    public SysOnline selectSysOnlineById(Long id) {
        return sysOnlineMapper.selectSysOnlineById(id);
    }

    /**
     * 查询用户在线情况列表
     *
     * @param sysOnline 用户在线情况
     * @return 用户在线情况
     */
    @Override
    public List<SysOnline> selectSysOnlineList(SysOnline sysOnline) {
        return sysOnlineMapper.selectSysOnlineList(sysOnline);
    }

    /**
     * 新增用户在线情况
     *
     * @param sysOnline 用户在线情况
     * @return 结果
     */
    @Override
    public int insertSysOnline(SysOnline sysOnline) {
        return sysOnlineMapper.insertSysOnline(sysOnline);
    }

    /**
     * 修改用户在线情况
     *
     * @param sysOnline 用户在线情况
     * @return 结果
     */
    @Override
    public int updateSysOnline(SysOnline sysOnline) {
        return sysOnlineMapper.updateSysOnline(sysOnline);
    }

    /**
     * 批量删除用户在线情况
     *
     * @param ids 需要删除的用户在线情况ID
     * @return 结果
     */
    @Override
    public int deleteSysOnlineByIds(Long[] ids) {
        return sysOnlineMapper.deleteSysOnlineByIds(ids);
    }

    /**
     * 删除用户在线情况信息
     *
     * @param id 用户在线情况ID
     * @return 结果
     */
    @Override
    public int deleteSysOnlineById(Long id) {
        return sysOnlineMapper.deleteSysOnlineById(id);
    }
}
