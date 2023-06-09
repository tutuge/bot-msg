package com.ruoyi.project.system.api;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.security.ThirdLoginUser;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.project.system.service.ISysConfigService;
import com.ruoyi.project.system.service.MsgMatchService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
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
    @Resource
    private ISysConfigService configService;

    @PostMapping("msg")
    public JSONObject add(@RequestParam(name = "app", required = false) String app,
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
        } else {
            //有消息返回的情况下再在下面阻塞线程，否则直接结束，省的占用线程
            return jsonObject;
        }
        String delay = configService.selectConfigByKey("delay_reply");
        if (StrUtil.isBlank(delay)) {
            delay = "5~10";
        }
        String[] split = delay.split("~");
        Integer one = null;
        Integer two = null;
        if (split.length != 2) {
            one = 5;
            two = 10;
        } else {
            try {
                String s = split[0];
                one = Integer.valueOf(s);
                String s1 = split[1];
                two = Integer.valueOf(s1);
            } catch (Exception e) {
                log.error("消息回复延迟设置不正确--->{}", delay);
                one = 5;
                two = 10;
            }
        }
        Random r = new Random();
        double v = r.nextDouble() * one;
        long v1 = (long) ((v + (two - one)) * 1000);
        Thread.sleep(v1);
        return jsonObject;
    }


    @PostMapping("telegram")
    public JSONObject tele(@RequestBody JSONObject jsonObject) {
        log.info("当前电报请求-->{}", jsonObject);
        return null;
    }
}
