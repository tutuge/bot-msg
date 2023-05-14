package com.ruoyi.framework.security.filter;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.ruoyi.common.constant.HttpStatus;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.security.ThirdLoginUser;
import com.ruoyi.framework.security.service.TokenService;
import com.ruoyi.framework.web.domain.AjaxResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * token过滤器 验证token有效性
 *
 * @author none
 */
@Slf4j
@Component
public class PlatformTokenFilter extends OncePerRequestFilter {
    @Autowired
    private TokenService tokenService;

    /**
     * 这个地方可以改造成适应管理端用户和平台用户的过滤器
     *
     * @param request  请求
     * @param response 响应
     * @param chain    调用链
     * @throws ServletException 错误
     * @throws IOException      错误
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {
        log.info("进入accesstoken的filter");
        String accessToken = tokenService.getAccessToken(request);
        if (StrUtil.isNotBlank(accessToken) && StringUtils.isNull(SecurityUtils.getAuthentication())) {
            log.info("当前accessToken--->{}", accessToken);
            ThirdLoginUser thirdLoginUser = tokenService.verifyAccessToken(accessToken);
            log.info("当前accessToken找到的平台用户--->{}", thirdLoginUser);
            if (ObjectUtil.isNull(thirdLoginUser)) {
                ServletUtils.renderString(response, JSON.toJSONString(AjaxResult.error(HttpStatus.FORBIDDEN, "错误的accessToken")));
                return;
            } else {
                UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(thirdLoginUser, null, thirdLoginUser.getAuthorities());
                authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            }
        }
        chain.doFilter(request, response);
    }
}
