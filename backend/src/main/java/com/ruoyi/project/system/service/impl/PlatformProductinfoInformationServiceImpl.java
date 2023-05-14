package com.ruoyi.project.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.project.system.domain.PlatformProductInfoInformation;
import com.ruoyi.project.system.mapper.PlatformProductinfoInformationMapper;
import com.ruoyi.project.system.service.IPlatformProductinfoInformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 产品的多语言文本信息Service业务层处理
 *
 * @author none
 * @date 2023-02-05
 */
@Service
public class PlatformProductinfoInformationServiceImpl extends ServiceImpl<PlatformProductinfoInformationMapper, PlatformProductInfoInformation> implements IPlatformProductinfoInformationService {
    @Autowired
    private PlatformProductinfoInformationMapper platformProductinfoInformationMapper;

    /**
     * 查询产品的多语言文本信息
     *
     * @param id 产品的多语言文本信息ID
     * @return 产品的多语言文本信息
     */
    @Override
    public PlatformProductInfoInformation selectPlatformProductinfoInformationById(Long id) {
        return platformProductinfoInformationMapper.selectPlatformProductinfoInformationById(id);
    }

    /**
     * 查询产品的多语言文本信息列表
     *
     * @param platformProductinfoInformation 产品的多语言文本信息
     * @return 产品的多语言文本信息
     */
    @Override
    public List<PlatformProductInfoInformation> selectPlatformProductinfoInformationList(PlatformProductInfoInformation platformProductinfoInformation) {
        return platformProductinfoInformationMapper.selectPlatformProductinfoInformationList(platformProductinfoInformation);
    }

    /**
     * 新增产品的多语言文本信息
     *
     * @param platformProductinfoInformation 产品的多语言文本信息
     * @return 结果
     */
    @Override
    public int insertPlatformProductinfoInformation(PlatformProductInfoInformation platformProductinfoInformation) {
        platformProductinfoInformation.setCreateTime(DateUtils.getNowDate());
        return platformProductinfoInformationMapper.insertPlatformProductinfoInformation(platformProductinfoInformation);
    }

    /**
     * 修改产品的多语言文本信息
     *
     * @param platformProductinfoInformation 产品的多语言文本信息
     * @return 结果
     */
    @Override
    public int updatePlatformProductinfoInformation(PlatformProductInfoInformation platformProductinfoInformation) {
        return platformProductinfoInformationMapper.updatePlatformProductinfoInformation(platformProductinfoInformation);
    }

    /**
     * 批量删除产品的多语言文本信息
     *
     * @param ids 需要删除的产品的多语言文本信息ID
     * @return 结果
     */
    @Override
    public int deletePlatformProductinfoInformationByIds(Long[] ids) {
        return platformProductinfoInformationMapper.deletePlatformProductinfoInformationByIds(ids);
    }

    /**
     * 删除产品的多语言文本信息信息
     *
     * @param id 产品的多语言文本信息ID
     * @return 结果
     */
    @Override
    public int deletePlatformProductinfoInformationById(Long id) {
        return platformProductinfoInformationMapper.deletePlatformProductinfoInformationById(id);
    }
}
