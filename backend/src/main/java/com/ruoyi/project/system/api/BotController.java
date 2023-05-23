package com.ruoyi.project.system.api;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.security.ThirdLoginUser;
import com.ruoyi.framework.web.controller.BaseController;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 平台前端用户Controller
 *
 * @author none
 * @date 2020-04-06
 */
@Slf4j
@RestController
@RequestMapping("/bot/")
public class BotController extends BaseController {

    @PostMapping("msg")
    public JSONObject add(@RequestParam(name = "app") String app,
                          @RequestParam("sender") String sender,
                          @RequestParam("message") String message,
                          @RequestParam(name = "group_name", required = false) String groupName,
                          @RequestParam(name = "phone", required = false) String phone
    ) {
        log.info("收到的app-->{}", app);
        log.info("收到的sender-->{}", sender);
        log.info("收到的消息-->{}", message);
        log.info("收到的groupName-->{}", groupName);
        log.info("收到的phone-->{}", phone);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("reply", message);
        ThirdLoginUser thirdLoginUser = SecurityUtils.getThirdLoginUser();
        log.info("thirdLoginUser-->{}", thirdLoginUser);
        String username = thirdLoginUser.getUsername();

        return jsonObject;
    }
}
