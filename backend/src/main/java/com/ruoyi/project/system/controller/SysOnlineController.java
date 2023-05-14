package com.ruoyi.project.system.controller;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.system.domain.SysOnline;
import com.ruoyi.project.system.service.ISysOnlineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户在线情况Controller
 *
 * @author none
 * @date 2022-10-06
 */
@RestController
@RequestMapping("/system/online")
public class SysOnlineController extends BaseController {
    @Autowired
    private ISysOnlineService sysOnlineService;

    /**
     * 查询用户在线情况列表
     */
    @GetMapping("/list")
    public TableDataInfo list(SysOnline sysOnline) {
        startPage();
        List<SysOnline> list = sysOnlineService.selectSysOnlineList(sysOnline);
        return getDataTable(list);
    }

    /**
     * 导出用户在线情况列表
     */
    @Log(title = "用户在线情况", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(SysOnline sysOnline) {
        List<SysOnline> list = sysOnlineService.selectSysOnlineList(sysOnline);
        ExcelUtil<SysOnline> util = new ExcelUtil<SysOnline>(SysOnline.class);
        return util.exportExcel(list, "online");
    }

    /**
     * 获取用户在线情况详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(sysOnlineService.selectSysOnlineById(id));
    }

    /**
     * 新增用户在线情况
     */
    @Log(title = "用户在线情况", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysOnline sysOnline) {
        return toAjax(sysOnlineService.insertSysOnline(sysOnline));
    }

    /**
     * 修改用户在线情况
     */
    @Log(title = "用户在线情况", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysOnline sysOnline) {
        return toAjax(sysOnlineService.updateSysOnline(sysOnline));
    }

    /**
     * 删除用户在线情况
     */
    @Log(title = "用户在线情况", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(sysOnlineService.deleteSysOnlineByIds(ids));
    }
}
