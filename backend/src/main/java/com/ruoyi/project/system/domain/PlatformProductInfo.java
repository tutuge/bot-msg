package com.ruoyi.project.system.domain;

import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import com.ruoyi.project.system.domain.po.FilePo;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * 产品信息对象 platform_productinfo
 *
 * @author none
 * @date 2020-06-08
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class PlatformProductInfo extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * $column.columnComment
     */
    private Long pid;

    /**
     * 标题
     */
    @Excel(name = "产品名称")
    private String ptitle;

    /**
     * 手续费
     */
    @Excel(name = "手续费")
    private Double commission;

    /**
     * 开市方案id
     */
    @Excel(name = "开市方案id")
    private Long otid;

    /**
     * 是否开市
     */
    @Excel(name = "是否开市")
    private String isopen;

    /**
     * 产品logo
     */
    @Excel(name = "产品logo")
    private String picUrl;

    /**
     * 每点x元
     */
    @Excel(name = "每点x元")
    private Double pointMoney;

    @Excel(name = "产品类型，1：外汇产品，2：加密货币，3:美股产品，4:期货产品，5：ETF产品")
    private String type;

    /**
     * 波动最小值
     */
    @Excel(name = "波动最小值")
    private String pointLow;

    /**
     * 波动最大值
     */
    @Excel(name = "波动最大值")
    private String pointTop;

    /**
     * 随机波动范围
     */
    @Excel(name = "随机波动范围")
    private String rands;

    /**
     * 快捷下单金额
     */
    @Excel(name = "快捷下单金额")
    private String moneyList;

    /**
     * 是否删除
     */
    @Excel(name = "是否删除")
    private Integer isdelete;

    /**
     * 产品代码
     */
    @Excel(name = " 产品代码")
    private String procode;

    /**
     * 杠杆倍数
     */
    @Excel(name = "杠杆倍数")
    private Double gearing;

    /**
     * 一手（x）元
     */
    @Excel(name = "一手", readConverterExp = "x=")
    private Double handMoney;

    /**
     * 除汇率以外的算法
     */
    @Excel(name = "除汇率以外的算法")
    private Double addData;

    /**
     * 时间玩法间隔
     */
    @Excel(name = "时间玩法间隔")
    private String protime;

    /**
     * 点位玩法间隔
     */
    @Excel(name = "点位玩法间隔")
    private String propoint;

    /**
     * 盈亏比例
     */
    @Excel(name = "盈亏比例")
    private String proscale;

    /**
     * 是否置顶推荐
     */
    @Excel(name = "是否置顶推荐")
    private String topOrNot;

    /**
     * 是否推荐至首页
     */
    @Excel(name = "是否推荐至首页")
    private String isIndex;

    /**
     * 最低下单
     */
    @Excel(name = "最低下单")
    private Double minOrder;

    /**
     * 最高下单
     */
    @Excel(name = "最高下单")
    private Double maxOrder;

    private String zhouyi;

    private String zhouer;

    private String zhousan;

    private String zhousi;

    private String zhouwu;

    private String zhouliu;

    private String zhouri;
    /**
     * 小数点位数
     */
    private String decimalPlaces;

    private String fullName;//产品全称

    private Long seq;//排序值

    private List<FilePo> fileList;

    private String pcIndex;//推荐至PC引导页

}
