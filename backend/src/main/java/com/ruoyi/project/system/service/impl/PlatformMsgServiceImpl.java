package com.ruoyi.project.system.service.impl;

import com.ruoyi.project.system.domain.PlatformMsg;
import com.ruoyi.project.system.mapper.PlatformMsgMapper;
import com.ruoyi.project.system.service.IPlatformMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @author ruoyi
 * @date 2023-05-23
 */
@Service
public class PlatformMsgServiceImpl implements IPlatformMsgService {
    @Autowired
    private PlatformMsgMapper platformMsgMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param id 【请填写功能名称】ID
     * @return 【请填写功能名称】
     */
    @Override
    public PlatformMsg selectPlatformMsgById(Long id) {
        return platformMsgMapper.selectPlatformMsgById(id);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param platformMsg 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<PlatformMsg> selectPlatformMsgList(PlatformMsg platformMsg) {
        return platformMsgMapper.selectPlatformMsgList(platformMsg);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param platformMsg 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertPlatformMsg(PlatformMsg platformMsg) {
        return platformMsgMapper.insertPlatformMsg(platformMsg);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param platformMsg 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updatePlatformMsg(PlatformMsg platformMsg) {
        return platformMsgMapper.updatePlatformMsg(platformMsg);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的【请填写功能名称】ID
     * @return 结果
     */
    @Override
    public int deletePlatformMsgByIds(Long[] ids) {
        return platformMsgMapper.deletePlatformMsgByIds(ids);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param id 【请填写功能名称】ID
     * @return 结果
     */
    @Override
    public int deletePlatformMsgById(Long id) {
        return platformMsgMapper.deletePlatformMsgById(id);
    }
}