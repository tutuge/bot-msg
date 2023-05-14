package com.ruoyi.project.system.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.common.page.PageQuery;
import com.ruoyi.common.page.TableDataInfo;
import com.ruoyi.framework.task.vo.NetworkCurrencyVo;
import com.ruoyi.project.system.domain.Currency;
import com.ruoyi.project.system.domain.bo.CurrencyBo;
import com.ruoyi.project.system.domain.vo.CurrencyVo;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;

/**
 * 平台币种Service接口
 *
 * @author none
 * @date 2022-05-10
 */
public interface ICurrencyService extends IService<Currency> {

    /**
     * 查询平台币种
     *
     * @param id 平台币种主键
     * @return 平台币种
     */
    CurrencyVo queryById(Long id);

    /**
     * 查询平台币种列表
     *
     * @param currency 平台币种
     * @return 平台币种集合
     */
    TableDataInfo<CurrencyVo> queryPageList(CurrencyBo bo, PageQuery pageQuery);

    /**
     * 查询平台币种列表
     *
     * @param currency 平台币种
     * @return 平台币种集合
     */
    List<CurrencyVo> queryList(CurrencyBo bo);

    /**
     * 查询平台所有币种列表
     *
     * @return 平台币种
     */
    List<CurrencyVo> queryListAll();

    /**
     * 修改平台币种
     *
     * @param currency 平台币种
     * @return 结果
     */
    Boolean insertByBo(CurrencyBo bo);

    /**
     * 修改平台币种
     *
     * @param currency 平台币种
     * @return 结果
     */
    Boolean updateByBo(CurrencyBo bo);

    /**
     * 校验并批量删除平台币种信息
     *
     * @param ids     需要删除的平台币种主键集合
     * @param isValid 是否校验,true-删除前校验,false-不校验
     * @return 结果
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 查询平台所有币种列表包含充值网络
     *
     * @return 平台币种
     */
    List<CurrencyVo> queryCurrencyContainsNet();

    /**
     * 币种转换成USD
     *
     * @param currencyId
     * @param amount
     * @return
     */
    BigDecimal doExchange(Long currencyId, BigDecimal amount);

    /**
     * 币种转换成USDT
     *
     * @param currencyId
     * @param amount
     * @return
     */
    BigDecimal doExchangeUSDT(Long currencyId, BigDecimal coinNum);

    /**
     * 根据币种ID获取币种
     *
     * @param id
     * @return
     */
    CurrencyVo getCurrencyById(Long id);

    /**
     * 根据充值网络ID获取包含币种信息
     *
     * @param netId
     * @return
     */
    NetworkCurrencyVo getNetworkCurrencyVoByNetId(Long netId);

    /**
     * 根据充值网络ID获取包含币种信息
     *
     * @param netName
     * @return
     */
    NetworkCurrencyVo getNetworkCurrencyVoByNetName(String netName);
}
