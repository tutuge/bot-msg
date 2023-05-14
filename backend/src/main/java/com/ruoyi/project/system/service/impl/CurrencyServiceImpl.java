package com.ruoyi.project.system.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.page.PageQuery;
import com.ruoyi.common.page.TableDataInfo;
import com.ruoyi.common.utils.RedisUtils;
import com.ruoyi.framework.task.vo.NetworkCurrencyVo;
import com.ruoyi.project.system.domain.Currency;
import com.ruoyi.project.system.domain.CurrencyNetwork;
import com.ruoyi.project.system.domain.bo.CurrencyBo;
import com.ruoyi.project.system.domain.enumd.BasicEnum;
import com.ruoyi.project.system.domain.po.FilePo;
import com.ruoyi.project.system.domain.vo.CurrencyNetworkVo;
import com.ruoyi.project.system.domain.vo.CurrencyVo;
import com.ruoyi.project.system.domain.vo.NetworkVo;
import com.ruoyi.project.system.mapper.CurrencyMapper;
import com.ruoyi.project.system.service.ICurrencyNetworkService;
import com.ruoyi.project.system.service.ICurrencyService;
import com.ruoyi.project.system.service.ISysConfigService;
import org.apache.commons.lang3.StringUtils;
import org.redisson.api.RLock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * 平台币种Service业务层处理
 *
 * @author none
 * @date 2022-05-10
 */
@Service
public class CurrencyServiceImpl extends ServiceImpl<CurrencyMapper, Currency> implements ICurrencyService {

    /**
     * 币种分布式缓存锁
     */
    private final static String CURRENCY_LOCK = "currencyLock";
    private final static Long CURRENCY_LOCK_TIME = 3L;
    @Autowired
    private CurrencyMapper baseMapper;
    @Autowired
    private ISysConfigService sysConfigService;
    @Autowired
    private ICurrencyNetworkService currencyNetworkService;

    /**
     * 查询平台币种
     *
     * @param id 平台币种主键
     * @return 平台币种
     */
    @Override
    public CurrencyVo queryById(Long id) {
        CurrencyVo currencyVo = baseMapper.selectVoById(id);
        String base_img_url = sysConfigService.selectConfigByKey("base_img_url");
        if (StringUtils.isNotBlank(currencyVo.getPicUrl())) {
            FilePo filePo = new FilePo();
            filePo.setUrl(base_img_url+currencyVo.getPicUrl());
            List<FilePo> filePoList = new ArrayList<>();
            filePoList.add(filePo);
            currencyVo.setFileList(filePoList);
        }
        return currencyVo;
    }

    /**
     * 查询平台币种列表
     *
     * @param bo 平台币种
     * @return 平台币种
     */
    @Override
    public TableDataInfo<CurrencyVo> queryPageList(CurrencyBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<Currency> lqw = buildQueryWrapper(bo);
        Page<CurrencyVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        String base_img_url = sysConfigService.selectConfigByKey("base_img_url");
        for (int i = 0; i < result.getRecords().size(); i++) {
            result.getRecords().get(i).setPicUrl(base_img_url+result.getRecords().get(i).getPicUrl());
        }
        return TableDataInfo.build(result);
    }

