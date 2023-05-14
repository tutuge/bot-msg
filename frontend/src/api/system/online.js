import request from '@/utils/request'

// 查询用户在线情况列表
export function listOnline(query) {
  return request({
    url: '/system/online/list',
    method: 'get',
    params: query
  })
}

// 查询用户在线情况详细
export function getOnline(id) {
  return request({
    url: '/system/online/' + id,
    method: 'get'
  })
}

// 新增用户在线情况
export function addOnline(data) {
  return request({
    url: '/system/online',
    method: 'post',
    data: data
  })
}

// 修改用户在线情况
export function updateOnline(data) {
  return request({
    url: '/system/online',
    method: 'put',
    data: data
  })
}

// 删除用户在线情况
export function delOnline(id) {
  return request({
    url: '/system/online/' + id,
    method: 'delete'
  })
}

// 导出用户在线情况
export function exportOnline(query) {
  return request({
    url: '/system/online/export',
    method: 'get',
    params: query
  })
}