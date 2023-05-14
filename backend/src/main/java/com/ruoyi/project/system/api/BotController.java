package com.ruoyi.project.system.api;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.project.system.api.bo.QueryBo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
    public JSONObject add(@RequestBody QueryBo queryBo) {
        log.info("收到的消息-->{}", queryBo);
        String message = queryBo.getMessage();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("reply", message);
        return jsonObject;
    }
}
