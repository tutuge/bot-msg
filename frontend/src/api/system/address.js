import request from '@/utils/request'

// 查询监控钱包地址列表
export function listAddress(query) {
  return request({
    url: '/system/address/list',
    method: 'get',
    params: query
  })
}

// 查询监控钱包地址详细
export function getAddress(id) {
  return request({
    url: '/system/address/' + id,
    method: 'get'
  })
}

export function getSkdz() {
  return request({
    url: '/system/address/getSkdz',
    method: 'get'
  })
}

export function getGjInfo(id) {
  return request({
    url: '/system/address/getGjInfo/'+id,
    method: 'get'
  })
}

export function updateErc20Money() {
  return request({
    url: '/system/address/updateErc20Money',
    method: 'get'
  })
}

export function updateErc20MoneyOne(id) {
  return request({
    url: '/system/address/updateErc20MoneyOne/'+id,
    method: 'post'
  })
}

export function getMaxId() {
  return request({
    url: '/system/address/getMaxId',
    method: 'get'
  })
}

// 新增监控钱包地址
export function addAddress(data) {
  return request({
    url: '/system/address',
    method: 'post',
    data: data
  })
}

export function checkGoogle(data) {
  return request({
    url: '/system/address/checkGoogle',
    method: 'post',
    data: data
  })
}

export function guiji(data) {
  return request({
    url: '/system/address/notionalPooling',
    method: 'post',
    data:data
  })
}

// 修改监控钱包地址
export function updateAddress(data) {
  return request({
    url: '/system/address',
    method: 'put',
    data: data
  })
}

// 删除监控钱包地址
export function delAddress(id) {
  return request({
    url: '/system/address/' + id,
    method: 'delete'
  })
}

// 导出监控钱包地址
export function exportAddress(query) {
  return request({
    url: '/system/address/export',
    method: 'get',
    params: query
  })
}