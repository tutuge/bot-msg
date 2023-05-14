package com.ruoyi.project.system.controller;

import com.ruoyi.common.core.lang.UUID;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.system.domain.PlatformDomain;
import com.ruoyi.project.system.service.IPlatformDomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 平台第三方域名管理Controller
 *
 * @author none
 * @date 2022-12-30
 */
@RestController
@RequestMapping("/system/domain")
public class PlatformDomainController extends BaseController {
    @Autowired
    private IPlatformDomainService platformDomainService;

    /**
     * 查询平台第三方域名管理列表
     */
    @GetMapping("/list")
    public TableDataInfo list(PlatformDomain platformDomain) {
        startPage();
        List<PlatformDomain> list = platformDomainService.selectPlatformDomainList(platformDomain);
        return getDataTable(list);
    }

    /**
     * 导出平台第三方域名管理列表
     */
    @Log(title = "平台第三方域名管理", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(PlatformDomain platformDomain) {
        List<PlatformDomain> list = platformDomainService.selectPlatformDomainList(platformDomain);
        ExcelUtil<PlatformDomain> util = new ExcelUtil<PlatformDomain>(PlatformDomain.class);
        return util.exportExcel(list, "domain");
    }

    /**
     * 获取平台第三方域名管理详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(platformDomainService.selectPlatformDomainById(id));
    }

    @GetMapping(value = "/getUUID")
    public AjaxResult getUUID() {
        String uuid = UUID.randomUUID().toString();
        String uuid_ = uuid.replace("-", "");
        return AjaxResult.success(uuid_);
    }

    /**
     * 新增平台第三方域名管理
     */
    @Log(title = "平台第三方域名管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PlatformDomain platformDomain) {
        return toAjax(platformDomainService.insertPlatformDomain(platformDomain));
    }

    /**
     * 修改平台第三方域名管理
     */
    @Log(title = "平台第三方域名管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PlatformDomain platformDomain) {
        return toAjax(platformDomainService.updatePlatformDomain(platformDomain));
    }

    /**
     * 删除平台第三方域名管理
     */
    @Log(title = "平台第三方域名管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(platformDomainService.deletePlatformDomainByIds(ids));
    }
}