    /**
     * 查询平台币种列表
     *
     * @param bo 平台币种
     * @return 平台币种
     */
    @Override
    public List<CurrencyVo> queryList(CurrencyBo bo) {
        LambdaQueryWrapper<Currency> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    @Override
    public List<CurrencyVo> queryListAll() {
        RLock lock = null;
        try {
            lock = RedisUtils.getRLock(CURRENCY_LOCK);
            if (lock.tryLock(CURRENCY_LOCK_TIME, TimeUnit.SECONDS)) {
                List<CurrencyVo> cacheList = RedisUtils.getCacheList(BasicEnum.CURRENCY_ALL.getValue());
                if (ObjectUtil.isNull(cacheList) || CollectionUtil.isEmpty(cacheList)) {
                    LambdaQueryWrapper<Currency> lambdaQueryWrapper = new LambdaQueryWrapper<>();
                    lambdaQueryWrapper.orderByAsc(Currency::getSeqNum);
                    cacheList = baseMapper.selectVoList(lambdaQueryWrapper);
                    if (CollectionUtil.isNotEmpty(cacheList)) {
                        RedisUtils.setCacheList(BasicEnum.CURRENCY_ALL.getValue(), cacheList);
                    }
                }
                return cacheList;
            } else {
                throw new RuntimeException("没能获得币种缓存！");
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

    private LambdaQueryWrapper<Currency> buildQueryWrapper(CurrencyBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<Currency> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getCurrencyName()), Currency::getCurrencyName, bo.getCurrencyName());
        lqw.orderByAsc(Currency::getSeqNum);
        return lqw;
    }

    /**
     * 新增平台币种
     *
     * @param bo 平台币种
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(CurrencyBo bo) {
        Currency add = BeanUtil.toBean(bo, Currency.class);
        validEntityBeforeSave(add);
        //处理图片
        if (bo.getFileList() != null && bo.getFileList().size() > 0) {
            String base_img_url = sysConfigService.selectConfigByKey("base_img_url");
            String picUrl = bo.getFileList().get(0).getUrl().replace(base_img_url,"");
            add.setPicUrl(picUrl);
        }
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        deleteRedisCurrencyListAllValue();
        return flag;
    }

    /**
     * 修改平台币种
     *
     * @param bo 平台币种
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(CurrencyBo bo) {
        Currency update = BeanUtil.toBean(bo, Currency.class);
        validEntityBeforeSave(update);
        deleteRedisCurrencyListAllValue();
        //处理图片
        if (bo.getFileList() != null && bo.getFileList().size() > 0) {
            update.setPicUrl(bo.getFileList().get(0).getUrl());
        }
        //处理图片
        if (bo.getFileList() != null && bo.getFileList().size() > 0) {
            String base_img_url = sysConfigService.selectConfigByKey("base_img_url");
            String picUrl = bo.getFileList().get(0).getUrl().replace(base_img_url,"");
            update.setPicUrl(picUrl);
        }
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     *
     * @param entity 实体类数据
     */
    private void validEntityBeforeSave(Currency entity) {
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除平台币种
     *
     * @param ids 需要删除的平台币种主键
     * @return 结果
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        deleteRedisCurrencyListAllValue();
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    @Override
    public List<CurrencyVo> queryCurrencyContainsNet() {
        List<CurrencyVo> cacheList = this.queryListAll();
        List<NetworkVo> networkVos = currencyNetworkService.queryAllNet();
        Map<Long, List<NetworkVo>> collect = networkVos.stream().collect(Collectors.groupingBy(NetworkVo::getCurrencyId));
        for (CurrencyVo currencyVo : cacheList) {
            if (collect.containsKey(currencyVo.getId()) && collect.get(currencyVo.getId()).size() > 0) {
                Map<String, List<NetworkVo>> collectNetWork = collect.get(currencyVo.getId()).stream().collect(Collectors.groupingBy(NetworkVo::getType));
                if (collectNetWork.containsKey("1")) {
                    currencyVo.setNetworkVos(collectNetWork.get("1"));//充值网络
                }
                if (collectNetWork.containsKey("2")) {
                    currencyVo.setNetworkVosCash(collectNetWork.get("2"));//提现网络
                }
            }
        }
        return cacheList;
    }

    @Override
    public BigDecimal doExchange(Long currencyId, BigDecimal amount) {
        CurrencyVo currencyById = this.getCurrencyById(currencyId);
        BigDecimal exchangeRate = currencyById.getExchangeRate();
        return exchangeRate.multiply(amount).setScale(2, RoundingMode.HALF_UP);
    }

    @Override
    public BigDecimal doExchangeUSDT(Long currencyId, BigDecimal coinNum) {
        CurrencyVo currencyById = this.getCurrencyById(currencyId);
        BigDecimal exchangeRate = currencyById.getExchangeRate();
        LambdaQueryWrapper<Currency> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(Currency::getCurrencyName, "USDT");
        Currency currencyUSDT = this.getOne(lambdaQueryWrapper);
        BigDecimal exchangeCoinNums = coinNum.multiply(exchangeRate).divide(currencyUSDT.getExchangeRate(), 4, RoundingMode.HALF_UP);
        return exchangeCoinNums;
    }

    @Override
    public CurrencyVo getCurrencyById(Long id) {
        List<CurrencyVo> currencyVos = this.queryListAll();
        Map<Long, CurrencyVo> collect = currencyVos.stream().collect(Collectors.toMap(CurrencyVo::getId, currencyVo -> currencyVo));
        CurrencyVo currencyVo = collect.get(id);
        return currencyVo;
    }

    @Override
    public NetworkCurrencyVo getNetworkCurrencyVoByNetId(Long netId) {
        CurrencyNetworkVo currencyNetworkVo = currencyNetworkService.queryById(netId);
        NetworkCurrencyVo networkCurrencyVo = new NetworkCurrencyVo();
        CurrencyVo currencyVo = this.queryById(currencyNetworkVo.getParentId());
        networkCurrencyVo.setCurrencyId(currencyNetworkVo.getParentId());
        networkCurrencyVo.setCurrencyName(currencyVo.getCurrencyName());
        networkCurrencyVo.setId(currencyNetworkVo.getId());
        networkCurrencyVo.setNetworkName(currencyNetworkVo.getNetworkName());
        networkCurrencyVo.setType(currencyNetworkVo.getType());
        networkCurrencyVo.setServiceCharge(currencyNetworkVo.getServiceCharge());
        networkCurrencyVo.setMinWithdrawal(currencyNetworkVo.getMinWithdrawal());
        networkCurrencyVo.setAddress(currencyNetworkVo.getAddress());
        return networkCurrencyVo;
    }

    @Override
    public NetworkCurrencyVo getNetworkCurrencyVoByNetName(String netName) {
        LambdaQueryWrapper<CurrencyNetwork> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(CurrencyNetwork::getNetworkName, netName);
        CurrencyNetwork currencyNetwork = currencyNetworkService.getOne(lambdaQueryWrapper);
        NetworkCurrencyVo networkCurrencyVo = new NetworkCurrencyVo();
        CurrencyVo currencyVo = this.queryById(currencyNetwork.getParentId());
        networkCurrencyVo.setCurrencyId(currencyNetwork.getParentId());
        networkCurrencyVo.setCurrencyName(currencyVo.getCurrencyName());
        networkCurrencyVo.setId(currencyNetwork.getId());
        networkCurrencyVo.setNetworkName(currencyNetwork.getNetworkName());
        networkCurrencyVo.setType(currencyNetwork.getType());
        networkCurrencyVo.setServiceCharge(currencyNetwork.getServiceCharge());
        networkCurrencyVo.setMinWithdrawal(currencyNetwork.getMinWithdrawal());
        networkCurrencyVo.setExchangeRate(currencyVo.getExchangeRate());
        return networkCurrencyVo;
    }

    /**
     * 删掉数据库内存的本对象的列表内的所有值
     */
    private void deleteRedisCurrencyListAllValue() {
        RedisUtils.deleteObject(BasicEnum.CURRENCY_ALL.getValue());
    }
}
