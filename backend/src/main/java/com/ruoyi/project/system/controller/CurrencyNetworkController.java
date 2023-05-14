package com.ruoyi.project.system.controller;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.page.PageQuery;
import com.ruoyi.common.page.TableDataInfo;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.project.system.domain.bo.CurrencyNetworkBo;
import com.ruoyi.project.system.domain.vo.CurrencyNetworkVo;
import com.ruoyi.project.system.service.ICurrencyNetworkService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Arrays;

/**
 * 币种充值网络Controller
 * 前端访问路由地址为:/basic/network
 *
 * @author none
 * @date 2022-05-10
 */
@Validated
//@Api(value = "币种充值网络控制器", tags = {"币种充值网络管理"})
@RestController
@RequestMapping("/basic/network")
public class CurrencyNetworkController extends BaseController {

    @Autowired
    private ICurrencyNetworkService iCurrencyNetworkService;

    /**
     * 查询币种充值网络列表
     */
    @ApiOperation("查询币种充值网络列表")
    @GetMapping("/list")
    public TableDataInfo<CurrencyNetworkVo> list(CurrencyNetworkBo bo, PageQuery pageQuery) {
        return iCurrencyNetworkService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出币种充值网络列表
     */
    /*@ApiOperation("导出币种充值网络列表")
    @Log(title = "币种充值网络", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(@Validated CurrencyNetworkBo bo, HttpServletResponse response) {
        List<CurrencyNetworkVo> list = iCurrencyNetworkService.queryList(bo);
        ExcelUtil.exportExcel(list, "币种充值网络", CurrencyNetworkVo.class, response);
    }*/

    /**
     * 获取币种充值网络详细信息
     */
    @ApiOperation("获取币种充值网络详细信息")
    @GetMapping("/{id}")
    public R<CurrencyNetworkVo> getInfo(@ApiParam("主键")
                                        @NotNull(message = "主键不能为空")
                                        @PathVariable("id") Long id) {
        return R.ok(iCurrencyNetworkService.queryById(id));
    }

    /**
     * 新增币种充值网络
     */
    @ApiOperation("新增币种充值网络")
    @Log(title = "币种充值网络", businessType = BusinessType.INSERT)
    @PostMapping()
    public R<Void> add(@RequestBody CurrencyNetworkBo bo) {
        return toAjaxPlus(iCurrencyNetworkService.insertByBo(bo) ? 1 : 0);
    }

    /**
     * 修改币种充值网络
     */
    @ApiOperation("修改币种充值网络")
    @Log(title = "币种充值网络", businessType = BusinessType.UPDATE)
    @PutMapping()
    public R<Void> edit(@RequestBody CurrencyNetworkBo bo) {
        return toAjaxPlus(iCurrencyNetworkService.updateByBo(bo) ? 1 : 0);
    }

    /**
     * 删除币种充值网络
     */
    @ApiOperation("删除币种充值网络")
    @Log(title = "币种充值网络", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@ApiParam("主键串")
                          @NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjaxPlus(iCurrencyNetworkService.deleteWithValidByIds(Arrays.asList(ids), true) ? 1 : 0);
    }
}
