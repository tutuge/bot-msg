package com.ruoyi.framework.task.vo;

import lombok.Data;

import java.io.Serializable;
@Data
public class KdataNew implements Serializable{
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private Double amount;//交易量

	private String close;//本阶段收盘价

	private String count;//交易次数

	private String high;//本阶段最高价

	private Long id;//时间戳

	private String low;//本阶段最低价

	private String open;//本阶段开盘价

	private String vol;//交易量

}
