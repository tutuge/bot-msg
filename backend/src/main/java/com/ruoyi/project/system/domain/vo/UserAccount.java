package com.ruoyi.project.system.domain.vo;

public class UserAccount {
    private Long userId;

    private Double chongzhi;

    private Long currcyId;

    private Double koufei;

    private String remark;

    public Long getCurrcyId() {
        return currcyId;
    }

    public void setCurrcyId(Long currcyId) {
        this.currcyId = currcyId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }


    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Double getChongzhi() {
        return chongzhi;
    }

    public void setChongzhi(Double chongzhi) {
        this.chongzhi = chongzhi;
    }

    public Double getKoufei() {
        return koufei;
    }

    public void setKoufei(Double koufei) {
        this.koufei = koufei;
    }


}
