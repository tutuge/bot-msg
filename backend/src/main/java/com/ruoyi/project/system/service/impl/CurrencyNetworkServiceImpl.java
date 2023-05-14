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
import com.ruoyi.project.system.domain.CurrencyNetwork;
import com.ruoyi.project.system.domain.bo.CurrencyNetworkBo;
import com.ruoyi.project.system.domain.enumd.BasicEnum;
import com.ruoyi.project.system.domain.vo.CurrencyNetworkVo;
import com.ruoyi.project.system.domain.vo.NetworkVo;
import com.ruoyi.project.system.mapper.CurrencyNetworkMapper;
import com.ruoyi.project.system.service.ICurrencyNetworkService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 币种充值网络Service业务层处理
 *
 * @author none
 * @date 2022-05-10
 */
@Service
public class CurrencyNetworkServiceImpl extends ServiceImpl<CurrencyNetworkMapper, CurrencyNetwork> implements ICurrencyNetworkService {

    @Autowired
    private CurrencyNetworkMapper baseMapper;

    /**
     * 查询币种充值网络
     *
     * @param id 币种充值网络主键
     * @return 币种充值网络
     */
    @Override
    public CurrencyNetworkVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 查询币种充值网络列表
     *
     * @param bo 币种充值网络
     * @return 币种充值网络
     */
    @Override
    public TableDataInfo<CurrencyNetworkVo> queryPageList(CurrencyNetworkBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<CurrencyNetwork> lqw = buildQueryWrapper(bo);
        Page<CurrencyNetworkVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询币种充值网络列表
     *
     * @param bo 币种充值网络
     * @return 币种充值网络
     */
    @Override
    public List<CurrencyNetworkVo> queryList(CurrencyNetworkBo bo) {
        LambdaQueryWrapper<CurrencyNetwork> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<CurrencyNetwork> buildQueryWrapper(CurrencyNetworkBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<CurrencyNetwork> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getParentId() != null, CurrencyNetwork::getParentId, bo.getParentId());
        lqw.like(StringUtils.isNotBlank(bo.getNetworkName()), CurrencyNetwork::getNetworkName, bo.getNetworkName());
        lqw.eq(StringUtils.isNotBlank(bo.getAddress()), CurrencyNetwork::getAddress, bo.getAddress());
        lqw.eq(StringUtils.isNotBlank(bo.getQrcode()), CurrencyNetwork::getQrcode, bo.getQrcode());
        lqw.eq(StringUtils.isNotBlank(bo.getType()), CurrencyNetwork::getType, bo.getType());
        lqw.orderByAsc(CurrencyNetwork::getSeqNum);
        return lqw;
    }

    /**
     * 新增币种充值网络
     *
     * @param bo 币种充值网络
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(CurrencyNetworkBo bo) {
        CurrencyNetwork add = BeanUtil.toBean(bo, CurrencyNetwork.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        deleteRedisCurrencyListAllValue();
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改币种充值网络
     *
     * @param bo 币种充值网络
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(CurrencyNetworkBo bo) {
        CurrencyNetwork update = BeanUtil.toBean(bo, CurrencyNetwork.class);
        validEntityBeforeSave(update);
        deleteRedisCurrencyListAllValue();
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     *
     * @param entity 实体类数据
     */
    private void validEntityBeforeSave(CurrencyNetwork entity) {
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除币种充值网络
     *
     * @param ids 需要删除的币种充值网络主键
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
    public List<NetworkVo> queryAllNet() {
        List<NetworkVo> cacheList = RedisUtils.getCacheList(BasicEnum.NETWORK_ALL.getValue());
        if (ObjectUtil.isNull(cacheList) || CollectionUtil.isEmpty(cacheList)) {
            cacheList = baseMapper.selectNetworkVo();
            if (CollectionUtil.isNotEmpty(cacheList)) {
                RedisUtils.setCacheList(BasicEnum.NETWORK_ALL.getValue(), cacheList);
            }
        }
        return cacheList;
    }

    /**
     * 删掉数据库内存的本对象的列表内的所有值
     */
    private void deleteRedisCurrencyListAllValue() {
        RedisUtils.deleteObject(BasicEnum.NETWORK_ALL.getValue());
    }
}
