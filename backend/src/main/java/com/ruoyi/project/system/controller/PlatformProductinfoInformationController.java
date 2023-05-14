package com.ruoyi.project.system.controller;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.system.domain.PlatformProductInfoInformation;
import com.ruoyi.project.system.service.IPlatformProductinfoInformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 产品的多语言文本信息Controller
 *
 * @author none
 * @date 2023-02-05
 */
@RestController
@RequestMapping("/system/information")
public class PlatformProductinfoInformationController extends BaseController {
    @Autowired
    private IPlatformProductinfoInformationService platformProductinfoInformationService;

    /**
     * 查询产品的多语言文本信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:information:list')")
    @GetMapping("/list")
    public TableDataInfo list(PlatformProductInfoInformation platformProductinfoInformation) {
        startPage();
        List<PlatformProductInfoInformation> list = platformProductinfoInformationService.selectPlatformProductinfoInformationList(platformProductinfoInformation);
        return getDataTable(list);
    }

    /**
     * 导出产品的多语言文本信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:information:export')")
    @Log(title = "产品的多语言文本信息", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(PlatformProductInfoInformation platformProductinfoInformation) {
        List<PlatformProductInfoInformation> list = platformProductinfoInformationService.selectPlatformProductinfoInformationList(platformProductinfoInformation);
        ExcelUtil<PlatformProductInfoInformation> util = new ExcelUtil<PlatformProductInfoInformation>(PlatformProductInfoInformation.class);
        return util.exportExcel(list, "information");
    }

    /**
     * 获取产品的多语言文本信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:information:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(platformProductinfoInformationService.selectPlatformProductinfoInformationById(id));
    }

    /**
     * 新增产品的多语言文本信息
     */
    @PreAuthorize("@ss.hasPermi('system:information:add')")
    @Log(title = "产品的多语言文本信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PlatformProductInfoInformation platformProductinfoInformation) {
        return toAjax(platformProductinfoInformationService.insertPlatformProductinfoInformation(platformProductinfoInformation));
    }

    /**
     * 修改产品的多语言文本信息
     */
    @PreAuthorize("@ss.hasPermi('system:information:edit')")
    @Log(title = "产品的多语言文本信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PlatformProductInfoInformation platformProductinfoInformation) {
        return toAjax(platformProductinfoInformationService.updatePlatformProductinfoInformation(platformProductinfoInformation));
    }

    /**
     * 删除产品的多语言文本信息
     */
    @PreAuthorize("@ss.hasPermi('system:information:remove')")
    @Log(title = "产品的多语言文本信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(platformProductinfoInformationService.deletePlatformProductinfoInformationByIds(ids));
    }
}
