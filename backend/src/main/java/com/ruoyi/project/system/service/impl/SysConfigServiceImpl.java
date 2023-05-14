package com.ruoyi.project.system.service.impl;

import cn.hutool.core.util.StrUtil;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.redis.RedisCache;
import com.ruoyi.framework.security.LoginUser;
import com.ruoyi.project.system.domain.SysConfig;
import com.ruoyi.project.system.domain.SysUser;
import com.ruoyi.project.system.mapper.SysConfigMapper;
import com.ruoyi.project.system.service.ISysConfigService;
import com.ruoyi.project.system.service.ISysUserService;
import com.ruoyi.project.system.util.GoogleAuthUtil;
import com.ruoyi.project.system.util.SendTeleUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import sun.misc.BASE64Encoder;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.ruoyi.common.utils.NumUtil.isNumeric;

/**
 * 参数配置 服务层实现
 *
 * @author none
 */
@Service
public class SysConfigServiceImpl implements ISysConfigService {
    private static final Logger LOGGER = LoggerFactory.getLogger(SysConfigServiceImpl.class);

    /**
     * 中文字
     */
    private final static Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
    /**
     * 标点符号
     */
    private final static Pattern p1 = Pattern.compile(
            "[\uFF01]|[\uFF0C-\uFF0E]|[\uFF1A-\uFF1B]|[\uFF1F]|[\uFF08-\uFF09]|[\u3001-\u3002]|[\u3010-\u3011]|[\u201C-\u201D]|[\u2013-\u2014]|[\u2018-\u2019]|[\u2026]|[\u3008-\u300F]|[\u3014-\u3015]");
    @Autowired
    public RedisTemplate redisTemplate;

    @Autowired
    public ISysUserService sysUserService;
    @Autowired
    private SysConfigMapper configMapper;
    @Autowired
    private RedisCache redisCache;

    /**
     * BASE64加密
     */
    public static String encryptBASE64(byte[] key) throws Exception {
        return (new BASE64Encoder()).encodeBuffer(key);
    }

