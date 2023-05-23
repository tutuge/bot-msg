package com.ruoyi.project.system.mapper;

import java.util.List;
import com.ruoyi.project.system.domain.PlatformMsg;

/**
 * 【请填写功能名称】Mapper接口
 * 
 * @author ruoyi
 * @date 2023-05-23
 */
public interface PlatformMsgMapper 
{
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
     * 删除【请填写功能名称】
     * 
     * @param id 【请填写功能名称】ID
     * @return 结果
     */
    int deletePlatformMsgById(Long id);

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deletePlatformMsgByIds(Long[] ids);
}
