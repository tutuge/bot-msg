package com.ruoyi.project.system.domain.vo;

public class UserPwd {
    private Long userId;

    private String passwordNew;

    private String payPasswordNew;


    public String getPayPasswordNew() {
        return payPasswordNew;
    }

    public void setPayPasswordNew(String payPasswordNew) {
        this.payPasswordNew = payPasswordNew;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getPasswordNew() {
        return passwordNew;
    }

    public void setPasswordNew(String passwordNew) {
        this.passwordNew = passwordNew;
    }


}
