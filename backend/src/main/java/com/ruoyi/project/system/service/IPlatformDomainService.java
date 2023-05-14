package com.ruoyi.project.system.service;

import com.ruoyi.project.system.domain.PlatformDomain;

import java.util.List;

/**
 * 平台第三方域名管理Service接口
 *
 * @author none
 * @date 2022-12-30
 */
public interface IPlatformDomainService {
    /**
     * 查询平台第三方域名管理
     *
     * @param id 平台第三方域名管理ID
     * @return 平台第三方域名管理
     */
    PlatformDomain selectPlatformDomainById(Long id);

    PlatformDomain selectPlatformDomainBySource(String source);

    /**
     * 查询平台第三方域名管理列表
     *
     * @param platformDomain 平台第三方域名管理
     * @return 平台第三方域名管理集合
     */
    List<PlatformDomain> selectPlatformDomainList(PlatformDomain platformDomain);

    /**
     * 新增平台第三方域名管理
     *
     * @param platformDomain 平台第三方域名管理
     * @return 结果
     */
    int insertPlatformDomain(PlatformDomain platformDomain);

    /**
     * 修改平台第三方域名管理
     *
     * @param platformDomain 平台第三方域名管理
     * @return 结果
     */
    int updatePlatformDomain(PlatformDomain platformDomain);

    /**
     * 批量删除平台第三方域名管理
     *
     * @param ids 需要删除的平台第三方域名管理ID
     * @return 结果
     */
    int deletePlatformDomainByIds(Long[] ids);

    /**
     * 删除平台第三方域名管理信息
     *
     * @param id 平台第三方域名管理ID
     * @return 结果
     */
    int deletePlatformDomainById(Long id);
}
