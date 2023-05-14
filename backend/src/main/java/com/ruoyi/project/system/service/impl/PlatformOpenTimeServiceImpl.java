package com.ruoyi.project.system.service.impl;

import com.ruoyi.common.utils.RedisUtils;
import com.ruoyi.project.system.domain.OpenTime;
import com.ruoyi.project.system.mapper.PlatformOpenTimeMapper;
import com.ruoyi.project.system.service.PlatformOpenTimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 产品开市时间Service业务层处理
 *
 * @author none
 * @date 2020-06-08
 */
@Service
public class PlatformOpenTimeServiceImpl implements PlatformOpenTimeService {
    @Autowired
    private PlatformOpenTimeMapper platformOpenTimeMapper;

    /**
     * 查询产品开市时间列表
     *
     * @param opentime 产品开市时间
     * @return 产品开市时间
     */
    @Override
    public List<OpenTime> selectPlatformOpenTimeList(OpenTime opentime) {
        return platformOpenTimeMapper.selectPlatformOpenTimeList(opentime);
    }

    /**
     * 新增产品开市时间
     *
     * @param opentime 产品开市时间
     * @return 结果
     */
    @Override
    public int insertPlatformOpenTime(OpenTime opentime) {
        return platformOpenTimeMapper.insertPlatformOpenTime(opentime);
    }

    private String key = "OPEN_TIME:";

    /**
     * 修改产品开市时间
     *
     * @param opentime 产品开市时间
     * @return 结果
     */
    @Override
    public int updatePlatformOpenTime(OpenTime opentime) {
        Long pid = opentime.getPid();
        String type = opentime.getType();
        RedisUtils.deleteObject(key + pid + ":" + type);
        return platformOpenTimeMapper.updatePlatformOpenTime(opentime);
    }

    @Override
    public String getOpenTimeByPid(String pidType) {
        if (RedisUtils.hasKey(key + pidType)) {
            return RedisUtils.getCacheObject(key + pidType);
        } else {
            String[] pidSplit = pidType.split(":");
            OpenTime model = new OpenTime();
            model.setPid(Long.parseLong(pidSplit[0]));
            model.setType(pidSplit[1]);
            List<OpenTime> openTimes = this.selectPlatformOpenTimeList(model);
            if (openTimes == null || openTimes.size() == 0) {
                return null;
            } else {
                RedisUtils.setCacheObject(key + pidType, openTimes.get(0).getOpenTime());
                return openTimes.get(0).getOpenTime();
            }
        }
    }
}
