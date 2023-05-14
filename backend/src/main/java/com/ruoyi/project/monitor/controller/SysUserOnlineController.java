package com.ruoyi.project.monitor.controller;

import com.ruoyi.common.constant.Constants;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.redis.RedisCache;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.monitor.domain.SysUserOnline;
import com.ruoyi.project.system.service.ISysUserOnlineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * 在线用户监控
 *
 * @author none
 */
@RestController
@RequestMapping("/monitor/online")
public class SysUserOnlineController extends BaseController {
    @Autowired
    private ISysUserOnlineService userOnlineService;

    @Autowired
    private RedisCache redisCache;

    @GetMapping("/list")
    public TableDataInfo list(String ipaddr, String userName, Long userId) {
        Collection<String> keys = redisCache.keys(Constants.LOGIN_TOKEN_KEY_PLAT + "*");
        List<SysUserOnline> userOnlineList = new ArrayList<SysUserOnline>();
        Collections.reverse(userOnlineList);
        userOnlineList.removeAll(Collections.singleton(null));
        Collections.sort(userOnlineList, new Comparator<SysUserOnline>() {
            /*
             * int compare(Student o1, Student o2) 返回一个基本类型的整型，
             * 返回负数表示：o1 小于o2，
             * 返回0 表示：o1和o2相等，
             * 返回正数表示：o1大于o2。
             */
            public int compare(SysUserOnline o1, SysUserOnline o2) {
                //按照金额大小进行降序排列
                if (o1.getLoginTime() < o2.getLoginTime()) {
                    return 1;
                }
                if (o1.getLoginTime().equals(o2.getLoginTime())) {
                    return 0;
                }
                return -1;
            }
        });
        return getDataTable(userOnlineList);
    }

    /**
     * 强退用户
     */
    @Log(title = "在线用户", businessType = BusinessType.DELETE)
    @DeleteMapping("/{tokenId}")
    public AjaxResult forceLogout(@PathVariable String tokenId) {
        redisCache.deleteObject(Constants.LOGIN_TOKEN_KEY_PLAT + tokenId);
        return AjaxResult.success();
    }
}
