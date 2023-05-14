import request from '@/utils/request'

// 查询平台前端用户列表
export function listUser(query) {
  return request({
    url: '/system/platuser/list',
    method: 'get',
    params: query
  })
}

// 查询用户等级列表
export function listLevel(query) {
  return request({
    url: '/system/level/list',
    method: 'get',
    params: query
  })
}

// 查询平台前端用户下级列表
export function listUserLow(query) {
  return request({
    url: '/system/platuser/lowlist',
    method: 'get',
    params: query
  })
}

// 查询平台前端用户详细
export function getUser(userId) {
  return request({
    url: '/system/platuser/' + userId,
    method: 'get'
  })
}

// 新增平台前端用户
export function addUser(data) {
  return request({
    url: '/system/platuser',
    method: 'post',
    data: data
  })
}
export function updatePwd(data) {
  return request({
    url: '/system/platuser/updatePwd',
    method: 'post',
    data: data
  })
}
export function updatePayPwd(data) {
  return request({
    url: '/system/platuser/updatePayPwd',
    method: 'post',
    data: data
  })
}

// 修改平台前端用户
export function updateUser(data) {
  console.log(data);
  return request({
    url: '/system/platuser/update',
    method: 'post',
    data: data
  })
}

// 删除平台前端用户
export function delUser(userId) {
  return request({
    url: '/system/platuser/' + userId,
    method: 'delete'
  })
}

// 导出平台前端用户
export function exportUser(query) {
  return request({
    url: '/system/platuser/export',
    method: 'get',
    params: query
  })
}

// 用户状态修改
export function changeUserStatus(userId, status) {
    const data = {
      userId,
      status
    }
    return request({
      url: '/system/platuser/changeStatus',
      method: 'put',
      data: data
    })
  }

  export function updateGoogle(userId) {
    return request({
      url: '/system/platuser/updateGoogle/' + userId,
      method: 'put'
    })
  }