import request from '@/utils/request'

// 查询静态收益配置列表
export function listGains(query) {
  return request({
    url: '/system/gains/list',
    method: 'get',
    params: query
  })
}

// 查询静态收益配置详细
export function getGains(id) {
  return request({
    url: '/system/gains/' + id,
    method: 'get'
  })
}

// 新增静态收益配置
export function addGains(data) {
  return request({
    url: '/system/gains',
    method: 'post',
    data: data
  })
}

// 修改静态收益配置
export function updateGains(data) {
  return request({
    url: '/system/gains',
    method: 'put',
    data: data
  })
}

// 删除静态收益配置
export function delGains(id) {
  return request({
    url: '/system/gains/' + id,
    method: 'delete'
  })
}

// 导出静态收益配置
export function exportGains(query) {
  return request({
    url: '/system/gains/export',
    method: 'get',
    params: query
  })
}