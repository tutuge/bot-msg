package com.ruoyi.framework.task.service.impl;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.redis.RedisCache;
import com.ruoyi.framework.task.service.UpdateProdService;
import com.ruoyi.project.common.PublicMarketApi;
import com.ruoyi.project.system.domain.PlatformProductInfo;
import com.ruoyi.project.system.service.ISysConfigService;
import com.ruoyi.project.system.service.PlatformOpenTimeService;
import com.ruoyi.project.system.util.HttpClientUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static com.ruoyi.project.common.PublicMarketApi.*;

@Service
@Slf4j
public class UpdateProdServiceImpl implements UpdateProdService {

    @Autowired
    private PlatformOpenTimeService platformOpenTimeService;

    @Autowired
    private ISysConfigService sysConfigService;
    @Autowired
    private RedisCache redisCache;

    /**
     * 返回的到限额的值
     */
    private final String errorBack = "You exceeded your daily API requests limit.  Please contact support@eodhistoricaldata.com";
    /**
     * 新的错误
     */
    private final String errorBack0 = "Thank you for using Alpha Vantage!";

    /**
     * 外汇实时价格
     *
     * @param productInfoList
     */
    @Override
    @Async("customExecutor")
    public void updateForeignExchangePrice(List<PlatformProductInfo> productInfoList) {
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            try {
                Long pid = platformProductinfo.getPid();
                //判断当前是否开市
                boolean isOpen = checkOpenTime(pid);
                if (!isOpen) {
                    continue;
                }
                String proCode = platformProductinfo.getProcode();
                //切割字符串
                String[] split = proCode.split("/");
                if (split.length != 2) {
                    log.error("外汇产品设置有问题-->{}", platformProductinfo);
                    continue;
                }
                String realTimeUrl = PublicMarketApi.BASE_HTTPS + "?function="
                        + CURRENCY_EXCHANGE_RATE + "&apikey=" + PublicMarketApi.API_KEY;
                String realTimeRequestUrl = realTimeUrl + "&from_currency=" + split[0] + "&to_currency=" + split[1];
                String realTimeResult = HttpClientUtils.get(realTimeRequestUrl);
                if (StringUtils.isNotBlank(realTimeResult)) {
                    convertJson(CURRENCY_EXCHANGE_RATE + ":" + split[0] + ":" + split[1], realTimeResult);
                }
            } catch (Exception e) {
                log.error("获取外汇产品的实时行情数据失败----->{}", platformProductinfo.getProcode());
            }

        }
    }

    /**
     * 加密货币实时价格
     *
     * @param productInfoList
     */
    @Override
    @Async("customExecutor")
    public void updateEncryptionCurrencyPrice(List<PlatformProductInfo> productInfoList) {
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        String realTimeUrl = PublicMarketApi.BASE_HTTPS + "?function=" + PublicMarketApi.CURRENCY_EXCHANGE_RATE + "&apikey=" + PublicMarketApi.API_KEY;
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            try {
                Long pid = platformProductinfo.getPid();
                //判断当前是否开市
                boolean isOpen = checkOpenTime(pid);
                if (!isOpen) {
                    continue;
                }

                String proCode = platformProductinfo.getProcode();
                //切割字符串
                String[] split = proCode.split("/");
                if (split.length != 2) {
                    log.error("加密货币产品设置有问题-->{}", platformProductinfo);
                    continue;
                }
                String realTimeRequestUrl = realTimeUrl + "&from_currency=" + split[0] + "&to_currency=" + split[1];
                String result = HttpClientUtils.get(realTimeRequestUrl);
                if (StringUtils.isNotBlank(result)) {
                    convertJson(CURRENCY_EXCHANGE_RATE + ":" + split[0] + ":" + split[1], result);
                }
            } catch (Exception e) {
                log.error("获取加密货币产品的实时行情数据失败----->{}", platformProductinfo.getProcode());
            }
        }
    }


    /**
     * 实时价格美股
     *
     * @param productInfoList
     */
    @Override
    @Async("customExecutor")
    public void updateUSSharesPrice(List<PlatformProductInfo> productInfoList) {
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        //实时价格美股
        String url = PublicMarketApi.BASE_HTTPS + "?function=" + MG_GLOBAL_QUOTE + "&apikey="
                + PublicMarketApi.API_KEY;
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            try {
                Long pid = platformProductinfo.getPid();
                //判断当前是否开市
                boolean isOpen = checkOpenTime(pid);
                if (!isOpen) {
                    continue;
                }
                String proCode = platformProductinfo.getProcode();
                if (StrUtil.isBlank(proCode)) {
                    log.error("美股获取设置有问题-->{}", platformProductinfo);
                }
                String requestUrl = url + "&symbol=" + proCode;
                String result = HttpClientUtils.get(requestUrl);
                if (StringUtils.isNotBlank(result)) {
                    JSONObject jsonObject = JSONObject.parseObject(result);
                    log.info("jsonObject-->{}", jsonObject);
                    convertJson(MG_GLOBAL_QUOTE + ":" + proCode, result);
                }
            } catch (Exception e) {
                log.error("获取美股产品的实时行情数据失败----->{}", platformProductinfo.getProcode());
            }
        }
    }

    /**
     * ETF实时价格
     *
     * @param productInfoList
     */
    @Override
    @Async("customExecutor")
    public void updateETFPrice(List<PlatformProductInfo> productInfoList) {
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }

        String url = PublicMarketApi.BASE_ETF_HTTPS + "api/real-time/";
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            try {
                Long pid = platformProductinfo.getPid();
                //判断当前是否开市
                boolean isOpen = checkOpenTime(pid);
                if (!isOpen) {
                    continue;
                }
                String proCode = platformProductinfo.getProcode();
                String requestUrl = url + proCode + "?fmt=json&api_token=" + PublicMarketApi.ETF_API_KEY;
                String result = HttpClientUtils.get(requestUrl);
                if (StringUtils.isNotBlank(result)) {
                    convertJson(ETF_REAL_TIME + proCode, result);
                }
            } catch (Exception e) {
                log.error("获取ETF产品的实时行情数据失败----->{}", platformProductinfo.getProcode());
            }
        }
    }

    /**
     * 加密货币K线
     *
     * @param productInfoList
     * @param timeType
     */
    @Override
    @Async("customExecutor")
    public void updateEncryptionCurrencyKLine(List<PlatformProductInfo> productInfoList, String timeType) {
        log.info("开始更新加密货币K线");
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        //1:1min, 2:5min, 3:15min, 4:30min, 5:60min, 6:1day,7:1week,8: 1month
        String url = PublicMarketApi.BASE_HTTPS + "?apikey=" + PublicMarketApi.API_KEY;
        String function;
        String interval = "";
        boolean flag = "1".equals(timeType) || "2".equals(timeType) || "3".equals(timeType) || "4".equals(timeType) || "5".equals(timeType);
        if (flag) {
            // 加密货币K线（1min、5min、15min、30min、60 min）
            function = PublicMarketApi.CRYPTO_IN_TODAY;
            interval = getIntervalForeignExchange(timeType);
            url = url + "&function=" + function + "&interval=" + interval;
        } else if ("6".equals(timeType)) {
            //加密货币K线（1day）
            function = PublicMarketApi.DIGITAL_CURRENCY_DAILY;
            url = url + "&function=" + function;
        } else if ("7".equals(timeType)) {
            //加密货币K线（1week）
            function = PublicMarketApi.DIGITAL_CURRENCY_WEEKLY;
            url = url + "&function=" + function;
        } else if ("8".equals(timeType)) {
            //加密货币K线（1month）
            function = PublicMarketApi.DIGITAL_CURRENCY_MONTHLY;
            url = url + "&function=" + function;
        }
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            try {
                Long pid = platformProductinfo.getPid();
                boolean isOpen = checkOpenTime(pid);
                if (!isOpen) {
                    continue;
                }
                String proCode = platformProductinfo.getProcode();
                String[] proCodeArr = proCode.split("/");
                if (proCodeArr.length != 2) {
                    log.error("加密货币K线产品设置有问题-->{}", platformProductinfo);
                    continue;
                }
                String s0 = proCodeArr[0];
                String s1 = proCodeArr[1];
                String requestUrl = url + "&symbol=" + s0 + "&market=" + s1;
                String result = HttpClientUtils.get(requestUrl);
                if (StringUtils.isNotBlank(result)) {
                    if (flag) {
                        convertJson(CRYPTO_IN_TODAY + ":" + interval + ":" + s0 + ":" + s1, result);
                    } else if ("6".equals(timeType)) {
                        //加密货币K线（1day）
                        convertJson(DIGITAL_CURRENCY_DAILY + ":" + s0 + ":" + s1, result);
                    } else if ("7".equals(timeType)) {
                        //加密货币K线（1week）
                        convertJson(DIGITAL_CURRENCY_WEEKLY + ":" + s0 + ":" + s1, result);
                    } else if ("8".equals(timeType)) {
                        //加密货币K线（1month）
                        convertJson(DIGITAL_CURRENCY_MONTHLY + ":" + s0 + ":" + s1, result);
                    }
                }
            } catch (Exception e) {
                log.error("获取加密货币K线失败---->{}", platformProductinfo.getProcode());
            }

        }
    }

    /**
     * 外汇K线
     *
     * @param productInfoList
     * @param timeType
     */
    @Override
    @Async("customExecutor")
    public void updateForeignExchangeKLine(List<PlatformProductInfo> productInfoList, String timeType) {
        log.info("开始更新外汇K线");
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        //1:1min, 2:5min, 3:15min, 4:30min, 5:60min, 6:1day,7:1week,8: 1month
        String url = PublicMarketApi.BASE_HTTPS + "?apikey=" + PublicMarketApi.API_KEY;
        String function;
        String interval = "";
        boolean flag = "1".equals(timeType) || "2".equals(timeType) || "3".equals(timeType) || "4".equals(timeType) || "5".equals(timeType);
        if (flag) {
            //外汇K线（1min、5min、15min、30min、60min）
            function = PublicMarketApi.FX_INTRADAY;
            interval = getIntervalForeignExchange(timeType);
            url = url + "&function=" + function + "&interval=" + interval;
        } else if ("6".equals(timeType)) {
            //外汇K线（1day）
            function = PublicMarketApi.FX_DAILY;
            url = url + "&function=" + function;
        } else if ("7".equals(timeType)) {
            //外汇K线（1week）
            function = PublicMarketApi.FX_WEEKLY;
            url = url + "&function=" + function;
        } else if ("8".equals(timeType)) {
            function = PublicMarketApi.FX_MONTHLY;
            //外汇K线（1month）
            url = url + "&function=" + function;
        }
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            try {
                Long pid = platformProductinfo.getPid();
                boolean isOpen = checkOpenTime(pid);
                if (!isOpen) {
                    continue;
                }
                String proCode = platformProductinfo.getProcode();
                String[] proCodeArr = proCode.split("/");
                if (proCodeArr.length != 2) {
                    log.error("加密货币K线产品设置有问题-->{}", platformProductinfo);
                    continue;
                }
                String s0 = proCodeArr[0];
                String s1 = proCodeArr[1];
                String requestUrl = url + "&from_symbol=" + s0 + "&to_symbol=" + s1;
                String result = HttpClientUtils.get(requestUrl);
                if (StringUtils.isNotBlank(result)) {
                    if (flag) {
                        //外汇K线（1min、5min、15min、30min、60min）
                        convertJson(FX_INTRADAY + ":" + interval + ":" + s0 + ":" + s1, result);
                    } else if ("6".equals(timeType)) {
                        //外汇K线（1day）
                        convertJson(FX_DAILY + ":" + s0 + ":" + s1, result);
                    } else if ("7".equals(timeType)) {
                        //外汇K线（1week）
                        convertJson(FX_WEEKLY + ":" + s0 + ":" + s1, result);
                    } else if ("8".equals(timeType)) {
                        //外汇K线（1month）
                        convertJson(FX_MONTHLY + ":" + s0 + ":" + s1, result);
                    }
                }
            } catch (Exception e) {
                log.error("获取外汇产品K线失败---->{}", platformProductinfo.getProcode());
            }
        }
    }


    /**
     * 美股K线
     *
     * @param productInfoList
     * @param timeType
     */
    @Override
    @Async("customExecutor")
    public void updateUSSharesKLine(List<PlatformProductInfo> productInfoList, String timeType) {
        log.info("开始更新美股K线");
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        //1:1min, 2:5min, 3:15min, 4:30min, 5:60min, 6:1day,7:1week,8: 1month
        String url = PublicMarketApi.BASE_HTTPS + "?apikey=" + PublicMarketApi.API_KEY;
        String function;
        String interval = "";
        boolean flag = "1".equals(timeType) || "2".equals(timeType) || "3".equals(timeType) || "4".equals(timeType) || "5".equals(timeType);
        if (flag) {
            //美股K线（1min、5min、15min、30min、60min）
            function = PublicMarketApi.MG_TIME_SERIES_DAY;
            interval = getIntervalForeignExchange(timeType);
            url = url + "&function=" + function + "&interval=" + interval;
        } else if ("6".equals(timeType)) {
            //美股K线（1day）
            function = PublicMarketApi.MG_TIME_SERIES_DAILY;
            url = url + "&function=" + function;
        } else if ("7".equals(timeType)) {
            //美股K线（1week）
            function = PublicMarketApi.MG_TIME_SERIES_WEEKLY;
            url = url + "&function=" + function;
        } else if ("8".equals(timeType)) {
            //美股K线（1month）
            function = PublicMarketApi.MG_TIME_SERIES_MONTHLY;
            url = url + "&function=" + function;
        }
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            try {
                Long pid = platformProductinfo.getPid();
                boolean isOpen = checkOpenTime(pid);
                if (!isOpen) {
                    continue;
                }
                String proCode = platformProductinfo.getProcode();
                String requestUrl = url + "&symbol=" + proCode;
                String result = HttpClientUtils.get(requestUrl);
                if (StringUtils.isNotBlank(result)) {
                    if (flag) {
                        //美股K线（1min、5min、15min、30min、60min）
                        convertJson(MG_TIME_SERIES_DAY + ":" + interval + ":" + proCode, result);
                    } else if ("6".equals(timeType)) {
                        //美股K线（1day）
                        convertJson(MG_TIME_SERIES_DAILY + ":" + proCode, result);
                    } else if ("7".equals(timeType)) {
                        //美股K线（1week）
                        convertJson(MG_TIME_SERIES_WEEKLY + ":" + proCode, result);
                    } else if ("8".equals(timeType)) {
                        //美股K线（1month）
                        convertJson(MG_TIME_SERIES_MONTHLY + ":" + proCode, result);
                    }
                }
            } catch (Exception e) {
                log.error("获取美股产品K线失败---->{}", platformProductinfo.getProcode());
            }

        }
    }

    /**
     * ETFK线
     *
     * @param productInfoList
     * @param timeType
     */
    @Override
    @Async("customExecutor")
    public void updateETFKLine(List<PlatformProductInfo> productInfoList, String timeType) {
        log.info("开始更新ETFK线");
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        //1:1min, 2:5min, 3:15min, 4:30min, 5:60min, 6:1day,7:1week,8: 1month
        //ETFK线（1m、5m、15m、30m、1h）
        String url = PublicMarketApi.BASE_ETF_HTTPS + "api/intraday/";
        String interval = "";
        boolean flag = "1".equals(timeType) || "2".equals(timeType) || "3".equals(timeType) || "4".equals(timeType) || "5".equals(timeType);
        String midStr = "";
        //获取30天的数据
        Date date = DateUtils.addAndSubtractDaysByCalendar(new Date(), -30);
        long toTime = System.currentTimeMillis() / 1000;
        long fromTime = date.getTime() / 1000;
        if (flag) {
            interval = getETFIntervalForeignExchange(timeType);
            midStr = "&interval=" + interval + "&from=" + fromTime + "&to=" + toTime;
        } else {
            //ETFK线（d、w、m）
            url = PublicMarketApi.BASE_ETF_HTTPS + "api/eod/";
            interval = getETFIntervalForeignExchangeDay(timeType);
            midStr = "&period=" + interval;
        }
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            try {
                Long pid = platformProductinfo.getPid();
                boolean isOpen = checkOpenTime(pid);
                if (!isOpen) {
                    continue;
                }
                String proCode = platformProductinfo.getProcode();
                String requestUrl = url + proCode + "?api_token=" + PublicMarketApi.ETF_API_KEY + "&fmt=json" + midStr;
                String result = HttpClientUtils.get(requestUrl);
                boolean notBlank = StringUtils.isNotBlank(result);
                if (notBlank) {
                    //解析json
                    if (flag) {
                        convertJsonArray(ETF_IN_DAY + proCode + ":" + interval, result);
                    } else {
                        convertJsonArray(ETF_DWM + proCode + ":" + interval, result);
                    }
                } else {
                    log.error("当前请求结果为空");
                }
            } catch (Exception e) {
                log.error("获取ETFK线失败---->{}", platformProductinfo.getProcode());
            }
        }
    }

    /**
     * 转换字符串为json，主要也是为了统一处理错误
     *
     * @param key    缓存的key
     * @param result 值
     */
    private void convertJsonArray(String key, String result) {
//        log.error("result-->{}", result);
        if (!result.equalsIgnoreCase(errorBack) && !result.startsWith(errorBack0)) {
            try {
                JSONArray objects = JSONArray.parseArray(result);
                redisCache.setCacheObject(key, objects);
            } catch (RuntimeException e) {
                log.error("etf转换返回值报错-->key:{}-->value:{}", key, result);
            }
        } else {
            log.error("当前etf请求到达限额了");
        }
    }


    public String getIntervalForeignExchange(String timeType) {
        String interval = "";
        if ("1".equals(timeType)) {
            interval = "1min";
        } else if ("2".equals(timeType)) {
            interval = "5min";
        } else if ("3".equals(timeType)) {
            interval = "15min";
        } else if ("4".equals(timeType)) {
            interval = "30min";
        } else if ("5".equals(timeType)) {
            interval = "60min";
        }
        return interval;
    }

    public String getETFIntervalForeignExchange(String timeType) {
        //1:1min, 2:5min, 3:15min, 4:30min, 5:60min, 6:1day,7:1week,8: 1month
        String interval = "";
        if ("1".equals(timeType)) {
            interval = "1m";
        } else if ("2".equals(timeType)) {
            interval = "5m";
        } else if ("3".equals(timeType)) {
            interval = "15m";
        } else if ("4".equals(timeType)) {
            interval = "30m";
        } else if ("5".equals(timeType)) {
            interval = "1h";
        }
        return interval;
    }

    /**
     * etf根据时间类型获取查询数据的url上需要拼接的值
     *
     * @param timeType 时间类型
     * @return 范围
     */
    public String getETFIntervalForeignExchangeDay(String timeType) {
        //1:1min, 2:5min, 3:15min, 4:30min, 5:60min, 6:1day,7:1week,8: 1month
        String interval = "";
        if ("6".equals(timeType)) {
            interval = "d";
        } else if ("7".equals(timeType)) {
            interval = "w";
        } else if ("8".equals(timeType)) {
            interval = "m";
        }
        return interval;
    }

    /**
     * 更新期货产品实时价格
     *
     * @param productInfoList
     */
    @Override
    public void updateFuturePrice(List<PlatformProductInfo> productInfoList) {
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        String realUrl = sysConfigService.selectConfigByKey("future_request_url");
        String token = sysConfigService.selectConfigByKey("future_token");
        realUrl = realUrl + "/real?token=" + token;
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            Long pid = platformProductinfo.getPid();
            //判断当前是否开市
            boolean isOpen = checkOpenTime(pid);
            if (!isOpen) {
                continue;
            }
            String proCode = platformProductinfo.getProcode();
            String requestUrl = realUrl + "&symbol=" + proCode;
            String result = HttpClientUtils.get(requestUrl);
            if (StringUtils.isNotBlank(result)) {
                convertJson(FUTURE_REAL_TIME + proCode, result);
            }
        }
    }

    /**
     * 更新期货产品K线
     *
     * @param productInfoList
     * @param timeType
     */
    @Override
    @Async("customExecutor")
    public void updateFutureKLine(List<PlatformProductInfo> productInfoList, String timeType) {
        log.info("开始更新期货产品K线");
        if (productInfoList == null || productInfoList.size() == 0) {
            return;
        }
        //1:1min, 2:5min, 3:15min, 4:30min, 5:60min, 6:1day,7:1week,8: 1month
        String kLineUrl = sysConfigService.selectConfigByKey("future_request_url");
        String token = sysConfigService.selectConfigByKey("future_token");
        kLineUrl = kLineUrl + "/kline?token=" + token;
        String interval = getQhKlineType(timeType);
        for (PlatformProductInfo platformProductinfo : productInfoList) {
            String proCode = platformProductinfo.getProcode();
            String requestUrl = kLineUrl + "&limit=200&symbol=" + proCode + "&type=" + interval;
            String result = HttpClientUtils.get(requestUrl);
            if (StringUtils.isNotBlank(result)) {
                convertJson(FUTURE + proCode + ":" + interval, result);
            }
        }
    }

    /**
     * 转换字符串为json，主要也是为了统一处理错误
     *
     * @param key    缓存的key
     * @param result 值
     */
    private void convertJson(String key, String result) {
//        log.error("result-->{}", result);
        if (!result.equalsIgnoreCase(errorBack) && !result.startsWith(errorBack0)) {
            try {
                JSONObject jsonObject = JSONObject.parseObject(result);
                redisCache.setCacheObject(key, jsonObject);
            } catch (RuntimeException e) {
                log.error("转换返回值报错-->key:{}-->value:{}", key, result);
            }
        } else {
            log.error("当前请求到达限额了");
        }
    }

    /**
     * 期货间隔
     *
     * @param timeType
     * @return
     */
    public String getQhKlineType(String timeType) {
        //timeType--1:1min, 2:5min, 3:15min, 4:30min, 5:60min, 6:1day,7:1week,8: 1month
        String qhType = "";
        if ("1".equals(timeType)) {
            qhType = "1";
        } else if ("2".equals(timeType)) {
            qhType = "5";
        } else if ("3".equals(timeType)) {
            qhType = "15";
        } else if ("4".equals(timeType)) {
            qhType = "30";
        } else if ("5".equals(timeType)) {
            qhType = "60";
        } else if ("6".equals(timeType)) {
            qhType = "0";
        } else if ("7".equals(timeType)) {
            qhType = "0";
        } else if ("8".equals(timeType)) {
            qhType = "0";
        }
        return qhType;
    }


    /**
     * 校验开市时间
     *
     * @param pid
     * @return
     */
    public boolean checkOpenTime(Long pid) {
        boolean result = false;
        Date today = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(today);
        String key = pid + ":";
        int weekday = c.get(Calendar.DAY_OF_WEEK);
        if (weekday == 1) {
            key = key + "7";
        } else if (weekday == 2) {
            key = key + "1";
        } else if (weekday == 3) {
            key = key + "2";
        } else if (weekday == 4) {
            key = key + "3";
        } else if (weekday == 5) {
            key = key + "4";
        } else if (weekday == 6) {
            key = key + "5";
        } else if (weekday == 7) {
            key = key + "6";
        }
        String timeStr = platformOpenTimeService.getOpenTimeByPid(key);
        if (StringUtils.isBlank(timeStr)) {
            return false;
        }
        if (timeStr.contains("|")) {
            String[] timeArr = timeStr.split("\\|");
            for (String timeStr_ : timeArr) {
                String[] arr = timeStr_.split("~");
                // 校验开市时间
                // 设置日期格式
                SimpleDateFormat df = new SimpleDateFormat("HH:mm");
                Date now = null;
                Date beginTime = null;
                Date endTime = null;
                try {
                    now = df.parse(df.format(new Date()));
                    beginTime = df.parse(arr[0]);
                    endTime = df.parse(arr[1]);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                boolean flag = belongCalendar(now, beginTime, endTime);
                if (flag) {
                    result = true;
                    break;
                }
            }
        } else {
            String[] arr = timeStr.split("~");
            // 校验开市时间
            // 设置日期格式
            SimpleDateFormat df = new SimpleDateFormat("HH:mm");
            Date now = null;
            Date beginTime = null;
            Date endTime = null;
            try {
                now = df.parse(df.format(new Date()));
                beginTime = df.parse(arr[0]);
                endTime = df.parse(arr[1]);
            } catch (Exception e) {
                e.printStackTrace();
            }
            boolean flag = belongCalendar(now, beginTime, endTime);
            if (flag) {
                result = true;
            }
        }
        return result;
    }


    public static boolean belongCalendar(Date nowTime, Date beginTime, Date endTime) {
        Calendar date = Calendar.getInstance();
        date.setTime(nowTime);

        Calendar begin = Calendar.getInstance();
        begin.setTime(beginTime);

        Calendar end = Calendar.getInstance();
        end.setTime(endTime);
        return date.after(begin) && date.before(end);
    }
}
