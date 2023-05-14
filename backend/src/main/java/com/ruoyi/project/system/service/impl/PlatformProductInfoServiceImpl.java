package com.ruoyi.project.system.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.ObjectUtil;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.RedisUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.project.system.domain.OpenTime;
import com.ruoyi.project.system.domain.PlatformProductData;
import com.ruoyi.project.system.domain.PlatformProductInfo;
import com.ruoyi.project.system.domain.enumd.BasicEnum;
import com.ruoyi.project.system.mapper.PlatformProductInfoMapper;
import com.ruoyi.project.system.service.IPlatformProductdataService;
import com.ruoyi.project.system.service.ISysConfigService;
import com.ruoyi.project.system.service.PlatformOpenTimeService;
import com.ruoyi.project.system.service.PlatformProductInfoService;
import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RLock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 产品信息Service业务层处理
 *
 * @author none
 * @date 2020-06-08
 */
@Service
@Slf4j
public class PlatformProductInfoServiceImpl implements PlatformProductInfoService {
    private final static String PROD_LOCK = "prodLock";
    private final static Long PROD_LOCK_TIME = 3L;

    @Autowired
    private PlatformProductInfoMapper platformProductInfoMapper;

    @Autowired
    private PlatformOpenTimeService platformOpenTimeService;

    @Autowired
    private IPlatformProductdataService platformProductDataService;

    @Autowired
    private ISysConfigService sysConfigService;

    /**
     * 查询产品信息
     *
     * @param pid 产品信息ID
     * @return 产品信息
     */
    @Override
    public PlatformProductInfo selectPlatformProductinfoById(Long pid) {
        PlatformProductInfo platformProductinfo = platformProductInfoMapper.selectPlatformProductInfoById(pid);
        //获取该产品的开市日期
        OpenTime opentime = new OpenTime();
        opentime.setPid(pid);
        List<OpenTime> list = platformOpenTimeService.selectPlatformOpenTimeList(opentime);
        if (list != null && list.size() > 0) {
            for (OpenTime openTime : list) {
                switch (openTime.getType()) {
                    case "1":
                        platformProductinfo.setZhouyi(openTime.getOpenTime());
                        break;
                    case "2":
                        platformProductinfo.setZhouer(openTime.getOpenTime());
                        break;
                    case "3":
                        platformProductinfo.setZhousan(openTime.getOpenTime());
                        break;
                    case "4":
                        platformProductinfo.setZhousi(openTime.getOpenTime());
                        break;
                    case "5":
                        platformProductinfo.setZhouwu(openTime.getOpenTime());
                        break;
                    case "6":
                        platformProductinfo.setZhouliu(openTime.getOpenTime());
                        break;
                    case "7":
                        platformProductinfo.setZhouri(openTime.getOpenTime());
                        break;
                    default:
                        break;
                }
            }
        }
        return platformProductinfo;
    }

    /**
     * 查询产品信息列表
     *
     * @param platformProductinfo 产品信息
     * @return 产品信息
     */
    @Override
    public List<PlatformProductInfo> selectPlatformProductinfoList(PlatformProductInfo platformProductinfo) {
        return platformProductInfoMapper.selectPlatformProductinfoList(platformProductinfo);
    }

