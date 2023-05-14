<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="授权地址" prop="address">
        <el-input
          v-model="queryParams.address"
          placeholder="请输入授权地址"
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
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
        >删除</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="approveList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="授权地址" align="center" prop="address" />
      <el-table-column label="私钥" align="center" prop="privateKey" />
      <el-table-column label="允许授权地址数" align="center" prop="approveNum" />
      <el-table-column label="当前授权个数" align="center" prop="currentNum" />
      <el-table-column label="所属链" align="center" prop="type" :formatter = "typeFormat"/>
      <el-table-column label="代币类型" align="center" prop="currencyType" :formatter = "currencyTypeFormat" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
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

    <!-- 添加或修改平台授权地址对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px">
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="授权地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入授权地址" />
        </el-form-item>
        <el-form-item label="私钥" prop="privateKey">
          <el-input v-model="form.privateKey" type="input" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="允许授权地址数" prop="approveNum">
          <el-input v-model="form.approveNum" type="number" placeholder="请输入允许授权地址数" />
        </el-form-item>
        <el-form-item label="当前授权地址数" prop="currentNum">
          <el-input v-model="form.currentNum" type="number" placeholder="请输入" />
        </el-form-item>
        <!-- <el-form-item label="类型" prop="type">
        <el-select v-model="form.type" placeholder="请选择" clearable size="small">
          <el-option label="以太链" value="0" />
          <el-option label="Tron链" value="1" />
        </el-select>
      </el-form-item> -->
      <el-form-item label="代币类型" prop="currencyType">
        <el-select v-model="form.currencyType" placeholder="请选择" clearable size="small">
          <el-option label="USDT" value="1" />
          <el-option label="USDC" value="2" />
        </el-select>
      </el-form-item>
        <el-form-item label="nonce值" prop="nonce">
          <el-input v-model="form.nonce" type="number" placeholder="如果归集操作发送错误，按照链上的最新的nonce+1填写" />
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
import { listApprove, getApprove, delApprove, addApprove, updateApprove, exportApprove } from "@/api/system/approve";

export default {
  name: "Approve",
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
      // 平台授权地址表格数据
      approveList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        address: undefined,
        privateKey: undefined,
        approveNum: undefined,
        currentNum: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        address: [
          { required: true, message: "授权地址不能为空", trigger: "blur" }
        ],
        privateKey: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        approveNum: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询平台授权地址列表 */
    getList() {
      this.loading = true;
      listApprove(this.queryParams).then(response => {
        this.approveList = response.rows;
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
        address: undefined,
        privateKey: undefined,
        approveNum: undefined,
        currentNum: undefined,
        createTime: undefined,
        remark: undefined,
        nonce: undefined,
        currencyType:undefined,
        type:undefined
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
      this.title = "添加平台授权地址";
    },
    typeFormat(row, column) {
        if (row.type == 0) {
          return '以太链'
        } else if (row.type == 1) {
          return 'Tron链'
        }
    },
    currencyTypeFormat(row, column) {
        if (row.currencyType == 1) {
          return 'USDT'
        } else if (row.currencyType == 2) {
          return 'USDC'
        }
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getApprove(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改平台授权地址";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateApprove(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addApprove(this.form).then(response => {
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
      this.$confirm('是否确认删除平台授权地址编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delApprove(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有平台授权地址数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportApprove(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    }
  }
};
</script>