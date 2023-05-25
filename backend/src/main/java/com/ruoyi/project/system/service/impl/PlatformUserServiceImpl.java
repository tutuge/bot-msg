package com.ruoyi.project.system.service.impl;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.project.system.controller.vo.PlatformUserVo;
import com.ruoyi.project.system.domain.PlatformGroup;
import com.ruoyi.project.system.domain.PlatformMsgGroup;
import com.ruoyi.project.system.domain.PlatformUser;
import com.ruoyi.project.system.mapper.PlatformUserMapper;
import com.ruoyi.project.system.service.IPlatformGroupService;
import com.ruoyi.project.system.service.IPlatformMsgGroupService;
import com.ruoyi.project.system.service.IPlatformUserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 平台前端用户Service业务层处理
 *
 * @author none
 * @date 2020-04-06
 */
@Service
public class PlatformUserServiceImpl extends ServiceImpl<PlatformUserMapper, PlatformUser> implements IPlatformUserService {
    @Resource
    private PlatformUserMapper platformUserMapper;

    @Resource
    private IPlatformGroupService platformGroupService;
    @Resource
    private IPlatformMsgGroupService platformMsgGroupService;


    /**
     * 查询平台前端用户
     *
     * @param userId 平台前端用户ID
     * @return 平台前端用户
     */
    @Override
    public PlatformUser selectPlatformUserById(Long userId) {
        return platformUserMapper.selectById(userId);
    }

    @Override
    public PlatformUser selectPlatformUserByAccessToken(String accessToken) {
        LambdaQueryWrapper<PlatformUser> eq = Wrappers.lambdaQuery(PlatformUser.class)
                .eq(PlatformUser::getAccessToken, accessToken);
        return platformUserMapper.selectOne(eq);
    }

    /**
     * 查询平台前端用户列表
     *
     * @param platformUser 平台前端用户
     * @return 平台前端用户
     */
    @Override
    public List<PlatformUserVo> selectPlatformUserList(PlatformUser platformUser) {
        LambdaQueryWrapper<PlatformUser> eq = Wrappers.lambdaQuery(PlatformUser.class)
                .eq(StrUtil.isNotBlank(platformUser.getAccessToken()), PlatformUser::getAccessToken, platformUser.getAccessToken())
                .eq(StrUtil.isNotBlank(platformUser.getUserName()), PlatformUser::getUserName, platformUser.getUserName())
                .eq(ObjectUtil.isNotNull(platformUser.getUserId()), PlatformUser::getUserId, platformUser.getUserId());
        List<PlatformUser> platformUsers = platformUserMapper.selectList(eq);

        //查询用户分组
        List<PlatformGroup> platformGroups = platformGroupService.selectPlatformGroupList(new PlatformGroup());
        Map<Long, PlatformGroup> userGroupMap = platformGroups.stream().collect(Collectors.toMap(PlatformGroup::getGroupId, a -> a, (k1, k2) -> k1));
        //查询消息分组
        List<PlatformMsgGroup> platformMsgGroups = platformMsgGroupService.selectPlatformMsgGroupList(new PlatformMsgGroup());
        Map<Long, PlatformMsgGroup> msgGroupMap = platformMsgGroups.stream().collect(Collectors.toMap(PlatformMsgGroup::getMsgGroupId, a -> a, (k1, k2) -> k1));
        //转换
        List<PlatformUserVo> list = new ArrayList<>();
        for (PlatformUser user : platformUsers) {
            PlatformUserVo platformUserVo = new PlatformUserVo();
            platformUserVo.setUserId(user.getUserId());
            platformUserVo.setUserName(user.getUserName());
            platformUserVo.setAccessToken(user.getAccessToken());
            Long userGroupId = user.getUserGroupId();
            platformUserVo.setUserGroupId(userGroupId);
            PlatformGroup platformGroup = userGroupMap.get(userGroupId);
            if (ObjectUtil.isNotNull(platformGroup)) {
                String groupName = platformGroup.getGroupName();
                platformUserVo.setUserGroupName(groupName);
            }
            String msgGroupIds = user.getMsgGroupIds();
            if (StrUtil.isNotBlank(msgGroupIds)) {
                String[] split = msgGroupIds.split(",");
                List<Long> msgGroupIdsLong = Arrays.stream(split).map(Long::valueOf).collect(Collectors.toList());
                platformUserVo.setMsgGroupIds(msgGroupIdsLong);
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < msgGroupIdsLong.size(); i++) {
                    Long msgGroupId = msgGroupIdsLong.get(i);
                    PlatformMsgGroup platformMsgGroup = msgGroupMap.get(msgGroupId);
                    if (ObjectUtil.isNotNull(platformMsgGroup)) {
                        if (i == msgGroupIdsLong.size() - 1) {
                            builder.append(platformMsgGroup.getMsgGroupName());
                        } else {
                            builder.append(platformMsgGroup.getMsgGroupName()).append(",");
                        }
                    }

                }
                platformUserVo.setMsgGroupName(builder.toString());
            }

            list.add(platformUserVo);
        }
        return list;
    }

    /**
     * 新增平台前端用户
     *
     * @param platformUser 平台前端用户
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertPlatformUser(PlatformUser platformUser) {
        platformUser.setAccessToken(IdUtil.fastSimpleUUID());
        int num = platformUserMapper.insert(platformUser);
        return num;
    }

    /**
     * 修改平台前端用户
     *
     * @param platformUser 平台前端用户
     * @return 结果
     */
    @Override
    public int updatePlatformUser(PlatformUser platformUser) {
        return platformUserMapper.updateById(platformUser);
    }


    /**
     * 批量删除平台前端用户
     *
     * @param userIds 需要删除的平台前端用户ID
     * @return 结果
     */
    @Override
    public int deletePlatformUserByIds(Long[] userIds) {
        return platformUserMapper.deletePlatformUserByIds(userIds);
    }

    /**
     * 删除平台前端用户信息
     *
     * @param userId 平台前端用户ID
     * @return 结果
     */
    @Override
    public int deletePlatformUserById(Long userId) {
        return platformUserMapper.deletePlatformUserById(userId);
    }

    @Override
    public List<PlatformUserVo> selectPlatformUserVoList() {
        return platformUserMapper.selectPlatformUserVoList();
    }

    @Override
    public List<PlatformUser> selectByMsgGroupId(Long msgGroupId) {
        return platformUserMapper.selectByMsgGroupId(msgGroupId);
    }
}
