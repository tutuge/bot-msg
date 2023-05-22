package com.ruoyi.framework.security;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ruoyi.project.system.domain.PlatformUser;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.StringJoiner;

/**
 * 登录用户身份权限
 *
 * @author none
 */
public class ThirdLoginUser implements UserDetails {
    private static final long serialVersionUID = 1L;

    /**
     * 用户信息
     */
    private PlatformUser user;


    public PlatformUser getUser() {
        return user;
    }

    public void setUser(PlatformUser user) {
        this.user = user;
    }

    @JsonIgnore
    @Override
    public String getPassword() {
        return "";
    }

    @Override
    public String getUsername() {
        return user.getUserName();
    }

    /**
     * 账户是否未过期,过期无法验证
     */
    @JsonIgnore
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    /**
     * 指定用户是否解锁,锁定的用户无法进行身份验证
     *
     * @return
     */
    @JsonIgnore
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    /**
     * 指示是否已过期的用户的凭据(密码),过期的凭据防止认证
     *
     * @return
     */
    @JsonIgnore
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    /**
     * 是否可用 ,禁用的用户不能身份验证
     *
     * @return
     */
    @JsonIgnore
    @Override
    public boolean isEnabled() {
        return true;
    }



    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", ThirdLoginUser.class.getSimpleName() + "[", "]")
                .add("user=" + user)
                .toString();
    }
}
