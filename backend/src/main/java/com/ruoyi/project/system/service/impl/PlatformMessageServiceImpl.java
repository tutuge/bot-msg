package com.ruoyi.project.system.service.impl;

import com.ruoyi.project.system.domain.PlatformMessage;
import com.ruoyi.project.system.mapper.PlatformMessageMapper;
import com.ruoyi.project.system.service.IPlatformMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class PlatformMessageServiceImpl implements IPlatformMessageService {
    @Autowired
    private PlatformMessageMapper platformMessageMapper;

    @Override
    public int insertPlatformMessage(PlatformMessage platformMessage) {
        platformMessage.setCreateTime(new Date());
        return platformMessageMapper.insertPlatformMessage(platformMessage);
    }
}
