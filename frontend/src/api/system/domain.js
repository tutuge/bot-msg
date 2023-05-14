import request from '@/utils/request'

// 查询平台第三方域名管理列表
export function listDomain(query) {
  return request({
    url: '/system/domain/list',
    method: 'get',
    params: query
  })
}

// 查询平台第三方域名管理详细
export function getDomain(id) {
  return request({
    url: '/system/domain/' + id,
    method: 'get'
  })
}

export function getUUID(id) {
  return request({
    url: '/system/domain/getUUID',
    method: 'get'
  })
}

// 新增平台第三方域名管理
export function addDomain(data) {
  return request({
    url: '/system/domain',
    method: 'post',
    data: data
  })
}

// 修改平台第三方域名管理
export function updateDomain(data) {
  return request({
    url: '/system/domain',
    method: 'put',
    data: data
  })
}

// 删除平台第三方域名管理
export function delDomain(id) {
  return request({
    url: '/system/domain/' + id,
    method: 'delete'
  })
}

// 导出平台第三方域名管理
export function exportDomain(query) {
  return request({
    url: '/system/domain/export',
    method: 'get',
    params: query
  })
}