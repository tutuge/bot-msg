package com.ruoyi.project.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.RedisUtils;
import com.ruoyi.project.system.domain.PlatformProductData;
import com.ruoyi.project.system.mapper.PlatformProductDataMapper;
import com.ruoyi.project.system.service.IPlatformProductdataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 产品相关数据Service业务层处理
 *
 * @author none
 * @date 2020-06-08
 */
@Service
public class PlatformProductdataServiceImpl extends ServiceImpl<PlatformProductDataMapper, PlatformProductData> implements IPlatformProductdataService {
    @Autowired
    private PlatformProductDataMapper platformProductdataMapper;

    /**
     * 新增产品相关数据
     *
     * @param platformProductdata 产品相关数据
     * @return 结果
     */
    @Override
    public int insertPlatformProductData(PlatformProductData platformProductdata) {
        platformProductdata.setCreateTime(DateUtils.getNowDate());
        return platformProductdataMapper.insertPlatformProductdata(platformProductdata);
    }

    /**
     * 修改产品相关数据
     *
     * @param platformProductdata 产品相关数据
     * @return 结果
     */
    @Override
    public int updatePlatformProductdata(PlatformProductData platformProductdata) {
        platformProductdata.setUpdateTime(DateUtils.getNowDate());
        return platformProductdataMapper.updatePlatformProductdata(platformProductdata);
    }

    @Override
    public PlatformProductData selectDataByProductId(Long pid) {
        // TODO Auto-generated method stub
        PlatformProductData data = null;
        if (RedisUtils.hasKey(pid + "_data")) {
            data = RedisUtils.getCacheObject(pid + "_data");
        } else {
            LambdaQueryWrapper<PlatformProductData> dataLambdaQueryWrapper = new LambdaQueryWrapper<>();
            dataLambdaQueryWrapper.eq(PlatformProductData::getPid, pid);
            data = this.getOne(dataLambdaQueryWrapper);
        }
        return data;
    }

}
