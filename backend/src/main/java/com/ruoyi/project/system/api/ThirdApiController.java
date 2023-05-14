package com.ruoyi.project.system.api;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.framework.redis.RedisCache;
import com.ruoyi.framework.web.domain.AjaxResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import static com.ruoyi.project.common.PublicMarketApi.*;

@Slf4j
@Validated
@RestController
@RequestMapping("/third/api")
public class ThirdApiController {
    @Autowired
    private RedisCache redisCache;

    @GetMapping("/query")
    public Object A(@RequestParam(value = "function") String f,
                    @RequestParam(value = "from_currency", required = false) String fromCurrency,
                    @RequestParam(value = "to_currency", required = false) String toCurrency,
                    @RequestParam(value = "symbol", required = false) String symbol,
                    @RequestParam(value = "market", required = false) String market,
                    @RequestParam(value = "interval", required = false) String interval,
                    @RequestParam(value = "from_symbol", required = false) String fromSymbol,
                    @RequestParam(value = "to_symbol", required = false) String toSymbol
    ) {
        if (StrUtil.isBlank(f)) {
            return AjaxResult.error();
        }
        Object cacheObject = null;
        if (f.equals(CURRENCY_EXCHANGE_RATE)) {
            //外汇实时价格
            cacheObject = redisCache.getCacheObject(CURRENCY_EXCHANGE_RATE + ":" + fromCurrency + ":" + toCurrency);
        } else if (f.equals(MG_GLOBAL_QUOTE)) {
            //实时价格美股
            cacheObject = redisCache.getCacheObject(MG_GLOBAL_QUOTE + ":" + symbol);
        } else if (f.equals(CRYPTO_IN_TODAY)) {
            // 加密货币K线（1min、5min、15min、30min、60 min）
            cacheObject = redisCache.getCacheObject(CRYPTO_IN_TODAY + ":" + interval + ":" + symbol + ":" + market);
        } else if (f.equals(DIGITAL_CURRENCY_DAILY)) {
            //加密货币K线（1day）
            cacheObject = redisCache.getCacheObject(DIGITAL_CURRENCY_DAILY + ":" + symbol + ":" + market);
        } else if (f.equals(DIGITAL_CURRENCY_WEEKLY)) {
            //加密货币K线（1week）
            cacheObject = redisCache.getCacheObject(DIGITAL_CURRENCY_WEEKLY + ":" + symbol + ":" + market);
        } else if (f.equals(DIGITAL_CURRENCY_MONTHLY)) {
            //加密货币K线（1month）
            cacheObject = redisCache.getCacheObject(DIGITAL_CURRENCY_MONTHLY + ":" + symbol + ":" + market);
        } else if (f.equals(FX_INTRADAY)) {
            //外汇K线（1min、5min、15min、30min、60min）
            cacheObject = redisCache.getCacheObject(FX_INTRADAY + ":" + interval + ":" + fromSymbol + ":" + toSymbol);
        } else if (f.equals(FX_DAILY)) {
            //外汇K线（1day）
            cacheObject = redisCache.getCacheObject(FX_DAILY + ":" + fromSymbol + ":" + toSymbol);
        } else if (f.equals(FX_WEEKLY)) {
            //外汇K线（1week）
            cacheObject = redisCache.getCacheObject(FX_WEEKLY + ":" + fromSymbol + ":" + toSymbol);
        } else if (f.equals(FX_MONTHLY)) {
            //外汇K线（1month）
            cacheObject = redisCache.getCacheObject(FX_MONTHLY + ":" + fromSymbol + ":" + toSymbol);
        } else if (f.equals(MG_TIME_SERIES_DAY)) {
            //美股K线（1min、5min、15min、30min、60min）
            cacheObject = redisCache.getCacheObject(MG_TIME_SERIES_DAY + ":" + interval + ":" + symbol);
        } else if (f.equals(MG_TIME_SERIES_DAILY)) {
            //美股K线（1day）
            cacheObject = redisCache.getCacheObject(MG_TIME_SERIES_DAILY + ":" + symbol);
        } else if (f.equals(MG_TIME_SERIES_WEEKLY)) {
            //美股K线（1week）
            cacheObject = redisCache.getCacheObject(MG_TIME_SERIES_WEEKLY + ":" + symbol);
        } else if (f.equals(MG_TIME_SERIES_MONTHLY)) {
            //美股K线（1month）
            cacheObject = redisCache.getCacheObject(MG_TIME_SERIES_MONTHLY + ":" + symbol);
        }
        return JSONObject.toJSON(cacheObject);
    }

    //-------------------------------下面是etf--------------------------------

    /**
     * ETF实时价格
     *
     * @param etf etf代码
     * @return 最新的缓存值
     */
    @GetMapping("/api/real-time/{etf}")
    public Object B(@PathVariable("etf") String etf) {
        if (StrUtil.isBlank(etf)) {
            return AjaxResult.error();
        }
        Object cacheObject = redisCache.getCacheObject(ETF_REAL_TIME + etf);
        return JSONObject.toJSON(cacheObject);
    }

    /**
     * ETFK线（1m、5m、15m、30m、1h）
     *
     * @param etf etf代码
     * @return 最新的缓存值
     */
    @GetMapping("/api/intraday/{etf}")
    public Object B1(@PathVariable("etf") String etf,
                     @RequestParam("interval") String interval) {
        if (StrUtil.isBlank(etf)) {
            return AjaxResult.error();
        }
        Object cacheObject = redisCache.getCacheObject(ETF_IN_DAY + etf + ":" + interval);
        return JSONObject.toJSON(cacheObject);
    }

    /**
     * ETFK线（1m、5m、15m、30m、1h）
     *
     * @param etf etf代码
     * @return 最新的缓存值
     */
    @GetMapping("/api/eod/{etf}")
    public Object B2(@PathVariable("etf") String etf,
                     @RequestParam("period") String period) {
        if (StrUtil.isBlank(etf)) {
            return AjaxResult.error();
        }
        Object cacheObject = redisCache.getCacheObject(ETF_DWM + etf + ":" + period);
        return JSONObject.toJSON(cacheObject);
    }

}
