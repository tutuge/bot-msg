<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="用户ID" prop="userId">
        <el-input
            v-model="queryParams.userId"
            placeholder="请输入用户ID"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户名" prop="nickName">
        <el-input
            v-model="queryParams.userName"
            placeholder="请输入用户名"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="success"
            icon="el-icon-plus"
            size="mini"
            @click="handleAdd"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            icon="el-icon-edit"
            size="mini"
            :disabled="single"
            @click="handleUpdate"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            icon="el-icon-delete"
            size="mini"
            :disabled="multiple"
            @click="handleDelete"
        >删除
        </el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="userList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="ID" align="center" prop="userId" width="80"/>
      <el-table-column label="用户名" align="center" prop="userName"/>
      <el-table-column label="用户组" align="center" prop="userGroupName"/>
      <el-table-column label="token" align="center" prop="accessToken"/>
      <el-table-column label="回复指定组群" align="center" prop="msgGroupName"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
          >修改信息
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改平台前端用户对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px">
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="form.userName" placeholder="请输入用户名"/>
        </el-form-item>
        <el-form-item label="用户组" prop="userGroupId">
          <el-select v-model="form.userGroupId" placeholder="请选择用户组" clearable size="small">
            <el-option
                v-for="dict in userGroup"
                :key="dict.groupId"
                :label="dict.groupName"
                :value="dict.groupId"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="回复指定组群" prop="userGroupId">
          <el-select v-model="form.msgGroupIds" multiple placeholder="请选择用户组" clearable size="small">
            <el-option
                v-for="dict in userMsgGroup"
                :key="dict.msgGroupId"
                :label="dict.msgGroupName"
                :value="dict.msgGroupId"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import {addUser, delUser, getUser, listUser, updateUser} from "@/api/system/platformuser";
import {allGroup} from "@/api/system/group";
import {allMsgGroup} from "@/api/system/msgGroup";

export default {
  name: "User",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 总条数
      total: 0,
      // 平台前端用户表格数据
      userList: [],
      userGroup: [], // 所有用户分组的信息
      userMsgGroup: [], //所有消息组群
      //用户级别数据
      userLevelOptions: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      readonly: true,
      update: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: undefined,
        userName: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userName: [
          {required: true, message: "用户名不能为空", trigger: "blur"}
        ],
        // accessToken: [
        //   {required: true, message: "token不能为空", trigger: "blur"}
        // ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /**
     * 获取所有用户分组的信息
     */
    getAllGroup() {
      allGroup().then(res => {
        this.userGroup = res.data;
      })
    },
    /**
     * 获取所有消息组群
     */
    getAllMsgGroup() {
      allMsgGroup().then(res => {
        this.userMsgGroup = res.data;
      })
    },
    /** 查询平台前端用户列表 */
    getList() {
      this.loading = true;
      listUser(this.queryParams).then(response => {
        this.userList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },

    // 表单重置
    reset() {
      this.form = {
        userId: undefined,
        userName: undefined,
        accessToken: undefined,
        userGroupId: undefined,
        userGroupName: undefined,
        msgGroupIds: undefined,
        msgGroupName: undefined,
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.userId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      Promise.all([this.getAllGroup(),this.getAllMsgGroup()]);
      this.open = true;
      this.title = "添加平台用户";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const userId = row.userId || this.ids
      Promise.all([this.getAllGroup(),this.getAllMsgGroup(),this.getUserInfo(row.userId)])
      this.open = true;
      this.title = "修改平台前端用户";
    },
    /**
     * 获取用户信息
     */
    getUserInfo(userId){
      getUser(userId).then(response => {
        this.form = response.data;
      });
    },

    /** 提交按钮 */
    submitForm: function () {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.msgGroupIds = this.form.msgGroupIds.join(",")
          if (this.form.userId !== undefined) {
            updateUser(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addUser(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("新增成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const userIds = row.userId || this.ids;
      this.$confirm('是否确认删除平台前端用户编号为"' + userIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return delUser(userIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      }).catch(function () {
      });
    },

  }
};
</script>