package com.ruoyi.common.exception.user;

/**
 * 验证码错误异常类
 *
 * @author none
 */
public class GoogleNullCaptchaException extends UserException {
    private static final long serialVersionUID = 1L;

    public GoogleNullCaptchaException() {
        super("user.googleNulljcaptcha.error", null);
    }
}
