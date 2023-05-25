package com.ruoyi.project.system.controller;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.system.domain.PlatformMsgGroup;
import com.ruoyi.project.system.service.IPlatformMsgGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 消息组群Controller
 *
 * @author ruoyi
 * @date 2023-05-25
 */
@RestController
@RequestMapping("/system/msggroup")
public class PlatformMsgGroupController extends BaseController {
    @Autowired
    private IPlatformMsgGroupService platformMsgGroupService;

    /**
     * 查询消息组群列表
     */
    @PreAuthorize("@ss.hasPermi('system:msggroup:list')")
    @GetMapping("/list")
    public TableDataInfo list(PlatformMsgGroup platformMsgGroup) {
        startPage();
        List<PlatformMsgGroup> list = platformMsgGroupService.selectPlatformMsgGroupList(platformMsgGroup);
        return getDataTable(list);
    }

    /**
     * 导出消息组群列表
     */
    @PreAuthorize("@ss.hasPermi('system:msggroup:export')")
    @Log(title = "消息组群", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(PlatformMsgGroup platformMsgGroup) {
        List<PlatformMsgGroup> list = platformMsgGroupService.selectPlatformMsgGroupList(platformMsgGroup);
        ExcelUtil<PlatformMsgGroup> util = new ExcelUtil<PlatformMsgGroup>(PlatformMsgGroup.class);
        return util.exportExcel(list, "msggroup");
    }

    /**
     * 获取消息组群详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:msggroup:query')")
    @GetMapping(value = "/{msgGroupId}")
    public AjaxResult getInfo(@PathVariable("msgGroupId") Long msgGroupId) {
        return AjaxResult.success(platformMsgGroupService.selectPlatformMsgGroupById(msgGroupId));
    }

    /**
     * 新增消息组群
     */
    @PreAuthorize("@ss.hasPermi('system:msggroup:add')")
    @Log(title = "消息组群", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PlatformMsgGroup platformMsgGroup) {
        return toAjax(platformMsgGroupService.insertPlatformMsgGroup(platformMsgGroup));
    }

    /**
     * 修改消息组群
     */
    @PreAuthorize("@ss.hasPermi('system:msggroup:edit')")
    @Log(title = "消息组群", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PlatformMsgGroup platformMsgGroup) {
        return toAjax(platformMsgGroupService.updatePlatformMsgGroup(platformMsgGroup));
    }

    /**
     * 删除消息组群
     */
    @PreAuthorize("@ss.hasPermi('system:msggroup:remove')")
    @Log(title = "消息组群", businessType = BusinessType.DELETE)
    @DeleteMapping("/{msgGroupIds}")
    public AjaxResult remove(@PathVariable Long[] msgGroupIds) {
        return toAjax(platformMsgGroupService.deletePlatformMsgGroupByIds(msgGroupIds));
    }
}
