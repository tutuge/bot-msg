import request from '@/utils/request'

// 查询产品信息列表
export function listProductinfo(query) {
  return request({
    url: '/system/productinfo/list',
    method: 'get',
    params: query
  })
}

export function listData() {
  return request({
    url: '/system/pair/listData',
    method: 'get'
  })
}

export function getMaxNum() {
  return request({
    url: '/system/productinfo/getMaxNum',
    method: 'get'
  })
}

export function getMaxNumXs() {
  return request({
    url: '/system/productinfo/getMaxNumXs',
    method: 'get'
  })
}

export function changeproduct(pid, isopen) {
  const data = {
    pid,
    isopen
  }
  return request({
    url: '/system/productinfo/changeOpen',
    method: 'put',
    data: data
  })
}

// 查询产品信息详细
export function getProductinfo(pid) {
  return request({
    url: '/system/productinfo/' + pid,
    method: 'get'
  })
}

// 新增产品信息
export function addProductinfo(data) {
  return request({
    url: '/system/productinfo',
    method: 'post',
    data: data
  })
}

// 修改产品信息
export function updateProductinfo(data) {
  return request({
    url: '/system/productinfo',
    method: 'put',
    data: data
  })
}

// 删除产品信息
export function delProductinfo(pid) {
  return request({
    url: '/system/productinfo/' + pid,
    method: 'delete'
  })
}

// 导出产品信息
export function exportProductinfo(query) {
  return request({
    url: '/system/productinfo/export',
    method: 'get',
    params: query
  })
}