package com.ruoyi.project.system.util;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

@Component
public class LanguageUtils {
    private final Map<String, JSONObject> mapData = new HashMap<>();

    /**
     * 初始化json数据
     *
     * @return
     */
    public JSONObject getlanData() {
        if (mapData.containsKey("jsondata")) {
            return mapData.get("jsondata");
        } else {
            String path = "/languages.json";
            InputStream config = getClass().getResourceAsStream(path);
            if (config == null) {
                throw new RuntimeException("读取文件失败");
            } else {
                try {
                    JSONObject json = JSON.parseObject(config, JSONObject.class);
                    mapData.put("jsondata", json);
                    return json;
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        config.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

            }
        }
        return null;
    }

    public String getMsg(String languageType, String key) {
        JSONObject jsonobj = getlanData();
        String msg = "";
        if (jsonobj != null) {
            JSONObject jsonLan = jsonobj.getJSONObject(languageType);
            msg = jsonLan.getString(key);
        }
        return msg;
    }
}
