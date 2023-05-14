package com.ruoyi.framework.task.service.impl;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.framework.task.service.TaskService;
import com.ruoyi.framework.task.service.UpdateProdService;
import com.ruoyi.project.system.domain.PlatformProductInfo;
import com.ruoyi.project.system.domain.enumd.BasicEnum;
import com.ruoyi.project.system.domain.vo.CurrencyVo;
import com.ruoyi.project.system.service.PlatformProductInfoService;
import com.ruoyi.project.system.util.HttpClientUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
public class TaskServiceImpl implements TaskService {

    @Autowired
    private ICurrencyService currencyService;

    @Autowired
    private PlatformProductInfoService platformProductInfoService;

    @Autowired
    private UpdateProdService updateProdService;


    @Override
    public void refreshCurrencyPrice() {
        List<CurrencyVo> cacheList = currencyService.queryListAll();
        if (cacheList == null || cacheList.size() == 0) {
            log.error("当前未找到币种信息...");
            return;
        }
        String currencyNames = "";
        for (CurrencyVo currencyVo : cacheList) {
            if ("".equals(currencyNames)) {
                currencyNames = currencyVo.getFullName().toLowerCase();
            } else {
                currencyNames = currencyNames + "," + currencyVo.getFullName().toLowerCase();
            }
        }
        //listRate转map集合  key为fullName,value为币种ID
        String requestUrl = "https://api.coingecko.com/api/v3/simple/price?ids=" + currencyNames + "&vs_currencies=usd";
        //获取数据
        String result = HttpClientUtils.get(requestUrl);
        //String result = "{\"bitcoin\":{\"usd\":20226},\"ethereum\":{\"usd\":1031.18},\"tron\":{\"usd\":0.050366}}";
        JSONObject jsonObject = JSONObject.parseObject(result);
        //使用币种名称予以缓存
        RedisUtils.setCacheObject(BasicEnum.CURRENCY.getValue() + currencyNames, jsonObject);
    }

    @Override
    public void updateRealTimePrice() {
        //获取所有的开市产品
        List<PlatformProductInfo> productInfos = platformProductInfoService.queryAllOpenProd();
        if (productInfos == null || productInfos.size() == 0) {
            return;
        }
        Map<String, List<PlatformProductInfo>> collect = productInfos.stream().collect(Collectors.groupingBy(PlatformProductInfo::getType));
        //更新外汇产品的实时价格
        updateProdService.updateForeignExchangePrice(collect.get("1"));
        //更新加密货币的实时价格
        updateProdService.updateEncryptionCurrencyPrice(collect.get("2"));
        //更新美股产品的实时价格
        updateProdService.updateUSSharesPrice(collect.get("3"));
        //更新期货产品实时价格
        updateProdService.updateFuturePrice(collect.get("4"));
        //更新ETF产品实时价格
        updateProdService.updateETFPrice(collect.get("5"));
    }

    @Override
    public void updateProdKLine(String timeType) {
        //timeType:0-1分钟，1-5min，2-30min，3-1week，4-1Mon，5-15min，6-1H，7：4-H，8-1D
        //获取所有的开始产品
        List<PlatformProductInfo> productInfos = platformProductInfoService.queryAllOpenProd();
        if (productInfos == null || productInfos.size() == 0) {
            return;
        }
        Map<String, List<PlatformProductInfo>> collect = productInfos.stream().collect(Collectors.groupingBy(PlatformProductInfo::getType));
//        //更新加密货币产品K线
//        updateProdService.updateEncryptionCurrencyKLine(collect.get("2"), timeType);
//        //更新外汇产品的K线
//        updateProdService.updateForeignExchangeKLine(collect.get("1"), timeType);
//        //更新美股产品K线
//        updateProdService.updateUSSharesKLine(collect.get("3"), timeType);
        //更新ETF产品K线
        updateProdService.updateETFKLine(collect.get("5"), timeType);
        //更新期货产品K线--期货的暂时不要缓存了，因为已经缓存了
        //updateProdService.updateFutureKLine(collect.get("4"), timeType);
    }

}
