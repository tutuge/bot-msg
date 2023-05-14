package com.ruoyi.project.system.domain.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

public class ReportVo {

    private Long userid;

    private String phone;

    private String username;

    private String type;

    private String agentType;

    private Double allrecharge;

    private Double allout;

    private Double cunqucha;

    private Double zongyue;

    private String reportTimeType;

    private String queryType;

    private Long currencyId;

    private Double yingli;

    private Double guijiMoney;

    private Integer pageNum;

    private Integer pageSize;
    @JsonIgnore
    private String beginTime;
    /**
     * 结束时间
     */
    @JsonIgnore
    private String endTime;
    @JsonIgnore
    private String remark;
    @JsonIgnore
    private String userType;
    @JsonIgnore
    private String isOne;
    @JsonIgnore
    private String status;
    @JsonIgnore
    private String extendfUrl;

    private Long userId;

    private String is_in;

    private Double giveMoney;

    private Double winLoss;

    private Double financingMoney;

    private Double financingProfitMoney;

    private Double nftMoney;

    private Double loanMoney;

    private Double rePayLoanMoney;

    public void setUserid(Long userid) {
        this.userid = userid;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
    }

    public void setAllrecharge(Double allrecharge) {
        this.allrecharge = allrecharge;
    }

    public void setAllout(Double allout) {
        this.allout = allout;
    }

    public void setCunqucha(Double cunqucha) {
        this.cunqucha = cunqucha;
    }

    public void setZongyue(Double zongyue) {
        this.zongyue = zongyue;
    }

    public void setReportTimeType(String reportTimeType) {
        this.reportTimeType = reportTimeType;
    }

    public void setQueryType(String queryType) {
        this.queryType = queryType;
    }

    public void setCurrencyId(Long currencyId) {
        this.currencyId = currencyId;
    }

    public void setYingli(Double yingli) {
        this.yingli = yingli;
    }

    public void setGuijiMoney(Double guijiMoney) {
        this.guijiMoney = guijiMoney;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public void setIsOne(String isOne) {
        this.isOne = isOne;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setExtendfUrl(String extendfUrl) {
        this.extendfUrl = extendfUrl;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setIs_in(String is_in) {
        this.is_in = is_in;
    }

    public void setGiveMoney(Double giveMoney) {
        this.giveMoney = giveMoney;
    }

    public void setWinLoss(Double winLoss) {
        this.winLoss = winLoss;
    }

    public void setFinancingMoney(Double financingMoney) {
        this.financingMoney = financingMoney;
    }

    public void setFinancingProfitMoney(Double financingProfitMoney) {
        this.financingProfitMoney = financingProfitMoney;
    }

    public void setNftMoney(Double nftMoney) {
        this.nftMoney = nftMoney;
    }

    public void setLoanMoney(Double loanMoney) {
        this.loanMoney = loanMoney;
    }

    public void setRePayLoanMoney(Double rePayLoanMoney) {
        this.rePayLoanMoney = rePayLoanMoney;
    }

    public Long getUserid() {
        return userid;
    }

    public String getPhone() {
        return phone;
    }

    public String getUsername() {
        return username;
    }

    public String getType() {
        return type;
    }

    public String getAgentType() {
        return agentType;
    }

    public Double getAllrecharge() {
        return allrecharge;
    }

    public Double getAllout() {
        return allout;
    }

    public Double getCunqucha() {
        return cunqucha;
    }

    public Double getZongyue() {
        return zongyue;
    }

    public String getReportTimeType() {
        return reportTimeType;
    }

    public String getQueryType() {
        return queryType;
    }

    public Long getCurrencyId() {
        return currencyId;
    }

    public Double getYingli() {
        return yingli;
    }

    public Double getGuijiMoney() {
        return guijiMoney;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public String getRemark() {
        return remark;
    }

    public String getUserType() {
        return userType;
    }

    public String getIsOne() {
        return isOne;
    }

    public String getStatus() {
        return status;
    }

    public String getExtendfUrl() {
        return extendfUrl;
    }

    public Long getUserId() {
        return userId;
    }

    public String getIs_in() {
        return is_in;
    }

    public Double getGiveMoney() {
        return giveMoney;
    }

    public Double getWinLoss() {
        return winLoss;
    }

    public Double getFinancingMoney() {
        return financingMoney;
    }

    public Double getFinancingProfitMoney() {
        return financingProfitMoney;
    }

    public Double getNftMoney() {
        return nftMoney;
    }

    public Double getLoanMoney() {
        return loanMoney;
    }

    public Double getRePayLoanMoney() {
        return rePayLoanMoney;
    }
}
