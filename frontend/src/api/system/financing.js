import request from '@/utils/request'

// 查询产品的理财配置列表
export function listFinancing(query) {
  return request({
    url: '/system/financing/list',
    method: 'get',
    params: query
  })
}

// 查询产品的理财配置详细
export function getFinancing(id) {
  return request({
    url: '/system/financing/' + id,
    method: 'get'
  })
}

// 新增产品的理财配置
export function addFinancing(data) {
  return request({
    url: '/system/financing',
    method: 'post',
    data: data
  })
}

// 修改产品的理财配置
export function updateFinancing(data) {
  return request({
    url: '/system/financing',
    method: 'put',
    data: data
  })
}

// 删除产品的理财配置
export function delFinancing(id) {
  return request({
    url: '/system/financing/' + id,
    method: 'delete'
  })
}

// 导出产品的理财配置
export function exportFinancing(query) {
  return request({
    url: '/system/financing/export',
    method: 'get',
    params: query
  })
}