package com.ruoyi.common.exception.user;

/**
 * 验证码错误异常类
 *
 * @author none
 */
public class GoogleCaptchaException extends UserException {
    private static final long serialVersionUID = 1L;

    public GoogleCaptchaException() {
        super("user.googlejcaptcha.error", null);
    }
}
