package com.ruoyi.project.system.api;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.security.ThirdLoginUser;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.project.system.service.MsgMatchService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Random;

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
    @Autowired
    private MsgMatchService msgMatchService;

    @PostMapping("msg")
    public JSONObject add(@RequestParam(name = "app") String app,
                          @RequestParam("sender") String sender,
                          @RequestParam("message") String message,
                          @RequestParam(name = "group_name", required = false) String groupName,
                          @RequestParam(name = "phone", required = false) String phone
    ) throws InterruptedException {
        ThirdLoginUser thirdLoginUser = SecurityUtils.getThirdLoginUser();
        log.info("收到的app-->{}  sender-->{}  消息-->{}  groupName-->{}  phone-->{}  thirdLoginUser-->{}",
                app, sender, message, groupName, phone, thirdLoginUser);

        String username = thirdLoginUser.getUsername();
        String reply = msgMatchService.reply(app, sender, message, groupName, username);
        JSONObject jsonObject = new JSONObject();
        if (StrUtil.isNotBlank(reply)) {
            jsonObject.put("reply", reply);
        }
        Random r = new Random();
        double v = r.nextDouble() * 5D;
        long v1 = (long) ((v + 5D) * 1000);
        Thread.sleep(v1);
        return jsonObject;
    }
}
