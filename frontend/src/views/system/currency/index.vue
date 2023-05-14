<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="币种名称" prop="currencyName">
        <el-input
          v-model="queryParams.currencyName"
          placeholder="请输入币种名称"
          clearable
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
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
        >删除</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="currencyList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="币种名称" align="center" prop="currencyName" />
      <el-table-column label="币种全称" align="center" prop="fullName" />
      <el-table-column label="币种LOGO" align="center" prop="picUrl" >
          <template slot-scope="scope">
　　　　      <img :src="scope.row.picUrl" width="40" height="40" class="head_pic"/>
　　      </template>
      </el-table-column>
      <el-table-column label="对USD汇率" align="center" width="110"  prop="exchangeRate" :show-overflow-tooltip="true" />
      <el-table-column label="开启充值" align="center" prop="isRecharge" :formatter="isRechargeFormatter" />
      <el-table-column label="开启提现" align="center" prop="isCash" :formatter="isCashFormatter" />
      <el-table-column label="排序值" align="center" prop="seqNum" />
      <el-table-column label="操作" width="300" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-plus"
            @click="addDetailTable(scope.row)"
          >充值网络</el-button>
          <!-- <el-button
            size="mini"
            type="text"
            icon="el-icon-plus"
            @click="addDetailTxTable(scope.row)"
          >提现网络</el-button> -->
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

    <!-- 添加或修改平台币种对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="币种名称" prop="currencyName">
          <el-input v-model="form.currencyName" placeholder="请输入币种名称" />
        </el-form-item>
        <el-form-item label="币种全称" prop="fullName">
          <el-input v-model="form.fullName" placeholder="请输入币种全称" />
        </el-form-item>
        <el-form-item label="币种LOGO" prop="fileList">
            <imageUpload
              :value="form.fileList"
              @input="(e) => getImg(e)"
            ></imageUpload>
        </el-form-item>
        <el-form-item label="对USDT汇率" prop="exchangeRate">
          <el-input v-model="form.exchangeRate" placeholder="请输入对USDT汇率" />
        </el-form-item>
        <!-- <el-form-item label="最低投注" prop="minBetMoney">
          <el-input v-model="form.minBetMoney" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="最高投注" prop="maxBetMoney">
          <el-input v-model="form.maxBetMoney" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="最高利润" prop="maxProfit">
          <el-input v-model="form.maxProfit" placeholder="请输入" />
        </el-form-item> -->
        <el-form-item label="充值开启" prop="isRecharge">
          <el-select v-model="form.isRecharge"  placeholder="请选择">
            <el-option label="否" value="0" />
            <el-option label="是" value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="提现开启" prop="isCash">
          <el-select v-model="form.isCash"  placeholder="请选择">
            <el-option label="否" value="0" />
            <el-option label="是" value="1" />
          </el-select>
        </el-form-item>
        <!-- <el-form-item label="兑换开启" prop="isExchange">
          <el-select v-model="form.isExchange"  placeholder="请选择">
            <el-option label="否" value="0" />
            <el-option label="是" value="1" />
          </el-select>
        </el-form-item> -->
        <el-form-item label="排序" prop="seqNum">
          <el-input v-model="form.seqNum" type="number" placeholder="请输入" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listCurrency, getCurrency, delCurrency, addCurrency, updateCurrency } from "@/api/system/currency";
import ImageUpload from "@/components/ImageUpload"
export default {
  name: "Currency",
  components: { ImageUpload },
  data() {
    return {
      // 按钮loading
      buttonLoading: false,
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 平台币种表格数据
      currencyList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        currencyName: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        id: [
          { required: true, message: "币种ID不能为空", trigger: "blur" }
        ],
        currencyName: [
          { required: true, message: "币种名称不能为空", trigger: "blur" }
        ],
        fullName: [
          { required: true, message: "币种全称不能为空", trigger: "blur" }
        ],
        fileList: [
          { required: true, message: "图片不能为空", trigger: "blur" }
        ],
        seqNum: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        isRecharge: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        isCash: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        isExchange: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        maxBetMoney: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        maxProfit: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        minBetMoney: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询平台币种列表 */
    getList() {
      this.loading = true;
      listCurrency(this.queryParams).then(response => {
        this.currencyList = response.rows;
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
        currencyName: undefined,
        createBy: undefined,
        createTime: undefined,
        updateBy: undefined,
        updateTime: undefined,
        fullName:undefined,
        fileList:undefined,
        seqNum:undefined,
        isRecharge:'1',
        isCash:'1',
        isExchange:'1',
        exchangeRate:undefined,
        maxBetMoney:undefined,
        maxProfit:undefined,
        minBetMoney:undefined,
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
    getImg(e) {
      this.form.fileList = e;
    },
    addDetailTable(row) {
      const id = row.id;
      this.$router.push({
        path: '/system/network',
        query: {
          id: id
        }
      })
    },
    addDetailTxTable(row) {
      const id = row.id;
      this.$router.push({
        path: '/system/networktx',
        query: {
          id: id
        }
      })
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    isRechargeFormatter(row, column) {
        if (row.isRecharge == 0) {
          return '否'
        } else if (row.isRecharge == 1) {
          return '是'
        }
    },
    isCashFormatter(row, column) {
        if (row.isCash == 0) {
          return '否'
        } else if (row.isCash == 1) {
          return '是'
        }
    },
    isExchangeFormatter(row, column) {
        if (row.isExchange == 0) {
          return '否'
        } else if (row.isExchange == 1) {
          return '是'
        }
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加平台币种";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.loading = true;
      this.reset();
      const id = row.id || this.ids
      getCurrency(id).then(response => {
        this.loading = false;
        this.form = response.data;
        this.open = true;
        this.title = "修改平台币种";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.buttonLoading = true;
          if (this.form.id != null) {
            updateCurrency(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            }).finally(() => {
              this.buttonLoading = false;
            });
          } else {
            addCurrency(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            }).finally(() => {
              this.buttonLoading = false;
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除平台币种编号为"' + ids + '"的数据项？').then(() => {
        this.loading = true;
        return delCurrency(ids);
      }).then(() => {
        this.loading = false;
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).finally(() => {
        this.loading = false;
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('basic/currency/export', {
        ...this.queryParams
      }, `currency_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
