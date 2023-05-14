package com.ruoyi.framework.security.filter;

import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.framework.security.LoginUser;
import com.ruoyi.framework.security.service.TokenService;
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
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {
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
        boolean aNull = StringUtils.isNull(SecurityUtils.getAuthentication());
        log.info("Authentication是否为null--->{}", aNull);
        if (!aNull) {
            chain.doFilter(request, response);
            return;
        }
        LoginUser loginUser = tokenService.getLoginUser(request);
        log.info("进入jwtfilter--->{}", loginUser);
        if (StringUtils.isNotNull(loginUser)) {
            log.info("进入jwtfilter内部");
            String ip = loginUser.getIpaddr();
            //获取当前请求的ip地址
            String currentIp = IpUtils.getIpAddr(request);
            if (!ip.equals(currentIp)) {
                //强制下线
                String userName = loginUser.getUsername();
                // 删除用户缓存记录
                tokenService.delLoginUser(loginUser.getToken());
                // 记录用户退出日志
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(userName, Constants.LOGOUT, "IP不一致强制下线", loginUser.getUser().getUserId()));
                //ServletUtils.renderString(response, JSON.toJSONString(AjaxResult.error(HttpStatus.SUCCESS, "退出成功")));
            } else {
                tokenService.verifyToken(loginUser);
                UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(loginUser, null, loginUser.getAuthorities());
                authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            }
        }
        chain.doFilter(request, response);
    }
}
