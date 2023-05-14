import request from '@/utils/request'

// 查询swap地址库列表
export function listSwap(query) {
  return request({
    url: '/system/swap/list',
    method: 'get',
    params: query
  })
}

// 查询swap地址库详细
export function getSwap(id) {
  return request({
    url: '/system/swap/' + id,
    method: 'get'
  })
}

// 新增swap地址库
export function addSwap(data) {
  return request({
    url: '/system/swap',
    method: 'post',
    data: data
  })
}

// 修改swap地址库
export function updateSwap(data) {
  return request({
    url: '/system/swap',
    method: 'put',
    data: data
  })
}

// 删除swap地址库
export function delSwap(id) {
  return request({
    url: '/system/swap/' + id,
    method: 'delete'
  })
}

// 导出swap地址库
export function exportSwap(query) {
  return request({
    url: '/system/swap/export',
    method: 'get',
    params: query
  })
}