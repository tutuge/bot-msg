<template>
  <div class="country_select_container">
    <div class="search_content">
      <div class="search_input">
        <input type="text" v-model="searchText" placeholder="Please enter keywords">
      </div>
      <div class="cancel" @click="searchText=''">Cancel</div>
    </div>
    <div class="select current">
      <div class="title">Current Selection</div>
      <div class="item">
        <div class="left">
          <img v-if="countrySelectIndex>=0" :src="zoneList[countrySelectIndex].icon" alt="">
          <div>
            <span class="name">{{countrySelectIndex>=0?zoneList[countrySelectIndex].name:'no choose'}}</span>
            <span class="code">+ {{countrySelectIndex>=0?zoneList[countrySelectIndex].code:''}}</span>
          </div>
        </div>
        <div class="right" v-if="countrySelectIndex>=0">
          √
        </div>
      </div>
    </div>
    <div class="select all">
      <div class="title">Top </div>
      <div class="all_select_wrapper" v-if="!showSearchResult">
        <div class="item" 
          @click="selectCountry(1,index)"
          v-for="(item, index) in zoneList" :key="index">
          <div class="left">
            <img :src="item.icon" alt="">
            <span class="name">{{item.name}}</span>
            <span class="code">+ {{item.code}}</span>
          </div>
          <div class="right" v-if="item.select">
            √
          </div>
        </div>
      </div>
      <div class="all_select_wrapper" v-else>
        <div class="item" 
          @click="selectCountry(2,index)"
          v-for="(item, index) in searchResult" :key="index">
          <div class="left">
            <img :src="item.icon" alt="">
            <span class="name">{{item.name}}</span>
            <span class="code">+ {{item.code}}</span>
          </div>
          <div class="right" v-if="item.select">
            √
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import mixin from './mixins/index'
  export default {
    props: {
      name: ''
    },
    data() {
      return {
        searchText: '',
        countrySelectIndex: -1,
        showSearchResult: false,
        searchResult: []
      }
    },
    mixins: [mixin],
    watch: {
      name: {
        handler() {
          this.zoneList.forEach((item, index) => {
            item.select = false
            if (this.name===item.name) {
              this.countrySelectIndex = index
              item.select = true
            }
          });
        },
        deep: true
      },
      searchText() {
        this.searchResult = []
        const text = this.searchText.toLowerCase()
        this.zoneList.forEach(item => {
          const name = item.name.toLowerCase()
          if (name.indexOf(text)!=-1) {
            this.searchResult.push(item)
          }
        });
        if (this.searchResult.length>0) {
          this.showSearchResult = true
        }
      }
    },
    created() {
      this.zoneList.forEach(item => {
        var name = item.en.toLowerCase()
        name = name.split(' ').join('_');
        item.icon = require("@/assets/flags/"+name+".png")
        item.name = item.zh
        item.select = false
      });
    },
    methods: {
      selectCountry(type,index) {
        var selectCountry
        if (this.countrySelectIndex!== -1) {
          this.zoneList[this.countrySelectIndex].select = false;
        }
        if (type===1) {
          this.countrySelectIndex = index
          this.zoneList[index].select = true;
          selectCountry = this.zoneList[index]
        }else {
          const name = this.searchResult[index].name
          this.zoneList.forEach((item, index)=> {
            if (item.name === name) {
              this.countrySelectIndex = index
              this.zoneList[index].select = true;
              selectCountry = this.zoneList[index]
            }
          });
        }
        this.$emit('select', selectCountry)
        this.countrySelectIndex = -1
        this.searchResult = []
        this.showSearchResult = false
        this.zoneList[index].select = false
      },
    },
  }
</script>

<style lang="scss" scoped>
.country_select_container {
  .search_content {
    display: flex;
    justify-content: space-between;
    padding-bottom: 12px;
    border-bottom: 1px solid #ccc;
    .search_input {
      position: relative;
      width:80%;
      height:100%;
      border-radius:2px;
      input {
        width: 100%;
        padding: 10px;
        outline: none;
        border: 1px solid #ccc;
      }
    }
    .cancel {
      margin-top: 12px;
      color: #3369D9;
      font-weight: bold;
    }
  }
  .select {
    margin-top: 10px;
    .title {
      padding: 10px;
      background-color: rgba($color: #000000, $alpha: 0.6);
      color: #fff;
    }
    .item {
      display: flex;
      justify-content: space-between;
      padding: 10px;
      border-bottom: 1px solid #ccc;
      .left {
        position: relative;
        img {
          position: absolute;
          width: 44px;
          height: 44px;
        }
        .name {
          line-height: 44px;
          margin-left: 10px;
          padding-left: 44px;
        }
        .code {
          line-height: 44px;
          margin-left: 10px;
        }
      }
      .right {
        line-height: 44px;
      }
    }
  }
}
</style>