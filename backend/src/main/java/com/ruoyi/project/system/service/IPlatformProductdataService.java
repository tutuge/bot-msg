package com.ruoyi.project.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.project.system.domain.PlatformProductData;

/**
 * 产品相关数据Service接口
 *
 * @author none
 * @date 2020-06-08
 */
public interface IPlatformProductdataService extends IService<PlatformProductData> {

    /**
     * 新增产品相关数据
     *
     * @param platformProductdata 产品相关数据
     * @return 结果
     */
    int insertPlatformProductData(PlatformProductData platformProductdata);

    /**
     * 修改产品相关数据
     *
     * @param platformProductdata 产品相关数据
     * @return 结果
     */
    int updatePlatformProductdata(PlatformProductData platformProductdata);

    PlatformProductData selectDataByProductId(Long pid);

}
