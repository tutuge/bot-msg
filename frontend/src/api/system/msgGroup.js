import request from '@/utils/request'

// 查询消息组群列表
export function listGroup(query) {
  return request({
    url: '/system/msggroup/list',
    method: 'get',
    params: query
  })
}

// 查询消息组群详细
export function getGroup(msgGroupId) {
  return request({
    url: '/system/msggroup/' + msgGroupId,
    method: 'get'
  })
}

// 新增消息组群
export function addGroup(data) {
  return request({
    url: '/system/msggroup',
    method: 'post',
    data: data
  })
}

// 修改消息组群
export function updateGroup(data) {
  return request({
    url: '/system/msggroup',
    method: 'put',
    data: data
  })
}

// 删除消息组群
export function delGroup(msgGroupId) {
  return request({
    url: '/system/msggroup/' + msgGroupId,
    method: 'delete'
  })
}

// 导出消息组群
export function exportGroup(query) {
  return request({
    url: '/system/msggroup/export',
    method: 'get',
    params: query
  })
}