    /**
     * 新增产品信息
     *
     * @param platformProductinfo 产品信息
     * @return 结果
     */
    @Override
    public Long insertPlatformProductInfo(PlatformProductInfo platformProductinfo) {
        platformProductinfo.setCreateTime(DateUtils.getNowDate());
        //处理图片
        if (platformProductinfo.getFileList() != null && platformProductinfo.getFileList().size() > 0) {
            String base_img_url = sysConfigService.selectConfigByKey("base_img_url");
            String picUrl = platformProductinfo.getFileList().get(0).getUrl().replace(base_img_url, "");
            platformProductinfo.setPicUrl(picUrl);
        }
        platformProductInfoMapper.insertPlatformProductinfo(platformProductinfo);
        Long id = platformProductinfo.getPid();
        //增加产品的开市时间关联关系
        if (platformProductinfo.getZhouyi() != null && !"".equals(platformProductinfo.getZhouyi())) {
            String zhouyi = platformProductinfo.getZhouyi();
            insertPlatformOpenTimeDomain(zhouyi, "1", id);
        }
        if (platformProductinfo.getZhouer() != null && !"".equals(platformProductinfo.getZhouer())) {
            String zhouyi = platformProductinfo.getZhouer();
            insertPlatformOpenTimeDomain(zhouyi, "2", id);
        }
        if (platformProductinfo.getZhousan() != null && !"".equals(platformProductinfo.getZhousan())) {
            String zhouyi = platformProductinfo.getZhousan();
            insertPlatformOpenTimeDomain(zhouyi, "3", id);
        }
        if (platformProductinfo.getZhousi() != null && !"".equals(platformProductinfo.getZhousi())) {
            String zhouyi = platformProductinfo.getZhousi();
            insertPlatformOpenTimeDomain(zhouyi, "4", id);
        }
        if (platformProductinfo.getZhouwu() != null && !"".equals(platformProductinfo.getZhouwu())) {
            String zhouyi = platformProductinfo.getZhouwu();
            insertPlatformOpenTimeDomain(zhouyi, "5", id);
        }
        if (platformProductinfo.getZhouliu() != null && !"".equals(platformProductinfo.getZhouliu())) {
            String zhouyi = platformProductinfo.getZhouliu();
            insertPlatformOpenTimeDomain(zhouyi, "6", id);
        }
        if (platformProductinfo.getZhouri() != null && !"".equals(platformProductinfo.getZhouri())) {
            String zhouyi = platformProductinfo.getZhouri();
            insertPlatformOpenTimeDomain(zhouyi, "7", id);
        }
        //创建产品和产品数据的关联关系
        PlatformProductData platformProductdata = new PlatformProductData();
        platformProductdata.setPid(id);
        platformProductdata.setName(platformProductinfo.getProcode());//产品代码
        platformProductdata.setCreateTime(new Date());
        platformProductdata.setOpen("0");
        platformProductdata.setLow("0");
        platformProductdata.setPre("0");
        platformProductdata.setHigh("0");
        //更新漲跌幅，涨跌幅==（现价--昨日收盘价）*100/昨日收盘价
        platformProductdata.setRands("0");
        platformProductdata.setPrice("0");
        platformProductdata.setClose("0");
        platformProductdata.setBidPrice("0");
        platformProductdata.setAskPrice("0");
        deleteRedisOpenProd();
        platformProductDataService.insertPlatformProductData(platformProductdata);
        return id;
    }

    private void insertPlatformOpenTimeDomain(String day, String type, Long id) {
        day = day.replace(" ", "");
        OpenTime opentime = new OpenTime();
        opentime.setOpenTime(day);
        opentime.setType(type);
        opentime.setPid(id);
        platformOpenTimeService.insertPlatformOpenTime(opentime);
        RedisUtils.setCacheObject(id + "_" + type, day);
    }

    /**
     * 开市时间统一处理方法
     *
     * @param day  周几
     * @param type 对应周几 的1234567
     * @param pid  pid
     * @param id   id
     */
    private void ifNotPresentSet(String day, String type, Long pid, Long id) {
        OpenTime query = new OpenTime();
        query.setType(type);
        query.setPid(pid);
        List<OpenTime> list = platformOpenTimeService.selectPlatformOpenTimeList(query);
        if (list != null && list.size() > 0) {
            OpenTime openTime = list.get(0);
            if (StringUtils.isNotBlank(day)) {
                openTime.setOpenTime(day.replace(" ", ""));
                RedisUtils.setCacheObject(id + "_" + type, day);
            } else {
                openTime.setOpenTime(null);
                RedisUtils.deleteObject(id + "_" + type);
            }
            platformOpenTimeService.updatePlatformOpenTime(openTime);
        } else {
            OpenTime openTime = new OpenTime();
            if (StringUtils.isNotBlank(day)) {
                openTime.setOpenTime(day.replace(" ", ""));
                RedisUtils.setCacheObject(id + "_" + type, day);
            } else {
                openTime.setOpenTime(null);
                RedisUtils.deleteObject(id + "_" + type);
            }
            openTime.setType(type);
            openTime.setPid(pid);
            platformOpenTimeService.insertPlatformOpenTime(openTime);
        }
    }

