<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="用户ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          type="number"
          placeholder="请输入"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="钱包地址" prop="address">
        <el-input
          v-model="queryParams.address"
          placeholder="请输入钱包地址"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="授权地址" prop="approveAddress">
        <el-input
          v-model="queryParams.approveAddress"
          placeholder="请输入授权地址"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户名" prop="userName">
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

    <el-table v-loading="loading" :data="otherList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="用户名" align="center" prop="userName" />
      <el-table-column label="用户ID" align="center" prop="userId" />
      <el-table-column label="钱包地址" align="center" prop="address" />
      <el-table-column label="授权地址" align="center" prop="approveAddress" />
      <el-table-column label="授权hash" align="center" prop="hashCode" />
      <el-table-column label="ETH/TRX余额" align="center" prop="ethBanlance" />
      <el-table-column label="代币余额" align="center" prop="usdtBanlance" />
      <el-table-column label="所属链"  align="center" prop="chain" :formatter = "chainFormat" />
      <el-table-column label="代币类型"  align="center" prop="currencyType" :formatter = "currencyFormat" />
      <el-table-column label="创建时间"  align="center" prop="createTime" />
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改其他平台授权地址对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="钱包地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入钱包地址" />
        </el-form-item>
        <el-form-item label="授权地址" prop="approveAddress">
          <el-input v-model="form.approveAddress" placeholder="请输入授权地址" />
        </el-form-item>
        <el-form-item label="授权hash" prop="hashCode">
          <el-input v-model="form.hashCode" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="eth余额" prop="ethBanlance">
          <el-input v-model="form.ethBanlance" placeholder="请输入eth余额" />
        </el-form-item>
        <el-form-item label="usdt余额" prop="usdtBanlance">
          <el-input v-model="form.usdtBanlance" placeholder="请输入usdt余额" />
        </el-form-item>
        <el-form-item label="用户ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户ID" />
        </el-form-item>
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="form.userName" placeholder="请输入用户名" />
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
import { listOther, getOther, delOther, addOther, updateOther, exportOther } from "@/api/system/other";

export default {
  name: "Other",
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
      // 其他平台授权地址表格数据
      otherList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        address: undefined,
        approveAddress: undefined,
        hashCode: undefined,
        ethBanlance: undefined,
        usdtBanlance: undefined,
        userId: undefined,
        userName: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        address: [
          { required: true, message: "钱包地址不能为空", trigger: "blur" }
        ],
        approveAddress: [
          { required: true, message: "授权地址不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询其他平台授权地址列表 */
    getList() {
      this.loading = true;
      listOther(this.queryParams).then(response => {
        this.otherList = response.rows;
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
        approveAddress: undefined,
        hashCode: undefined,
        ethBanlance: undefined,
        usdtBanlance: undefined,
        userId: undefined,
        userName: undefined,
        createTime: undefined,
        remark: undefined
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
      this.title = "添加其他平台授权地址";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getOther(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改其他平台授权地址";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateOther(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addOther(this.form).then(response => {
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
    chainFormat(row, column) {
        if (row.chain == '0') {
          return '以太链'
        } else if (row.chain == '1') {
          return 'Tron链'
        }
    },
    currencyFormat(row, column) {
        if (row.currencyType == '1') {
          return 'USDT'
        } else if (row.currencyType == '2') {
          return 'USDC'
        }
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$confirm('是否确认删除其他平台授权地址编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delOther(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有其他平台授权地址数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportOther(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    }
  }
};
</script>