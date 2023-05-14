package com.ruoyi.project.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.project.system.domain.PlatformProductInfoInformation;

import java.util.List;

/**
 * 产品的多语言文本信息Service接口
 *
 * @author none
 * @date 2023-02-05
 */
public interface IPlatformProductinfoInformationService extends IService<PlatformProductInfoInformation> {
    /**
     * 查询产品的多语言文本信息
     *
     * @param id 产品的多语言文本信息ID
     * @return 产品的多语言文本信息
     */
    PlatformProductInfoInformation selectPlatformProductinfoInformationById(Long id);

    /**
     * 查询产品的多语言文本信息列表
     *
     * @param platformProductinfoInformation 产品的多语言文本信息
     * @return 产品的多语言文本信息集合
     */
    List<PlatformProductInfoInformation> selectPlatformProductinfoInformationList(PlatformProductInfoInformation platformProductinfoInformation);

    /**
     * 新增产品的多语言文本信息
     *
     * @param platformProductinfoInformation 产品的多语言文本信息
     * @return 结果
     */
    int insertPlatformProductinfoInformation(PlatformProductInfoInformation platformProductinfoInformation);

    /**
     * 修改产品的多语言文本信息
     *
     * @param platformProductinfoInformation 产品的多语言文本信息
     * @return 结果
     */
    int updatePlatformProductinfoInformation(PlatformProductInfoInformation platformProductinfoInformation);

    /**
     * 批量删除产品的多语言文本信息
     *
     * @param ids 需要删除的产品的多语言文本信息ID
     * @return 结果
     */
    int deletePlatformProductinfoInformationByIds(Long[] ids);

    /**
     * 删除产品的多语言文本信息信息
     *
     * @param id 产品的多语言文本信息ID
     * @return 结果
     */
    int deletePlatformProductinfoInformationById(Long id);
}
