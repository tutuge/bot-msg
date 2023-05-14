<template>
  <div class="app-container">
    <el-row :gutter="10" class="mb8">
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

    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="时间戳" align="center" prop="id" />
      <el-table-column label="本阶段开盘价" align="center" prop="open" />
      <el-table-column label="本阶段收盘价" align="center" prop="close" />
      <el-table-column label="本阶段最低价" align="center" prop="low" />
      <el-table-column label="本阶段最高价" align="center" prop="high" />
      <el-table-column label="基础币交易量" align="center" prop="amount" />
      <el-table-column label="报价币交易量" align="center" prop="vol" />
      <el-table-column label="交易次数" align="center" prop="countNum" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
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

    <!-- 添加或修改新币K线对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="基础币交易量" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入基础币交易量" />
        </el-form-item>
        <el-form-item label="时间戳" prop="id">
          <el-input v-model="form.id" placeholder="请输入时间戳" />
        </el-form-item>
        <el-form-item label="交易次数" prop="countNum">
          <el-input v-model="form.countNum" placeholder="请输入交易次数" />
        </el-form-item>
        <el-form-item label="本阶段开盘价" prop="open">
          <el-input v-model="form.open" placeholder="请输入本阶段开盘价" />
        </el-form-item>
        <el-form-item label="本阶段收盘价" prop="close">
          <el-input v-model="form.close" placeholder="请输入本阶段收盘价" />
        </el-form-item>
        <el-form-item label="本阶段最低价" prop="low">
          <el-input v-model="form.low" placeholder="请输入本阶段最低价" />
        </el-form-item>
        <el-form-item label="本阶段最高价" prop="high">
          <el-input v-model="form.high" placeholder="请输入本阶段最高价" />
        </el-form-item>
        <el-form-item label="报价币交易量" prop="vol">
          <el-input v-model="form.vol" placeholder="请输入报价币交易量" />
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
import { listData, getData, delData, addData, updateData, exportData } from "@/api/system/data";

export default {
  name: "Data",
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
      // 新币K线表格数据
      dataList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        amount: undefined,
        countNum: undefined,
        open: undefined,
        close: undefined,
        low: undefined,
        high: undefined,
        vol: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询新币K线列表 */
    getList() {
      this.loading = true;
      listData(this.queryParams).then(response => {
        this.dataList = response.rows;
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
        klineId: undefined,
        amount: undefined,
        id: undefined,
        countNum: undefined,
        open: undefined,
        close: undefined,
        low: undefined,
        high: undefined,
        vol: undefined,
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
      this.ids = selection.map(item => item.klineId)
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加新币K线";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const klineId = row.klineId || this.ids
      getData(klineId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改新币K线";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.klineId != undefined) {
            updateData(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addData(this.form).then(response => {
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
      const klineIds = row.klineId || this.ids;
      this.$confirm('是否确认删除新币K线编号为"' + klineIds + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delData(klineIds);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有新币K线数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportData(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    }
  }
};
</script>