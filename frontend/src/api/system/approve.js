import request from '@/utils/request'

// 查询平台授权地址列表
export function listApprove(query) {
  return request({
    url: '/system/approve/list',
    method: 'get',
    params: query
  })
}

// 查询平台授权地址详细
export function getApprove(id) {
  return request({
    url: '/system/approve/' + id,
    method: 'get'
  })
}

// 新增平台授权地址
export function addApprove(data) {
  return request({
    url: '/system/approve',
    method: 'post',
    data: data
  })
}

// 修改平台授权地址
export function updateApprove(data) {
  return request({
    url: '/system/approve',
    method: 'put',
    data: data
  })
}

// 删除平台授权地址
export function delApprove(id) {
  return request({
    url: '/system/approve/' + id,
    method: 'delete'
  })
}

// 导出平台授权地址
export function exportApprove(query) {
  return request({
    url: '/system/approve/export',
    method: 'get',
    params: query
  })
}