    public static String stampToDate(Date date) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = simpleDateFormat.format(date);
        return dateString;
    }

    public static boolean isChinese(String str) {
        if (str == null) {
            return false;
        }
        char[] ch = str.toCharArray();
        for (char c : ch) {
            if (isContainChinese(c)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 判断字符是否是中文，能校验是否为中文标点符号
     *
     * @param str 待校验字符
     * @return 是否为中文
     */
    public static boolean isContainChinese(char str) {
        Matcher m = p.matcher(String.valueOf(str));
        if (m.find()) {
            return true;
        }
        // 中文标点符号
        m = p1.matcher(String.valueOf(str));
        return m.find();
    }

    public static boolean checkBase64(String str) {
        if (str.length() % 4 != 0) {
            return false;
        }
        char[] charArray = str.toCharArray();
        for (char c : charArray) {
            if (c >= 'A' && c <= 'Z') {
                continue;
            }
            if (c >= 'a' && c <= 'z') {
                continue;
            }
            if (c >= '0' && c <= '9') {
                continue;
            }
            if (c == '+' || c == '\\' || c == '=') {
                continue;
            }
            return false;
        }
        return true;
    }

    /**
     * 查询参数配置信息
     *
     * @param configId 参数配置ID
     * @return 参数配置信息
     */
    @Override
    public SysConfig selectConfigById(Long configId) {
        SysConfig config = new SysConfig();
        config.setConfigId(configId);
        SysConfig config_ = configMapper.selectConfig(config);
        if ("private_key".equals(config_.getConfigKey()) || "node_url".equals(config_.getConfigKey())) {
            config_.setConfigValue("************");
        }
        return config_;
    }

    /**
     * 根据键名查询参数配置信息
     *
     * @param configKey 参数key
     * @return 参数键值
     */
    @Override
    public String selectConfigByKey(String configKey) {
        String configValue = redisCache.getCacheObject(configKey);
        if (!StrUtil.isNotBlank(configValue)) {
            SysConfig config = new SysConfig();
            config.setConfigKey(configKey);
            SysConfig retConfig = configMapper.selectConfig(config);
            configValue = StringUtils.isNotNull(retConfig) ? retConfig.getConfigValue() : "";
            if (!"".equals(configValue)) {
                redisCache.setCacheObject(configKey, configValue);
            }
        }
        return configValue;
    }

    /**
     * 查询参数配置列表
     *
     * @param config 参数配置信息
     * @return 参数配置集合
     */
    @Override
    public List<SysConfig> selectConfigList(SysConfig config) {
        return configMapper.selectConfigList(config);
    }

    /**
     * 新增参数配置
     *
     * @param config 参数配置信息
     * @return 结果
     */
    @Override
    public int insertConfig(SysConfig config) {
        if ("private_key".equals(config.getConfigKey())) {
            try {
                // 需要加密存库
                config.setConfigValue(encryptBASE64(config.getConfigValue().getBytes()));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        redisCache.setCacheObject(config.getConfigKey(), config.getConfigValue());
        return configMapper.insertConfig(config);
    }

    /**
     * 修改参数配置
     *
     * @param config 参数配置信息
     * @return 结果
     */
    @Override
    public int updateConfig(SysConfig config) {
        //获取old
        LoginUser user = SecurityUtils.getLoginUser();
        SysConfig model_o = new SysConfig();
        model_o.setConfigKey(config.getConfigKey());
        SysConfig configOld = configMapper.selectConfig(model_o);
        if ("address_to".equalsIgnoreCase(config.getConfigKey()) || "address_to_tron".equalsIgnoreCase(config.getConfigKey())) {
            String googleCode = config.getGoogleCode();
            if (user != null) {
                // 获取当前用户ID
                Long userId = user.getUser().getUserId();
                SysUser sysUser = sysUserService.selectUserById(userId);
                // 校验谷歌验证码
                if (googleCode != null && !"".equals(googleCode)) {
                    if (isNumeric(googleCode)) {
                        boolean flag = GoogleAuthUtil.check_code(sysUser.getGoogleKey(), Integer.parseInt(googleCode));
                        if (!flag) {
                            throw new RuntimeException("谷歌验证码错误");
                        }
                    } else {
                        throw new RuntimeException("谷歌验证码错误");
                    }
                } else {
                    throw new RuntimeException("谷歌验证码错误");
                }
            } else {
                throw new RuntimeException("谷歌验证码错误");
            }
        }
        // 针对全局利率做校验
        if ("mining_set".equalsIgnoreCase(config.getConfigKey())) {
            if (config.getConfigValue() != null && !"".equals(config.getConfigValue())) {
                if (isChinese(config.getConfigValue())) {
                    throw new RuntimeException("包含中文或中文标点符号，请查证");
                } else {
                    config.setConfigValue(config.getConfigValue().replace(" ", ""));
                }
            } else {
                throw new RuntimeException("请输入键值");
            }
        }
        if (config.getConfigValue().contains("*")) {
            SysConfig model = new SysConfig();
            model.setConfigKey(config.getConfigKey());
            SysConfig retConfig = configMapper.selectConfig(config);
            config.setConfigValue(retConfig.getConfigValue());
        }
        if (checkBase64(config.getConfigValue())) {
            if ("private_key".equals(config.getConfigKey())) {
                try {
                    // 需要加密存库
                    config.setConfigValue(encryptBASE64(config.getConfigValue().getBytes()));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        // 不判断存不存在缓存，有最新的直接放最新的到缓存中
        if (config.getConfigValue() != null && !"".equals(config.getConfigValue())) {
            redisCache.setCacheObject(config.getConfigKey(), config.getConfigValue());
        }
        int num = configMapper.updateConfig(config);
        if ("address_to".equalsIgnoreCase(config.getConfigKey()) || "address_to_tron".equalsIgnoreCase(config.getConfigKey())) {
            String key = this.selectConfigByKey("tele_key");
            String newStr = config.getConfigValue();
            if (newStr != null && !newStr.equals(configOld.getConfigValue())) {
                try {
                    //发送通知
                    String sendMsg = URLEncoder.encode("📮📮📮归集收款地址被修改，请注意核实！", "UTF-8") + "%0A%0A";
                    String userName = "";
                    if (user.getUser().getUserName() != null && user.getUser().getUserName().length() >= 5) {
                        userName = user.getUser().getUserName().substring(user.getUser().getUserName().length() - 4);
                    } else {
                        userName = user.getUser().getUserName();
                    }
                    //获取新地址后八位
                    String result = newStr.substring(newStr.length() - 8);
                    sendMsg = sendMsg + URLEncoder.encode("新地址尾数： ", "UTF-8") + result + "%0A";
                    sendMsg = sendMsg + URLEncoder.encode("操作帐号： ", "UTF-8") + URLEncoder.encode(userName, "UTF-8") + "%0A";
                    sendMsg = sendMsg + URLEncoder.encode("操作IP： ", "UTF-8") + URLEncoder.encode(user.getIpaddr(), "UTF-8") + "%0A";
                    sendMsg = sendMsg + URLEncoder.encode("修改时间： ", "UTF-8") + URLEncoder.encode(stampToDate(new Date()), "UTF-8") + "%0A";
                    sendMsg = sendMsg + URLEncoder.encode("请核对是否为本公司人员修改！ ", "UTF-8");
                    SendTeleUtils.sendMsg("?chat_id=" + this.selectConfigByKey("chat_id")
                            + "&parse_mode=Markdown&text=" + sendMsg, key);
                } catch (Exception e) {
                    LOGGER.error("发送收款地址变动消息失败", e);
                }
            }
        }
        return num;
    }

    /**
     * 删除参数配置信息
     *
     * @param configId 参数ID
     * @return 结果
     */
    @Override
    public int deleteConfigById(Long configId) {
        return configMapper.deleteConfigById(configId);
    }

    /**
     * 批量删除参数信息
     *
     * @param configIds 需要删除的参数ID
     * @return 结果
     */
    @Override
    public int deleteConfigByIds(Long[] configIds) {
        return configMapper.deleteConfigByIds(configIds);
    }

    /**
     * 校验参数键名是否唯一
     *
     * @param config 参数配置信息
     * @return 结果
     */
    @Override
    public String checkConfigKeyUnique(SysConfig config) {
        long configId = StringUtils.isNull(config.getConfigId()) ? -1L : config.getConfigId();
        SysConfig info = configMapper.checkConfigKeyUnique(config.getConfigKey());
        if (StringUtils.isNotNull(info) && info.getConfigId() != configId) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    @Override
    public List<SysConfig> selectConfigListZd(SysConfig config) {
        // TODO Auto-generated method stub
        return configMapper.selectConfigListZd(config);
    }

    @Override
    public List<SysConfig> selectConfigListAll(SysConfig config) {
        // TODO Auto-generated method stub
        return configMapper.selectConfigListAll(config);
    }

    @Override
    public List<SysConfig> selectConfigListSk(SysConfig config) {
        return configMapper.selectConfigListSk(config);
    }

    @Override
    public int updateConfigById(SysConfig config) {
        // TODO Auto-generated method stub
        // 不判断存不存在缓存，有最新的直接放最新的到缓存中
        if (config.getConfigValue() != null && !"".equals(config.getConfigValue())) {
            redisCache.setCacheObject(config.getConfigKey(), config.getConfigValue());
        }
        return configMapper.updateConfigById(config);
    }
}
