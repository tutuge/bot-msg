package com.ruoyi.project.system.service;

import com.ruoyi.project.system.domain.OpenTime;

import java.util.List;

/**
 * 产品开市时间Service接口
 *
 * @author none
 * @date 2020-06-08
 */
public interface PlatformOpenTimeService {

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
     * 获取开市时间
     *
     * @param pidType
     * @return
     */
    String getOpenTimeByPid(String pidType);
}
