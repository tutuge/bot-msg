package com.ruoyi.project.system.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SimpleResponseDto {
    /**
     * 状态
     */
    private int status;
    /**
     * 结果
     */
    private Object result;
    /**
     * 消息
     */
    private String message;

    public static SimpleResponseDto ok() {
        return SimpleResponseDto.builder()
                .status(HttpStatus.OK.value())
                .message("ok")
                .result(true)
                .build();
    }
}
