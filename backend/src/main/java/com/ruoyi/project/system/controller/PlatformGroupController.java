package com.ruoyi.project.system.controller;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.system.domain.PlatformGroup;
import com.ruoyi.project.system.service.IPlatformGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 平台前端用户Controller
 *
 * @author ruoyi
 * @date 2023-05-25
 */
@RestController
@RequestMapping("/system/group")
public class PlatformGroupController extends BaseController {
    @Autowired
    private IPlatformGroupService platformGroupService;

    /**
     * 查询平台前端用户列表
     */
    @PreAuthorize("@ss.hasPermi('system:group:list')")
    @GetMapping("/list")
    public TableDataInfo list(PlatformGroup platformGroup) {
        startPage();
        List<PlatformGroup> list = platformGroupService.selectPlatformGroupList(platformGroup);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('system:group:list')")
    @GetMapping("/all/info")
    public AjaxResult all() {
        List<PlatformGroup> list = platformGroupService.selectPlatformGroupList(new PlatformGroup());
        return AjaxResult.success(list);
    }

    /**
     * 导出平台前端用户列表
     */
    @PreAuthorize("@ss.hasPermi('system:group:export')")
    @Log(title = "平台前端用户", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(PlatformGroup platformGroup) {
        List<PlatformGroup> list = platformGroupService.selectPlatformGroupList(platformGroup);
        ExcelUtil<PlatformGroup> util = new ExcelUtil<PlatformGroup>(PlatformGroup.class);
        return util.exportExcel(list, "group");
    }

    /**
     * 获取平台前端用户详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:group:query')")
    @GetMapping(value = "/{groupId}")
    public AjaxResult getInfo(@PathVariable("groupId") Long groupId) {
        return AjaxResult.success(platformGroupService.selectPlatformGroupById(groupId));
    }

    /**
     * 新增平台前端用户
     */
    @PreAuthorize("@ss.hasPermi('system:group:add')")
    @Log(title = "平台前端用户", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PlatformGroup platformGroup) {
        return toAjax(platformGroupService.insertPlatformGroup(platformGroup));
    }

    /**
     * 修改平台前端用户
     */
    @PreAuthorize("@ss.hasPermi('system:group:edit')")
    @Log(title = "平台前端用户", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PlatformGroup platformGroup) {
        return toAjax(platformGroupService.updatePlatformGroup(platformGroup));
    }

    /**
     * 删除平台前端用户
     */
    @PreAuthorize("@ss.hasPermi('system:group:remove')")
    @Log(title = "平台前端用户", businessType = BusinessType.DELETE)
    @DeleteMapping("/{groupIds}")
    public AjaxResult remove(@PathVariable Long[] groupIds) {
        return toAjax(platformGroupService.deletePlatformGroupByIds(groupIds));
    }
}
