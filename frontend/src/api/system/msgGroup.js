import request from '@/utils/request'

// 查询消息组群列表
export function listMsgGroup(query) {
  return request({
    url: '/system/msggroup/list',
    method: 'get',
    params: query
  })
}

export function allMsgGroup() {
  return request({
    url: '/system/msggroup/all/info',
    method: 'get'
  })
}

// 查询消息组群详细
export function getMsgGroup(msgGroupId) {
  return request({
    url: '/system/msggroup/' + msgGroupId,
    method: 'get'
  })
}

// 新增消息组群
export function addMsgGroup(data) {
  return request({
    url: '/system/msggroup',
    method: 'post',
    data: data
  })
}

// 修改消息组群
export function updateMsgGroup(data) {
  return request({
    url: '/system/msggroup',
    method: 'put',
    data: data
  })
}

// 删除消息组群
export function delMsgGroup(msgGroupId) {
  return request({
    url: '/system/msggroup/' + msgGroupId,
    method: 'delete'
  })
}

// 导出消息组群
export function exportMsgGroup(query) {
  return request({
    url: '/system/msggroup/export',
    method: 'get',
    params: query
  })
}