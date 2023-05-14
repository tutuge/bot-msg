package com.ruoyi.project.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.project.system.domain.PlatformProductData;

import java.util.List;

/**
 * 产品相关数据Mapper接口
 *
 * @author none
 * @date 2020-06-08
 */
public interface PlatformProductDataMapper extends BaseMapper<PlatformProductData> {
    /**
     * 查询产品相关数据
     *
     * @param id 产品相关数据ID
     * @return 产品相关数据
     */
    PlatformProductData selectPlatformProductDataById(Long id);

    /**
     * 查询产品相关数据列表
     *
     * @param platformProductdata 产品相关数据
     * @return 产品相关数据集合
     */
    List<PlatformProductData> selectPlatformProductdataList(PlatformProductData platformProductdata);

    /**
     * 新增产品相关数据
     *
     * @param platformProductdata 产品相关数据
     * @return 结果
     */
    int insertPlatformProductdata(PlatformProductData platformProductdata);

    /**
     * 修改产品相关数据
     *
     * @param platformProductdata 产品相关数据
     * @return 结果
     */
    int updatePlatformProductdata(PlatformProductData platformProductdata);

    /**
     * 删除产品相关数据
     *
     * @param id 产品相关数据ID
     * @return 结果
     */
    int deletePlatformProductdataById(Long id);

    /**
     * 批量删除产品相关数据
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deletePlatformProductdataByIds(Long[] ids);

    PlatformProductData selectDataByProductId(Long pid);

    List<PlatformProductData> selectPlatformProductdataByPairId(Long pairId);
}
