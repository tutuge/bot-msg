package com.ruoyi.project.common;

/**
 * @author none
 */
public class PublicMarketApi {

    //期货API
    public static String QH_AppKey = "203948829";

    public static String QH_AppSecret = "851e7KK5amCnlVUm22T5EAznjdp50UJT";

    public static String QH_AppCode = "6a6859b790714ffebb6475a1452da71d";

    //期货的实时行情
    public static String QH_RealUrl = "https://futures.market.alicloudapi.com/real";

    //期货K线数据
    public static String QH_KlineUrl = "https://futures.market.alicloudapi.com/kline";

    /**
     * 三方行情数据API_KEY
     */
    public static String API_KEY = "QKG8UC1NVNQGW314";

    /**
     * ETF三方行情数据API_KEY
     */
    public static String ETF_API_KEY = "64206502ef8de7.32520329";

    /**
     * 数据返回的条数
     */
    public static String OUTPUT_SIZE = "200";


    /**
     * 请求地址前缀
     */
    public static String BASE_HTTPS = "https://www.alphavantage.co/query";

    //---------------------------------ETF-------------------------------------
    /**
     * ETF请求地址前缀
     */
    public static String BASE_ETF_HTTPS = "https://eodhistoricaldata.com/";
    /**
     * etf实时数据的redis使用的key
     */
    public static String ETF_REAL_TIME = "ETF_REAL_TIME:";
    public static String ETF_IN_DAY = "ETF_IN_DAY:";
    public static String ETF_DWM = "ETF_DWM:";

    /*----------------------------美股数据接口开始-----------------------------*/

    /**
     * 美股的日内数据function传值
     * 支持K线类型（1min, 5min, 15min, 30min, 60min）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=demo">美股的日内数据function传值</a>
     */
    public static String MG_TIME_SERIES_DAY = "TIME_SERIES_INTRADAY";

    /**
     * 美股的每天的K线
     * 支持K线类型-1day
     * 请求示例：<a href="https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&outputsize=full&apikey=demo">美股的每天的K线</a>
     */
    public static String MG_TIME_SERIES_DAILY = "TIME_SERIES_DAILY";

    /**
     * 美股的周K线
     * 支持K线类型-1week
     * 请求示例：<a href="https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=IBM&apikey=demo">美股的周K线</a>
     */
    public static String MG_TIME_SERIES_WEEKLY = "TIME_SERIES_WEEKLY";

    /**
     * 美股的月K线
     * 支持K线类型-1month
     * 请求示例：<a href="https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=IBM&apikey=demo">美股的月K线</a>
     */
    public static String MG_TIME_SERIES_MONTHLY = "TIME_SERIES_MONTHLY";

    /**
     * 美股实时行情以及涨跌幅
     * 请求示例：<a href="https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=IBM&apikey=demo">美股实时行情以及涨跌幅</a>
     */
    public static String MG_GLOBAL_QUOTE = "GLOBAL_QUOTE";

    /*----------------------------美股数据接口结束-----------------------------*/

    /**
     * 外汇或者加密货币的实时价格
     * 请求示例：<a href="https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=USD&to_currency=JPY&apikey=demo">外汇或者加密货币的实时价格</a>
     */
    public static String CURRENCY_EXCHANGE_RATE = "CURRENCY_EXCHANGE_RATE";

    /*----------------------------外汇数据接口开始-----------------------------*/

    /**
     * 外汇日内K线（1min, 5min, 15min, 30min, 60min）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=FX_INTRADAY&from_symbol=EUR&to_symbol=USD&interval=5min&outputsize=full&apikey=demo">外汇日内K线</a>
     */
    public static String FX_INTRADAY = "FX_INTRADAY";

    /**
     * 外汇日K线（1day）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=EUR&to_symbol=USD&outputsize=full&apikey=demo">外汇日K线</a>
     */
    public static String FX_DAILY = "FX_DAILY";

    /**
     * 外汇周K线（1week）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=FX_WEEKLY&from_symbol=EUR&to_symbol=USD&apikey=demo">外汇周K线</a>
     */
    public static String FX_WEEKLY = "FX_WEEKLY";

    /**
     * 外汇月K线（1month）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=FX_MONTHLY&from_symbol=EUR&to_symbol=USD&apikey=demo">外汇月K线</a>
     */
    public static String FX_MONTHLY = "FX_MONTHLY";

    /*----------------------------外汇数据接口结束-----------------------------*/

    /*----------------------------加密货币接口开始-----------------------------*/

    /**
     * 加密货币日内K线（1min, 5min, 15min, 30min, 60min）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=CRYPTO_INTRADAY&symbol=ETH&market=USD&interval=5min&outputsize=full&apikey=demo">加密货币日内K线</a>
     */
    public static String CRYPTO_IN_TODAY = "CRYPTO_INTRADAY";

    /**
     * 加密货币日K线（1day）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_DAILY&symbol=BTC&market=CNY&apikey=demo">加密货币日K线</a>
     */
    public static String DIGITAL_CURRENCY_DAILY = "DIGITAL_CURRENCY_DAILY";

    /**
     * 加密货币周K线（1week）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_WEEKLY&symbol=BTC&market=CNY&apikey=demo">加密货币周K线</a>
     */
    public static String DIGITAL_CURRENCY_WEEKLY = "DIGITAL_CURRENCY_WEEKLY";

    /**
     * 加密货币月K线（1month）
     * 请求示例：<a href="https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_MONTHLY&symbol=BTC&market=CNY&apikey=demo">加密货币月K线</a>
     */
    public static String DIGITAL_CURRENCY_MONTHLY = "DIGITAL_CURRENCY_MONTHLY";

    /*----------------------------加密货币接口结束-----------------------------*/

    /*----------------------------期货接口开始-----------------------------*/

    public static String FUTURE = "FUTURE:";
    public static String FUTURE_REAL_TIME = "FUTURE_REAL_TIME:";



    // 获取所有交易对实时的行情数据
    public static String HB_TICKERS_URL = "https://api.huobi.pro/market/tickers";

    //获取交易对的K线
    public static String HB_KLINE = "https://api.huobi.pro/market/history/kline";


}
