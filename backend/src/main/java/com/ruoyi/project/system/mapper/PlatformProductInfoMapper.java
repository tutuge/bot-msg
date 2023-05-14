package com.ruoyi.project.system.mapper;

import com.ruoyi.framework.task.vo.ProdVo;
import com.ruoyi.project.system.domain.PlatformProductInfo;
import com.ruoyi.project.system.domain.vo.PlatformProductinfoVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 产品信息Mapper接口
 *
 * @author none
 * @date 2020-06-08
 */
public interface PlatformProductInfoMapper {
    /**
     * 查询产品信息
     *
     * @param pid 产品信息ID
     * @return 产品信息
     */
    PlatformProductInfo selectPlatformProductInfoById(Long pid);

    /**
     * 查询产品信息列表
     *
     * @param platformProductinfo 产品信息
     * @return 产品信息集合
     */
    List<PlatformProductInfo> selectPlatformProductinfoList(PlatformProductInfo platformProductinfo);

    /**
     * 新增产品信息
     *
     * @param platformProductinfo 产品信息
     * @return 结果
     */
    Long insertPlatformProductinfo(PlatformProductInfo platformProductinfo);

    /**
     * 修改产品信息
     *
     * @param platformProductinfo 产品信息
     * @return 结果
     */
    int updatePlatformProductinfo(PlatformProductInfo platformProductinfo);

    /**
     * 删除产品信息
     *
     * @param pid 产品信息ID
     * @return 结果
     */
    int deletePlatformProductinfoById(Long pid);

    /**
     * 批量删除产品信息
     *
     * @param pids 需要删除的数据ID
     * @return 结果
     */
    int deletePlatformProductinfoByIds(Long[] pids);

    List<PlatformProductinfoVo> selectIndexProd(Map<String, Object> paramsMap);

    /**
     * 获取所有的置顶产品
     * @return
     */
    List<ProdVo> queryAllTopProd();

    /**
     * 获取所有的产品
     * @return
     */
    List<ProdVo> queryAllProd();

    List<ProdVo> queryAllPc();

    List<ProdVo> queryAllProdByProdCode(@Param("procode")String procode);
}
