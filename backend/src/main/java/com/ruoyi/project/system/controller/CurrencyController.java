package com.ruoyi.project.system.controller;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.page.PageQuery;
import com.ruoyi.common.page.TableDataInfo;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.project.system.domain.bo.CurrencyBo;
import com.ruoyi.project.system.domain.vo.CurrencyVo;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Arrays;
import java.util.List;

/**
 * 平台币种Controller
 * 前端访问路由地址为:/basic/currency
 *
 * @author none
 * @date 2022-05-10
 */
@Validated
//@Api(value = "平台币种控制器", tags = {"平台币种管理"})
@RestController
@RequestMapping("/basic/currency")
public class CurrencyController extends BaseController {

    @Autowired
    private ICurrencyService iCurrencyService;

    /**
     * 查询平台币种列表
     */
    @ApiOperation("查询平台币种列表")
    @GetMapping("/list")
    public TableDataInfo<CurrencyVo> list(CurrencyBo bo, PageQuery pageQuery) {
        return iCurrencyService.queryPageList(bo, pageQuery);
    }


    @ApiOperation("查询平台所有币种")
    @GetMapping("/listAll")
    public R<List<CurrencyVo>> list() {
        return R.ok(iCurrencyService.queryListAll());
    }

    /**
     * 导出平台币种列表
     */
    /*@ApiOperation("导出平台币种列表")
    @Log(title = "平台币种", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(@Validated CurrencyBo bo, HttpServletResponse response) {
        List<CurrencyVo> list = iCurrencyService.queryList(bo);
        ExcelUtil.exportExcel(list, "平台币种", CurrencyVo.class, response);
    }*/

    /**
     * 获取平台币种详细信息
     */
    @ApiOperation("获取平台币种详细信息")
    @GetMapping("/{id}")
    public R<CurrencyVo> getInfo(@ApiParam("主键")
                                 @NotNull(message = "主键不能为空")
                                 @PathVariable("id") Long id) {
        return R.ok(iCurrencyService.queryById(id));
    }

    /**
     * 新增平台币种
     */
    @ApiOperation("新增平台币种")
    @Log(title = "平台币种", businessType = BusinessType.INSERT)
    @PostMapping()
    public R<Void> add(@RequestBody CurrencyBo bo) {
        return toAjaxPlus(iCurrencyService.insertByBo(bo) ? 1 : 0);
    }

    /**
     * 修改平台币种
     */
    @ApiOperation("修改平台币种")
    @Log(title = "平台币种", businessType = BusinessType.UPDATE)
    @PutMapping()
    public R<Void> edit(@RequestBody CurrencyBo bo) {
        return toAjaxPlus(iCurrencyService.updateByBo(bo) ? 1 : 0);
    }

    /**
     * 删除平台币种
     */
    @ApiOperation("删除平台币种")
    @Log(title = "平台币种", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@ApiParam("主键串")
                          @NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjaxPlus(iCurrencyService.deleteWithValidByIds(Arrays.asList(ids), true) ? 1 : 0);
    }
}
