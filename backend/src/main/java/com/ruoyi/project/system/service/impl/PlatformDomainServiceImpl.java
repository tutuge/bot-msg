package com.ruoyi.project.system.service.impl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.project.system.domain.PlatformDomain;
import com.ruoyi.project.system.mapper.PlatformDomainMapper;
import com.ruoyi.project.system.service.IPlatformDomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 平台第三方域名管理Service业务层处理
 *
 * @author none
 * @date 2022-12-30
 */
@Service
public class PlatformDomainServiceImpl implements IPlatformDomainService {
    @Autowired
    private PlatformDomainMapper platformDomainMapper;

    /**
     * 查询平台第三方域名管理
     *
     * @param id 平台第三方域名管理ID
     * @return 平台第三方域名管理
     */
    @Override
    public PlatformDomain selectPlatformDomainById(Long id) {
        return platformDomainMapper.selectPlatformDomainById(id);
    }

    @Override
    public PlatformDomain selectPlatformDomainBySource(String source) {
        return platformDomainMapper.selectPlatformDomainBySource(source);
    }

    /**
     * 查询平台第三方域名管理列表
     *
     * @param platformDomain 平台第三方域名管理
     * @return 平台第三方域名管理
     */
    @Override
    public List<PlatformDomain> selectPlatformDomainList(PlatformDomain platformDomain) {
        return platformDomainMapper.selectPlatformDomainList(platformDomain);
    }

    /**
     * 新增平台第三方域名管理
     *
     * @param platformDomain 平台第三方域名管理
     * @return 结果
     */
    @Override
    public int insertPlatformDomain(PlatformDomain platformDomain) {
        platformDomain.setCreateTime(DateUtils.getNowDate());
        PlatformDomain model = new PlatformDomain();
        model.setDomainName(platformDomain.getDomainName());
        model.setType(platformDomain.getType());
        List<PlatformDomain> platformDomains = platformDomainMapper.selectPlatformDomainList(model);
        if (platformDomains != null && platformDomains.size() > 0) {
            throw new RuntimeException("您已添加此平台此域名的相关配置");
        }
        return platformDomainMapper.insertPlatformDomain(platformDomain);
    }

    /**
     * 修改平台第三方域名管理
     *
     * @param platformDomain 平台第三方域名管理
     * @return 结果
     */
    @Override
    public int updatePlatformDomain(PlatformDomain platformDomain) {
        platformDomain.setUpdateTime(DateUtils.getNowDate());
        return platformDomainMapper.updatePlatformDomain(platformDomain);
    }

    /**
     * 批量删除平台第三方域名管理
     *
     * @param ids 需要删除的平台第三方域名管理ID
     * @return 结果
     */
    @Override
    public int deletePlatformDomainByIds(Long[] ids) {
        return platformDomainMapper.deletePlatformDomainByIds(ids);
    }

    /**
     * 删除平台第三方域名管理信息
     *
     * @param id 平台第三方域名管理ID
     * @return 结果
     */
    @Override
    public int deletePlatformDomainById(Long id) {
        return platformDomainMapper.deletePlatformDomainById(id);
    }
}
