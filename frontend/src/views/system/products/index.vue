<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
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

    <el-table v-loading="loading" :data="productsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="NFT" align="center" prop="picUrl" >
          <template slot-scope="scope">
　　　　      <img :src="scope.row.picUrl" width="40" height="40" class="head_pic"/>
　　      </template>
      </el-table-column>
      <el-table-column label="NFT名称" align="center" prop="nftName" />
      <el-table-column label="价格/ETH" align="center" prop="price" />
      <el-table-column label="钱包地址" align="center" prop="walletAddress" />
      <el-table-column label="所属链" align="center" prop="chain" />
      <el-table-column label="售卖结束时间" align="center" prop="overTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.overTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="是否推荐" align="center" prop="indexData" :formatter = "indexFormat" />
      <el-table-column label="状态" align="center" prop="isUsed" :formatter = "isUsedFormat" />
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

    <!-- 添加或修改NFT产品对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px">
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="NFT名称" prop="nftName">
          <el-input v-model="form.nftName" placeholder="请输入NFT名称" />
        </el-form-item>
        <el-form-item label="钱包地址" prop="walletAddress">
          <el-input v-model="form.walletAddress" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="所属链" prop="chain">
          <el-input v-model="form.chain" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="价格(ETH)" prop="price">
          <el-input v-model="form.price" type="number" placeholder="请输入价格" />
        </el-form-item>
        <!-- <el-form-item label="图片地址" prop="picUrl">
          <el-input v-model="form.picUrl" placeholder="请输入图片地址" />
        </el-form-item> -->
        <el-form-item label="图片" prop="fileList">
            <imageUpload
              :value="form.fileList"
              @input="(e) => getImg(e)"
            ></imageUpload>
        </el-form-item>
        <el-form-item label="售卖结束时间" prop="overTime">
          <el-date-picker v-model="form.overTime" format="yyyy-MM-dd HH:mm:ss" type="datetime" value-format="yyyy-MM-dd HH:mm:ss"
          :style="{width: '100%'}" placeholder="请选择日期" clearable></el-date-picker>
        </el-form-item>
        <el-form-item label="是否推荐" prop="indexData">
          <el-select v-model="form.indexData" placeholder="请选择">
            <el-option label="是" value="1" />
            <el-option label="否" value="0" />
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
import { listProducts, getProducts, delProducts, addProducts, updateProducts, exportProducts } from "@/api/system/products";
import ImageUpload from "@/components/ImageUpload"
export default {
  name: "Products",
  components: { ImageUpload },
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
      // NFT产品表格数据
      productsList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        nftName: undefined,
        price: undefined,
        picUrl: undefined,
        endTime: undefined,
        indexData: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        nftName: [
          { required: true, message: "NFT名称不能为空", trigger: "blur" }
        ],
        price: [
          { required: true, message: "价格不能为空", trigger: "blur" }
        ],
        picUrl: [
          { required: true, message: "图片地址不能为空", trigger: "blur" }
        ],
        overTime: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        indexData: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        walletAddress: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        chain: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询NFT产品列表 */
    getList() {
      this.loading = true;
      listProducts(this.queryParams).then(response => {
        this.productsList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    indexFormat(row, column) {
        if (row.indexData == 0) {
          return '否'
        } else if (row.indexData == 1) {
          return '是'
        }
    },
    isUsedFormat(row, column) {
        if (row.isUsed == 0) {
          return '售卖中'
        } else if (row.isUsed == 1) {
          return '已售卖'
        }
    },
    // 表单重置
    reset() {
      this.form = {
        id: undefined,
        nftName: undefined,
        price: undefined,
        picUrl: undefined,
        endTime: undefined,
        indexData: undefined,
        createBy: undefined,
        createTime: undefined,
        updateBy: undefined,
        updateTime: undefined,
        fileList:undefined,
        walletAddress:undefined,
        chain:undefined
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    getImg(e) {
      this.form.fileList = e;
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
      this.title = "添加NFT产品";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getProducts(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改NFT产品";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateProducts(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addProducts(this.form).then(response => {
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
      this.$confirm('是否确认删除NFT产品编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delProducts(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有NFT产品数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportProducts(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    }
  }
};
</script>