package com.ruoyi.project.system.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 开放API响应错误对象
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OpenApiError {

    /**
     * 错误编码
     */
    private String code;

    /**
     * 错误信息
     */
    private String msg;

    public static OpenApiError getError(ErrorCode errorCode) {
        return OpenApiError.builder()
                .code(errorCode.getCode())
                .msg(errorCode.getError())
                .build();
    }
}
