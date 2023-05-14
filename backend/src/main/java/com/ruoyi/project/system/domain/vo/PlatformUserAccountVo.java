package com.ruoyi.project.system.domain.vo;

public class PlatformUserAccountVo {
    private int userId;

    private String userType;

    private Double userAccount;

    private String email;

    private String accountType;

    private String currencyType;

    private Long acid;

    private Double freezingAssets;//冻结的资产

    private String nickName;



    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Double getFreezingAssets() {
        return freezingAssets;
    }

    public void setFreezingAssets(Double freezingAssets) {
        this.freezingAssets = freezingAssets;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public String getCurrencyType() {
        return currencyType;
    }

    public void setCurrencyType(String currencyType) {
        this.currencyType = currencyType;
    }

    public Long getAcid() {
        return acid;
    }

    public void setAcid(Long acid) {
        this.acid = acid;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public Double getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(Double userAccount) {
        this.userAccount = userAccount;
    }


}
