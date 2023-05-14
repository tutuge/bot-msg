package com.ruoyi.project.system.mapper;

import com.ruoyi.project.system.domain.OpenTime;

import java.util.List;

/**
 * 产品开市时间Mapper接口
 *
 * @author none
 * @date 2020-06-08
 */
public interface PlatformOpenTimeMapper {
    /**
     * 查询产品开市时间
     *
     * @param id 产品开市时间ID
     * @return 产品开市时间
     */
    OpenTime selectPlatformOpenTimeById(Long id);

    /**
     * 查询产品开市时间列表
     *
     * @param opentime 产品开市时间
     * @return 产品开市时间集合
     */
    List<OpenTime> selectPlatformOpenTimeList(OpenTime opentime);

    /**
     * 新增产品开市时间
     *
     * @param opentime 产品开市时间
     * @return 结果
     */
    int insertPlatformOpenTime(OpenTime opentime);

    /**
     * 修改产品开市时间
     *
     * @param opentime 产品开市时间
     * @return 结果
     */
    int updatePlatformOpenTime(OpenTime opentime);

    /**
     * 删除产品开市时间
     *
     * @param id 产品开市时间ID
     * @return 结果
     */
    int deletePlatformOpenTimeById(Long id);

    /**
     * 批量删除产品开市时间
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deletePlatformOpenTimeByIds(Long[] ids);
}
