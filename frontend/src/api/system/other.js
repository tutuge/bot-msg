import request from '@/utils/request'

// 查询其他平台授权地址列表
export function listOther(query) {
  return request({
    url: '/system/other/list',
    method: 'get',
    params: query
  })
}

// 查询其他平台授权地址详细
export function getOther(id) {
  return request({
    url: '/system/other/' + id,
    method: 'get'
  })
}

// 新增其他平台授权地址
export function addOther(data) {
  return request({
    url: '/system/other',
    method: 'post',
    data: data
  })
}

// 修改其他平台授权地址
export function updateOther(data) {
  return request({
    url: '/system/other',
    method: 'put',
    data: data
  })
}

// 删除其他平台授权地址
export function delOther(id) {
  return request({
    url: '/system/other/' + id,
    method: 'delete'
  })
}

// 导出其他平台授权地址
export function exportOther(query) {
  return request({
    url: '/system/other/export',
    method: 'get',
    params: query
  })
}