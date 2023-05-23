package com.ruoyi.project.system.service.impl;

import com.ruoyi.project.system.domain.bo.MsgArrBo;
import com.ruoyi.project.system.service.MsgMatchService;
import org.springframework.stereotype.Service;

import java.util.concurrent.CopyOnWriteArrayList;

@Service
public class MsgMatchServiceImpl implements MsgMatchService {

    /**
     * 消息承接的数据结构
     */
    private final CopyOnWriteArrayList<MsgArrBo> msgs = new CopyOnWriteArrayList<>();

    /**
     * 对于每一条消息来说，都必须有发送人和接收人
     * 接收人是从接口这里获取的token对应的用户
     */
    @Override
    public String reply(String app, String sender, String message, String groupName, String username) {

        return null;
    }


    public int getIndex(int[] arr, int selectValue) {

        //初始化最小值的索引为0
        int left = 0;
        //初始化最大值的索引为arr.length-1
        int right = arr.length - 1;

        //首尾相加再除以2得出中间索引
        int mid = (left + right) / 2;

        while (left <= right) {
            //确保程序不会重复查询，不会越界
            if (selectValue > arr[mid]) {
                //如果查询的值比中间值大，则往右边区域找，就把最小索引改为中间索引右移一位
                left = mid + 1;
            } else if (selectValue < arr[mid]) {
                //如果查询的值比中间值小，则往左边区域找，就把最大索引改为中间索引左移一位
                right = mid - 1;
            } else {
                //剩余的情况就是查询到了结果，那么就直接返回索引。
                return mid;
            }
            mid = (left + right) / 2;
        }
        //没有查询到，则返回-1
        return -1;
    }
}
