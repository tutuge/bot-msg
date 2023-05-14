package com.ruoyi.framework.task.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 包含实时行情和涨跌幅度，以及K线数据
 */
@Data
public class KData implements Serializable {

    private static final long serialVersionUID = 1L;

    private String price;//实时价格

    private String rands;//涨跌幅

    private String low;//最低

    private String high;//最高

    private String open;//开盘价

    private String bidPrice;//买入价

    private String askPrice;//卖出价

    private List<KdataNew> kLineDataList; //K线集合
}
