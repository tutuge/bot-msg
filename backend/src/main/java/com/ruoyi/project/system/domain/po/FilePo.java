package com.ruoyi.project.system.domain.po;

import lombok.Data;

import java.io.Serializable;

/**
 * 上传文件接收对象
 */
@Data
public class FilePo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String name;

    private String ossId;

    private String url;
}
