package com.ruoyi.project.system.service;

import com.ruoyi.project.system.domain.PlatformProductInfo;

import java.util.List;

/**
 * 产品信息Service接口
 *
 * @author none
 * @date 2020-06-08
 */
public interface PlatformProductInfoService {
    /**
     * 查询产品信息
     *
     * @param pid 产品信息ID
     * @return 产品信息
     */
    PlatformProductInfo selectPlatformProductinfoById(Long pid);

    /**
     * 查询产品信息列表
     *
     * @param platformProductinfo 产品信息
     * @return 产品信息集合
     */
    List<PlatformProductInfo> selectPlatformProductinfoList(PlatformProductInfo platformProductinfo);

    /**
     * 新增产品信息
     *
     * @param platformProductinfo 产品信息
     * @return 结果
     */
    Long insertPlatformProductInfo(PlatformProductInfo platformProductinfo);

    /**
     * 修改产品信息
     *
     * @param platformProductinfo 产品信息
     * @return 结果
     */
    int updatePlatformProductinfo(PlatformProductInfo platformProductinfo);

    /**
     * 批量删除产品信息
     *
     * @param pids 需要删除的产品信息ID
     * @return 结果
     */
    int deletePlatformProductInfoByIds(Long[] pids);

    /**
     * 查询正在开市的产品列表
     * @return
     */
    List<PlatformProductInfo> queryAllOpenProd();

}
