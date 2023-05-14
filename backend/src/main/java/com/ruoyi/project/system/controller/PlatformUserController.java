package com.ruoyi.project.system.controller;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.system.domain.PlatformUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 平台前端用户Controller
 *
 * @author none
 * @date 2020-04-06
 */
@RestController
@RequestMapping("/system/platuser")
public class PlatformUserController extends BaseController {
    @Autowired
    private IPlatformUserService platformUserService;


    /**
     * 查询平台前端用户列表
     */
    @GetMapping("/list")
    public TableDataInfo list(PlatformUser platformUser) {
        startPage();
        List<PlatformUser> list = platformUserService.selectPlatformUserList(platformUser);
        return getDataTable(list);
    }

    /**
     * 导出平台前端用户列表
     */
    @Log(title = "平台前端用户", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(PlatformUser platformUser) {
        List<PlatformUser> list = platformUserService.selectPlatformUserList(platformUser);
        ExcelUtil<PlatformUser> util = new ExcelUtil<PlatformUser>(PlatformUser.class);
        return util.exportExcel(list, "user");
    }

    /**
     * 获取平台前端用户详细信息
     */
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId) {
        return AjaxResult.success(platformUserService.selectPlatformUserById(userId));
    }

    /**
     * 新增平台前端用户
     */
    @Log(title = "平台前端用户", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PlatformUser platformUser) {
        int num = platformUserService.insertPlatformUser(platformUser);
        return AjaxResult.success();
    }

    /**
     * 修改平台前端用户
     */
    @Log(title = "平台前端用户", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult edit(@RequestBody PlatformUser platformUser) {
        int num = platformUserService.updatePlatformUser(platformUser);
        return AjaxResult.success();
    }

}
