package com.ruoyi.project.system.controller;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.system.domain.PlatformProductInfo;
import com.ruoyi.project.system.domain.po.FilePo;
import com.ruoyi.project.system.service.ISysConfigService;
import com.ruoyi.project.system.service.PlatformProductInfoService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 产品信息Controller
 *
 * @author none
 * @date 2020-06-08
 */
@RestController
@RequestMapping("/system/productinfo")
public class PlatformProductInfoController extends BaseController {
    @Autowired
    private PlatformProductInfoService platformProductinfoService;

    @Autowired
    private ISysConfigService sysConfigService;

    /**
     * 查询产品信息列表
     */
    @GetMapping("/list")
    public TableDataInfo list(PlatformProductInfo platformProductinfo) {
        startPage();
        platformProductinfo.setType("1");
        List<PlatformProductInfo> list = platformProductinfoService.selectPlatformProductinfoList(platformProductinfo);
        return getDataTable(list);
    }

    /**
     * 查询产品信息列表
     */
    @GetMapping("/listhy")
    public TableDataInfo listhy(PlatformProductInfo platformProductinfo) {
        startPage();
        List<PlatformProductInfo> list = platformProductinfoService.selectPlatformProductinfoList(platformProductinfo);
        for (PlatformProductInfo platformProductInfo : list) {
            platformProductInfo.setPointLow(platformProductInfo.getPointLow() + "~" + platformProductInfo.getPointTop());
        }
        return getDataTable(list);
    }

    /**
     * 导出产品信息列表
     */
    @Log(title = "产品信息", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(PlatformProductInfo platformProductinfo) {
        List<PlatformProductInfo> list = platformProductinfoService.selectPlatformProductinfoList(platformProductinfo);
        ExcelUtil<PlatformProductInfo> util = new ExcelUtil<PlatformProductInfo>(PlatformProductInfo.class);
        return util.exportExcel(list, "productinfo");
    }

    /**
     * 获取产品信息详细信息
     */
    @GetMapping(value = "/{pid}")
    public AjaxResult getInfo(@PathVariable("pid") Long pid) {
        PlatformProductInfo platformProductinfo = platformProductinfoService.selectPlatformProductinfoById(pid);
        String base_img_url = sysConfigService.selectConfigByKey("base_img_url");
        if (StringUtils.isNotBlank(platformProductinfo.getPicUrl())) {
            FilePo filePo = new FilePo();
            filePo.setUrl(base_img_url + platformProductinfo.getPicUrl());
            List<FilePo> filePoList = new ArrayList<>();
            filePoList.add(filePo);
            platformProductinfo.setFileList(filePoList);
        }
        return AjaxResult.success(platformProductinfo);
    }

    /**
     * 新增产品信息
     */
    @Log(title = "产品信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PlatformProductInfo platformProductinfo) {

        return toAjax(platformProductinfoService.insertPlatformProductInfo(platformProductinfo).intValue());
    }

    /**
     * 修改产品信息
     */
    @Log(title = "产品信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PlatformProductInfo platformProductinfo) {
        return toAjax(platformProductinfoService.updatePlatformProductinfo(platformProductinfo));
    }

    @Log(title = "产品信息", businessType = BusinessType.UPDATE)
    @PutMapping("/changeOpen")
    public AjaxResult changeStatus(@RequestBody PlatformProductInfo platformProductinfo) {
        return toAjax(platformProductinfoService.updatePlatformProductinfo(platformProductinfo));
    }

    /**
     * 删除产品信息
     */
    @Log(title = "产品信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{pids}")
    public AjaxResult remove(@PathVariable Long[] pids) {
        return toAjax(platformProductinfoService.deletePlatformProductInfoByIds(pids));
    }
}
