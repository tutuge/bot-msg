package com.ruoyi.project.system.mapper;


import com.ruoyi.common.core.mapper.BaseMapperPlus;
import com.ruoyi.project.system.domain.CurrencyNetwork;
import com.ruoyi.project.system.domain.vo.CurrencyNetworkVo;
import com.ruoyi.project.system.domain.vo.NetworkVo;

import java.util.List;

/**
 * 币种充值网络Mapper接口
 *
 * @author none
 * @date 2022-05-10
 */
public interface CurrencyNetworkMapper extends BaseMapperPlus<CurrencyNetworkMapper, CurrencyNetwork, CurrencyNetworkVo> {
    List<NetworkVo> selectNetworkVo();
}
