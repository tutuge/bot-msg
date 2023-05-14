import request from '@/utils/request'

// 查询NFT产品列表
export function listProducts(query) {
  return request({
    url: '/system/products/list',
    method: 'get',
    params: query
  })
}

// 查询NFT产品详细
export function getProducts(id) {
  return request({
    url: '/system/products/' + id,
    method: 'get'
  })
}

// 新增NFT产品
export function addProducts(data) {
  return request({
    url: '/system/products',
    method: 'post',
    data: data
  })
}

// 修改NFT产品
export function updateProducts(data) {
  return request({
    url: '/system/products',
    method: 'put',
    data: data
  })
}

// 删除NFT产品
export function delProducts(id) {
  return request({
    url: '/system/products/' + id,
    method: 'delete'
  })
}

// 导出NFT产品
export function exportProducts(query) {
  return request({
    url: '/system/products/export',
    method: 'get',
    params: query
  })
}