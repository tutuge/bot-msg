<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="app名称" prop="appName">
        <el-input
          v-model="queryParams.appName"
          placeholder="请输入app名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发送人" prop="sender">
        <el-input
          v-model="queryParams.sender"
          placeholder="请输入发送人"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发送人id" prop="senderId">
        <el-input
          v-model="queryParams.senderId"
          placeholder="请输入发送人id"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发送过来的消息体" prop="message">
        <el-input
          v-model="queryParams.message"
          placeholder="请输入发送过来的消息体"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="组群名" prop="groupName">
        <el-input
          v-model="queryParams.groupName"
          placeholder="请输入组群名"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="接收人" prop="receiver">
        <el-input
          v-model="queryParams.receiver"
          placeholder="请输入接收人"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="接送人id" prop="receiverId">
        <el-input
          v-model="queryParams.receiverId"
          placeholder="请输入接送人id"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="要回复的消息" prop="msg">
        <el-input
          v-model="queryParams.msg"
          placeholder="请输入要回复的消息"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="相关的上一条消息id，没有上一条就是1" prop="pid">
        <el-input
          v-model="queryParams.pid"
          placeholder="请输入相关的上一条消息id，没有上一条就是1"
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
          type="primary"
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:msg:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:msg:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:msg:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:msg:export']"
        >导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="msgList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="id" align="center" prop="id" />
      <el-table-column label="app名称" align="center" prop="appName" />
      <el-table-column label="发送人" align="center" prop="sender" />
      <el-table-column label="发送人id" align="center" prop="senderId" />
      <el-table-column label="发送过来的消息体" align="center" prop="message" />
      <el-table-column label="组群名" align="center" prop="groupName" />
      <el-table-column label="接收人" align="center" prop="receiver" />
      <el-table-column label="接送人id" align="center" prop="receiverId" />
      <el-table-column label="要回复的消息" align="center" prop="msg" />
      <el-table-column label="相关的上一条消息id，没有上一条就是1" align="center" prop="pid" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:msg:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:msg:remove']"
          >删除</el-button>
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

    <!-- 添加或修改【请填写功能名称】对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="app名称" prop="appName">
          <el-input v-model="form.appName" placeholder="请输入app名称" />
        </el-form-item>
        <el-form-item label="发送人" prop="sender">
          <el-input v-model="form.sender" placeholder="请输入发送人" />
        </el-form-item>
        <el-form-item label="发送人id" prop="senderId">
          <el-input v-model="form.senderId" placeholder="请输入发送人id" />
        </el-form-item>
        <el-form-item label="发送过来的消息体" prop="message">
          <el-input v-model="form.message" placeholder="请输入发送过来的消息体" />
        </el-form-item>
        <el-form-item label="组群名" prop="groupName">
          <el-input v-model="form.groupName" placeholder="请输入组群名" />
        </el-form-item>
        <el-form-item label="接收人" prop="receiver">
          <el-input v-model="form.receiver" placeholder="请输入接收人" />
        </el-form-item>
        <el-form-item label="接送人id" prop="receiverId">
          <el-input v-model="form.receiverId" placeholder="请输入接送人id" />
        </el-form-item>
        <el-form-item label="要回复的消息" prop="msg">
          <el-input v-model="form.msg" placeholder="请输入要回复的消息" />
        </el-form-item>
        <el-form-item label="相关的上一条消息id，没有上一条就是1" prop="pid">
          <el-input v-model="form.pid" placeholder="请输入相关的上一条消息id，没有上一条就是1" />
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
import { listMsg, getMsg, delMsg, addMsg, updateMsg, exportMsg } from "@/api/system/msg";

export default {
  name: "Msg",
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
      // 【请填写功能名称】表格数据
      msgList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        appName: undefined,
        sender: undefined,
        senderId: undefined,
        message: undefined,
        groupName: undefined,
        receiver: undefined,
        receiverId: undefined,
        msg: undefined,
        pid: undefined
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        appName: [
          { required: true, message: "app名称不能为空", trigger: "blur" }
        ],
        sender: [
          { required: true, message: "发送人不能为空", trigger: "blur" }
        ],
        senderId: [
          { required: true, message: "发送人id不能为空", trigger: "blur" }
        ],
        message: [
          { required: true, message: "发送过来的消息体不能为空", trigger: "blur" }
        ],
        receiver: [
          { required: true, message: "接收人不能为空", trigger: "blur" }
        ],
        receiverId: [
          { required: true, message: "接送人id不能为空", trigger: "blur" }
        ],
        msg: [
          { required: true, message: "要回复的消息不能为空", trigger: "blur" }
        ],
        pid: [
          { required: true, message: "相关的上一条消息id，没有上一条就是1不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listMsg(this.queryParams).then(response => {
        this.msgList = response.rows;
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
        id: undefined,
        appName: undefined,
        sender: undefined,
        senderId: undefined,
        message: undefined,
        groupName: undefined,
        receiver: undefined,
        receiverId: undefined,
        msg: undefined,
        pid: undefined
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加【请填写功能名称】";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getMsg(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改【请填写功能名称】";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateMsg(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addMsg(this.form).then(response => {
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
      const ids = row.id || this.ids;
      this.$confirm('是否确认删除【请填写功能名称】编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delMsg(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有【请填写功能名称】数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportMsg(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    }
  }
};
</script>