    /**
     * 修改产品信息
     *
     * @param platformProductinfo 产品信息
     * @return 结果
     */
    @Override
    public int updatePlatformProductinfo(PlatformProductInfo platformProductinfo) {
        Long pid = platformProductinfo.getPid();
        PlatformProductInfo platformProductInfo_ = platformProductInfoMapper.selectPlatformProductInfoById(pid);
        Long id = platformProductInfo_.getPid();

        //增加产品的开市时间关联关系
        //判断是否存在开市日期
        String zhouyi = platformProductinfo.getZhouyi();
        ifNotPresentSet(zhouyi, "1", pid, id);

        //判断是否存在开市日期
        String zhouer = platformProductinfo.getZhouer();
        ifNotPresentSet(zhouer, "2", pid, id);
        //判断是否存在开市日期
        String zhousan = platformProductinfo.getZhousan();
        ifNotPresentSet(zhousan, "3", pid, id);

        //判断是否存在开市日期
        String zhousi = platformProductinfo.getZhousi();
        ifNotPresentSet(zhousi, "4", pid, id);

        //判断是否存在开市日期
        String zhouwu = platformProductinfo.getZhouwu();
        ifNotPresentSet(zhouwu, "5", pid, id);
        //判断是否存在开市日期
        String zhouliu = platformProductinfo.getZhouliu();
        ifNotPresentSet(zhouliu, "6", pid, id);
        //判断是否存在开市日期
        String zhour = platformProductinfo.getZhouri();
        ifNotPresentSet(zhour, "7", pid, id);
        /*if (platformProductinfo.getPicUrl() != null && !platformProductinfo.getPicUrl().equals("")) {
            if (platformProductinfo_.getPicUrl() != null) {
                if (platformProductinfo.getPicUrl().contains(platformProductinfo_.getPicUrl())) {
                    platformProductinfo.setPicUrl(platformProductinfo_.getPicUrl());
                }
            }
        }*/
        deleteRedisOpenProd();
        //处理图片
        if (platformProductinfo.getFileList() != null && platformProductinfo.getFileList().size() > 0) {
            String base_img_url = sysConfigService.selectConfigByKey("base_img_url");
            String picUrl = platformProductinfo.getFileList().get(0).getUrl().replace(base_img_url, "");
            platformProductinfo.setPicUrl(picUrl);
        }
        return platformProductInfoMapper.updatePlatformProductinfo(platformProductinfo);
    }


    /**
     * 批量删除产品信息
     *
     * @param pids 需要删除的产品信息ID
     * @return 结果
     */
    @Override
    public int deletePlatformProductInfoByIds(Long[] pids) {
        deleteRedisOpenProd();
        return platformProductInfoMapper.deletePlatformProductinfoByIds(pids);
    }

    @Override
    public List<PlatformProductInfo> queryAllOpenProd() {
        RLock lock = null;
        try {
            lock = RedisUtils.getRLock(PROD_LOCK);
            if (lock.tryLock(PROD_LOCK_TIME, TimeUnit.SECONDS)) {
                List<PlatformProductInfo> cacheList = RedisUtils.getCacheList(BasicEnum.OPEN_PROD_ALL.getValue());
                if (ObjectUtil.isNull(cacheList) || CollectionUtil.isEmpty(cacheList)) {
                    PlatformProductInfo model = new PlatformProductInfo();
                    model.setIsopen("0");
                    cacheList = this.selectPlatformProductinfoList(model);
                    if (CollectionUtil.isNotEmpty(cacheList)) {
                        RedisUtils.setCacheList(BasicEnum.OPEN_PROD_ALL.getValue(), cacheList);
                    }
                }
                return cacheList;
            } else {
                return null;
            }
        } catch (InterruptedException e) {
            log.error(e.getMessage());
        } finally {
            //如果当前线程保持锁定则解锁
            if (null != lock && lock.isHeldByCurrentThread()) {
                lock.unlock();
            }
        }
        return null;
    }

    private void deleteRedisOpenProd() {
        RedisUtils.deleteObject(BasicEnum.OPEN_PROD_ALL.getValue());
        RedisUtils.deleteObject(BasicEnum.TOP_PROD_ALL.getValue());
        RedisUtils.deleteObject(BasicEnum.PROD_ALL.getValue());
        RedisUtils.deleteObject(BasicEnum.PROD_PC.getValue());
    }
}
