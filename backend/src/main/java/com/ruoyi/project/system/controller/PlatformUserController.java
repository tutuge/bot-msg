package com.ruoyi.project.system.controller;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.system.controller.vo.PlatformUserVo;
import com.ruoyi.project.system.domain.PlatformUser;
import com.ruoyi.project.system.service.IPlatformUserService;
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
        List<PlatformUserVo> list = platformUserService.selectPlatformUserList(platformUser);
        return getDataTable(list);
    }

    /**
     * 查询平台前端用户列表
     */
    @GetMapping("/listSimple")
    public AjaxResult listSimple() {
        List<PlatformUserVo> list = platformUserService.selectPlatformUserVoList();
        return AjaxResult.success(list);
    }


    /**
     * 获取平台前端用户详细信息
     */
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId) {
        return AjaxResult.success(platformUserService.selectPlatformUserById(userId));
    }

    /**
     * 获取平台前端用户详细信息
     */
    @DeleteMapping(value = "/{userId}")
    public AjaxResult delete(@PathVariable("userId") Long userId) {
        return AjaxResult.success(platformUserService.deletePlatformUserById(userId));
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
