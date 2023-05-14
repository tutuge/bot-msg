package com.ruoyi.project.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.common.page.PageQuery;
import com.ruoyi.common.page.TableDataInfo;
import com.ruoyi.project.system.domain.CurrencyNetwork;
import com.ruoyi.project.system.domain.bo.CurrencyNetworkBo;
import com.ruoyi.project.system.domain.vo.CurrencyNetworkVo;
import com.ruoyi.project.system.domain.vo.NetworkVo;

import java.util.Collection;
import java.util.List;

/**
 * 币种充值网络Service接口
 *
 * @author none
 * @date 2022-05-10
 */
public interface ICurrencyNetworkService extends IService<CurrencyNetwork> {

    /**
     * 查询币种充值网络
     *
     * @param id 币种充值网络主键
     * @return 币种充值网络
     */
    CurrencyNetworkVo queryById(Long id);

    /**
     * 查询币种充值网络列表
     *
     * @param currencyNetwork 币种充值网络
     * @return 币种充值网络集合
     */
    TableDataInfo<CurrencyNetworkVo> queryPageList(CurrencyNetworkBo bo, PageQuery pageQuery);

    /**
     * 查询币种充值网络列表
     *
     * @param currencyNetwork 币种充值网络
     * @return 币种充值网络集合
     */
    List<CurrencyNetworkVo> queryList(CurrencyNetworkBo bo);

    /**
     * 修改币种充值网络
     *
     * @param currencyNetwork 币种充值网络
     * @return 结果
     */
    Boolean insertByBo(CurrencyNetworkBo bo);

    /**
     * 修改币种充值网络
     *
     * @param currencyNetwork 币种充值网络
     * @return 结果
     */
    Boolean updateByBo(CurrencyNetworkBo bo);

    /**
     * 校验并批量删除币种充值网络信息
     *
     * @param ids     需要删除的币种充值网络主键集合
     * @param isValid 是否校验,true-删除前校验,false-不校验
     * @return 结果
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 获取所有的网络
     *
     * @return
     */
    List<NetworkVo> queryAllNet();
}
