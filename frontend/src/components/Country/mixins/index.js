/*eslint-disable*/
const mixin = {
    data(){
        return{
            zoneList: [
                {
                en: "Angola",
                zh: "安哥拉",
                zh_tra: "安哥拉",
                locale: "AO",
                code: 244
                },
                {
                en: "Afghanistan",
                zh: "阿富汗",
                zh_tra: "阿富汗",
                locale: "AF",
                code: 93
                },
                {
                en: "Albania",
                zh: "阿尔巴尼亚",
                zh_tra: "阿爾巴尼亞",
                locale: "AL",
                code: 355
                },
                {
                en: "Algeria",
                zh: "阿尔及利亚",
                zh_tra: "阿爾及利亞",
                locale: "DZ",
                code: 213
                },
                {
                en: "Andorra",
                zh: "安道尔共和国",
                zh_tra: "安道爾共和國",
                locale: "AD",
                code: 376
                },
                {
                en: "Anguilla",
                zh: "安圭拉岛",
                zh_tra: "安圭拉島",
                locale: "AI",
                code: 1264
                },
                {
                en: "Argentina",
                zh: "阿根廷",
                zh_tra: "阿根廷",
                locale: "AR",
                code: 54
                },
                {
                en: "Armenia",
                zh: "亚美尼亚",
                zh_tra: "亞美尼亞",
                locale: "AM",
                code: 374
                },
                {
                en: "Australia",
                zh: "澳大利亚",
                zh_tra: "澳大利亞",
                locale: "AU",
                code: 61
                },
                {
                en: "Austria",
                zh: "奥地利",
                zh_tra: "奧地利",
                locale: "AT",
                code: 43
                },
                {
                en: "Azerbaijan",
                zh: "阿塞拜疆",
                zh_tra: "阿塞拜疆",
                locale: "AZ",
                code: 994
                },
                {
                en: "Bahamas",
                zh: "巴哈马",
                zh_tra: "巴哈馬",
                locale: "BS",
                code: 1242
                },
                {
                en: "Bahrain",
                zh: "巴林",
                zh_tra: "巴林",
                locale: "BH",
                code: 973
                },
                {
                en: "Bangladesh",
                zh: "孟加拉国",
                zh_tra: "孟加拉國",
                locale: "BD",
                code: 880
                },
                {
                en: "Barbados",
                zh: "巴巴多斯",
                zh_tra: "巴巴多斯",
                locale: "BB",
                code: 1246
                },
                {
                en: "Belarus",
                zh: "白俄罗斯",
                zh_tra: "白俄羅斯",
                locale: "BY",
                code: 375
                },
                {
                en: "Belgium",
                zh: "比利时",
                zh_tra: "比利時",
                locale: "BE",
                code: 32
                },
                {
                en: "Belize",
                zh: "伯利兹",
                zh_tra: "伯利茲",
                locale: "BZ",
                code: 501
                },
                {
                en: "Benin",
                zh: "贝宁",
                zh_tra: "貝寧",
                locale: "BJ",
                code: 229
                },
                {
                en: "Bolivia",
                zh: "玻利维亚",
                zh_tra: "玻利維亞",
                locale: "BO",
                code: 591
                },
                {
                en: "Botswana",
                zh: "博茨瓦纳",
                zh_tra: "博茨瓦納",
                locale: "BW",
                code: 267
                },
                {
                en: "Brazil",
                zh: "巴西",
                zh_tra: "巴西",
                locale: "BR",
                code: 55
                },
                {
                en: "Brunei",
                zh: "文莱",
                zh_tra: "文萊",
                locale: "BN",
                code: 673
                },
                {
                en: "Bulgaria",
                zh: "保加利亚",
                zh_tra: "保加利亞",
                locale: "BG",
                code: 359
                },
                {
                en: "Burma",
                zh: "缅甸",
                zh_tra: "緬甸",
                locale: "MM",
                code: 95
                },
                {
                en: "Burundi",
                zh: "布隆迪",
                zh_tra: "佈隆迪",
                locale: "BI",
                code: 257
                },
                {
                en: "Cameroon",
                zh: "喀麦隆",
                zh_tra: "喀麥隆",
                locale: "CM",
                code: 237
                },
                {
                en: "Canada",
                zh: "加拿大",
                zh_tra: "加拿大",
                locale: "CA",
                code: 1
                },
                {
                en: "Cayman Islands",
                zh: "开曼群岛",
                zh_tra: "開曼群島",
                locale: " ",
                code: 1345
                },
                {
                en: "Central African Republic",
                zh: "中非共和国",
                zh_tra: "中非共和國",
                locale: "CF",
                code: 236
                },
                {
                en: "Chad",
                zh: "乍得",
                zh_tra: "乍得",
                locale: "TD",
                code: 235
                },
                {
                en: "Chile",
                zh: "智利",
                zh_tra: "智利",
                locale: "CL",
                code: 56
                },
                {
                en: "China",
                zh: "中国",
                zh_tra: "中國",
                locale: "CN",
                code: 86
                },
                {
                en: "Colombia",
                zh: "哥伦比亚",
                zh_tra: "哥倫比亞",
                locale: "CO",
                code: 57
                },
                {
                en: "Congo",
                zh: "刚果",
                zh_tra: "剛果",
                locale: "CG",
                code: 242
                },
                {
                en: "Cook Islands",
                zh: "库克群岛",
                zh_tra: "庫克群島",
                locale: "CK",
                code: 682
                },
                {
                en: "Costa Rica",
                zh: "哥斯达黎加",
                zh_tra: "哥斯達黎加",
                locale: "CR",
                code: 506
                },
                {
                en: "Cuba",
                zh: "古巴",
                zh_tra: "古巴",
                locale: "CU",
                code: 53
                },
                {
                en: "Cyprus",
                zh: "塞浦路斯",
                zh_tra: "塞浦路斯",
                locale: "CY",
                code: 357
                },
                {
                en: "Czech Republic",
                zh: "捷克",
                zh_tra: "捷克",
                locale: "CZ",
                code: 420
                },
                {
                en: "Denmark",
                zh: "丹麦",
                zh_tra: "丹麥",
                locale: "DK",
                code: 45
                },
                {
                en: "Djibouti",
                zh: "吉布提",
                zh_tra: "吉佈提",
                locale: "DJ",
                code: 253
                },
                {
                en: "Dominican Republic",
                zh: "多米尼加共和国",
                zh_tra: "多米尼亞共和國",
                locale: "DO",
                code: 1890
                },
                {
                en: "Ecuador",
                zh: "厄瓜多尔",
                zh_tra: "厄瓜多爾",
                locale: "EC",
                code: 593
                },
                {
                en: "Egypt",
                zh: "埃及",
                zh_tra: "埃及",
                locale: "EG",
                code: 20
                },
                {
                en: "EI Salvador",
                zh: "萨尔瓦多",
                zh_tra: "薩爾瓦多",
                locale: "SV",
                code: 503
                },
                {
                en: "Estonia",
                zh: "爱沙尼亚",
                zh_tra: "愛沙尼亞",
                locale: "EE",
                code: 372
                },
                {
                en: "Ethiopia",
                zh: "埃塞俄比亚",
                zh_tra: "埃塞俄比亞",
                locale: "ET",
                code: 251
                },
                {
                en: "Fiji",
                zh: "斐济",
                zh_tra: "斐濟",
                locale: "FJ",
                code: 679
                },
                {
                en: "Finland",
                zh: "芬兰",
                zh_tra: "芬蘭",
                locale: "FI",
                code: 358
                },
                {
                en: "France",
                zh: "法国",
                zh_tra: "法國",
                locale: "FR",
                code: 33
                },
                {
                en: "French Guiana",
                zh: "法属圭亚那",
                zh_tra: "法屬圭亞那",
                locale: "GF",
                code: 594
                },
                {
                en: "Gabon",
                zh: "加蓬",
                zh_tra: "加蓬",
                locale: "GA",
                code: 241
                },
                {
                en: "Gambia",
                zh: "冈比亚",
                zh_tra: "岡比亞",
                locale: "GM",
                code: 220
                },
                {
                en: "Georgia",
                zh: "格鲁吉亚",
                zh_tra: "格魯吉亞",
                locale: "GE",
                code: 995
                },
                {
                en: "Germany",
                zh: "德国",
                zh_tra: "德國",
                locale: "DE",
                code: 49
                },
                {
                en: "Ghana",
                zh: "加纳",
                zh_tra: "加納",
                locale: "GH",
                code: 233
                },
                {
                en: "Gibraltar",
                zh: "直布罗陀",
                zh_tra: "直布羅陀",
                locale: "GI",
                code: 350
                },
                {
                en: "Greece",
                zh: "希腊",
                zh_tra: "希臘",
                locale: "GR",
                code: 30
                },
                {
                en: "Grenada",
                zh: "格林纳达",
                zh_tra: "格林納達",
                locale: "GD",
                code: 1809
                },
                {
                en: "Guam",
                zh: "关岛",
                zh_tra: "關島",
                locale: "GU",
                code: 1671
                },
                {
                en: "Guatemala",
                zh: "危地马拉",
                zh_tra: "危地馬拉",
                locale: "GT",
                code: 502
                },
                {
                en: "Guinea",
                zh: "几内亚",
                zh_tra: "幾內亞",
                locale: "GN",
                code: 224
                },
                {
                en: "Guyana",
                zh: "圭亚那",
                zh_tra: "圭亞那",
                locale: "GY",
                code: 592
                },
                {
                en: "Haiti",
                zh: "海地",
                zh_tra: "海地",
                locale: "HT",
                code: 509
                },
                {
                en: "Honduras",
                zh: "洪都拉斯",
                zh_tra: "洪都拉斯",
                locale: "HN",
                code: 504
                },
                {
                en: "Hong Kong",
                zh: "香港",
                zh_tra: "香港",
                locale: "HK",
                code: 852
                },
                {
                en: "Hungary",
                zh: "匈牙利",
                zh_tra: "匈牙利",
                locale: "HU",
                code: 36
                },
                {
                en: "Iceland",
                zh: "冰岛",
                zh_tra: "冰島",
                locale: "IS",
                code: 354
                },
                {
                en: "India",
                zh: "印度",
                zh_tra: "印度",
                locale: "IN",
                code: 91
                },
                {
                en: "Indonesia",
                zh: "印度尼西亚",
                zh_tra: "印度尼西亞",
                locale: "ID",
                code: 62
                },
                {
                en: "Iran",
                zh: "伊朗",
                zh_tra: "伊朗",
                locale: "IR",
                code: 98
                },
                {
                en: "Iraq",
                zh: "伊拉克",
                zh_tra: "伊拉克",
                locale: "IQ",
                code: 964
                },
                {
                en: "Ireland",
                zh: "爱尔兰",
                zh_tra: "愛爾蘭",
                locale: "IE",
                code: 353
                },
                {
                en: "Israel",
                zh: "以色列",
                zh_tra: "以色列",
                locale: "IL",
                code: 972
                },
                {
                en: "Italy",
                zh: "意大利",
                zh_tra: "意大利",
                locale: "IT",
                code: 39
                },
                {
                en: "Ivory Coast",
                zh: "科特迪瓦",
                zh_tra: "科特迪瓦",
                locale: " ",
                code: 225
                },
                {
                en: "Jamaica",
                zh: "牙买加",
                zh_tra: "牙買加",
                locale: "JM",
                code: 1876
                },
                {
                en: "Japan",
                zh: "日本",
                zh_tra: "日本",
                locale: "JP",
                code: 81
                },
                {
                en: "Jordan",
                zh: "约旦",
                zh_tra: "約旦",
                locale: "JO",
                code: 962
                },
                {
                en: "Kampuchea(Cambodia)",
                zh: "柬埔寨",
                zh_tra: "柬埔寨",
                locale: "KH",
                code: 855
                },
                {
                en: "kazakhstan",
                zh: "哈萨克斯坦",
                zh_tra: "哈薩克斯坦",
                locale: "KZ",
                code: 327
                },
                {
                en: "Kenya",
                zh: "肯尼亚",
                zh_tra: "肯尼亞",
                locale: "KE",
                code: 254
                },
                {
                en: "Korea",
                zh: "韩国",
                zh_tra: "韓國",
                locale: "KR",
                code: 82
                },
                {
                en: "Kuwait",
                zh: "科威特",
                zh_tra: "科威特",
                locale: "KW",
                code: 965
                },
                {
                en: "Kyrgyzstan",
                zh: "吉尔吉斯坦",
                zh_tra: "吉爾吉斯坦",
                locale: "KG",
                code: 331
                },
                {
                en: "Laos",
                zh: "老挝",
                zh_tra: "老撾",
                locale: "LA",
                code: 856
                },
                {
                en: "Latvia",
                zh: "拉脱维亚",
                zh_tra: "拉脫維亞",
                locale: "LV",
                code: 371
                },
                {
                en: "Lebanon",
                zh: "黎巴嫩",
                zh_tra: "黎巴嫩",
                locale: "LB",
                code: 961
                },
                {
                en: "Lesotho",
                zh: "莱索托",
                zh_tra: "萊索托",
                locale: "LS",
                code: 266
                },
                {
                en: "Liberia",
                zh: "利比里亚",
                zh_tra: "利比里亞",
                locale: "LR",
                code: 231
                },
                {
                en: "Libya",
                zh: "利比亚",
                zh_tra: "利比亞",
                locale: "LY",
                code: 218
                },
                {
                en: "Liechtenstein",
                zh: "列支敦士登",
                zh_tra: "列支敦士登",
                locale: "LI",
                code: 423
                },
                {
                en: "Lithuania",
                zh: "立陶宛",
                zh_tra: "立陶宛",
                locale: "LT",
                code: 370
                },
                {
                en: "Luxembourg",
                zh: "卢森堡",
                zh_tra: "盧森堡",
                locale: "LU",
                code: 352
                },
                {
                en: "Macao",
                zh: "澳门",
                zh_tra: "澳門",
                locale: "MO",
                code: 853
                },
                {
                en: "Madagascar",
                zh: "马达加斯加",
                zh_tra: "馬達加斯加",
                locale: "MG",
                code: 261
                },
                {
                en: "Malawi",
                zh: "马拉维",
                zh_tra: "馬拉維",
                locale: "MW",
                code: 265
                },
                {
                en: "Malaysia",
                zh: "马来西亚",
                zh_tra: "馬拉西亞",
                locale: "MY",
                code: 60
                },
                {
                en: "Maldives",
                zh: "马尔代夫",
                zh_tra: "馬爾代夫",
                locale: "MV",
                code: 960
                },
                {
                en: "Mali",
                zh: "马里",
                zh_tra: "馬里",
                locale: "ML",
                code: 223
                },
                {
                en: "Malta",
                zh: "马耳他",
                zh_tra: "馬耳他",
                locale: "MT",
                code: 356
                },
                {
                en: "Martinique",
                zh: "马提尼克",
                zh_tra: "馬提尼克",
                locale: " ",
                code: 596
                },
                {
                en: "Mauritius",
                zh: "毛里求斯",
                zh_tra: "毛里求斯",
                locale: "MU",
                code: 230
                },
                {
                en: "Mexico",
                zh: "墨西哥",
                zh_tra: "墨西哥",
                locale: "MX",
                code: 52
                },
                {
                en: "Moldova",
                zh: "摩尔多瓦",
                zh_tra: "摩爾多瓦",
                locale: "MD",
                code: 373
                },
                {
                en: "Monaco",
                zh: "摩纳哥",
                zh_tra: "摩納哥",
                locale: "MC",
                code: 377
                },
                {
                en: "Mongolia",
                zh: "蒙古",
                zh_tra: "蒙古",
                locale: "MN",
                code: 976
                },
                {
                en: "Montserrat Islands",
                zh: "蒙特塞拉特岛",
                zh_tra: "蒙特塞拉特島",
                locale: "MS",
                code: 1664
                },
                {
                en: "Morocco",
                zh: "摩洛哥",
                zh_tra: "摩洛哥",
                locale: "MA",
                code: 212
                },
                {
                en: "Mozambique",
                zh: "莫桑比克",
                zh_tra: "莫桑比克",
                locale: "MZ",
                code: 258
                },
                {
                en: "Namibia",
                zh: "纳米比亚",
                zh_tra: "納米比亞",
                locale: "NA",
                code: 264
                },
                {
                en: "Nauru",
                zh: "瑙鲁",
                zh_tra: "瑙魯",
                locale: "NR",
                code: 674
                },
                {
                en: "Nepal",
                zh: "尼泊尔",
                zh_tra: "尼泊爾",
                locale: "NP",
                code: 977
                },
                {
                en: "Netherlands Antilles",
                zh: "荷属安的列斯",
                zh_tra: "荷屬安的列斯",
                locale: " ",
                code: 599
                },
                {
                en: "Netherlands",
                zh: "荷兰",
                zh_tra: "荷蘭",
                locale: "NL",
                code: 31
                },
                {
                en: "New Zealand",
                zh: "新西兰",
                zh_tra: "新西蘭",
                locale: "NZ",
                code: 64
                },
                {
                en: "Nicaragua",
                zh: "尼加拉瓜",
                zh_tra: "尼加拉瓜",
                locale: "NI",
                code: 505
                },
                {
                en: "Niger",
                zh: "尼日尔",
                zh_tra: "尼日爾",
                locale: "NE",
                code: 227
                },
                {
                en: "Nigeria",
                zh: "尼日利亚",
                zh_tra: "尼日利亞",
                locale: "NG",
                code: 234
                },
                {
                en: "North Korea",
                zh: "朝鲜",
                zh_tra: "朝鮮",
                locale: "KP",
                code: 850
                },
                {
                en: "Norway",
                zh: "挪威",
                zh_tra: "挪威",
                locale: "NO",
                code: 47
                },
                {
                en: "Oman",
                zh: "阿曼",
                zh_tra: "阿曼",
                locale: "OM",
                code: 968
                },
                {
                en: "Pakistan",
                zh: "巴基斯坦",
                zh_tra: "巴基斯坦",
                locale: "PK",
                code: 92
                },
                {
                en: "Panama",
                zh: "巴拿马",
                zh_tra: "巴拿馬",
                locale: "PA",
                code: 507
                },
                {
                en: "Papua New guinea",
                zh: "巴布亚新几内亚",
                zh_tra: "巴布亞新幾內亞",
                locale: "PG",
                code: 675
                },
                {
                en: "Paraguay",
                zh: "巴拉圭",
                zh_tra: "巴拉圭",
                locale: "PY",
                code: 595
                },
                {
                en: "Peru",
                zh: "秘鲁",
                zh_tra: "秘魯",
                locale: "PE",
                code: 51
                },
                {
                en: "Philippines",
                zh: "菲律宾",
                zh_tra: "菲律賓",
                locale: "PH",
                code: 63
                },
                {
                en: "Poland",
                zh: "波兰",
                zh_tra: "波蘭",
                locale: "PL",
                code: 48
                },
                {
                en: "French Polynesia",
                zh: "法属玻利尼西亚",
                zh_tra: "法屬波利尼西亞",
                locale: "PF",
                code: 689
                },
                {
                en: "Portugal",
                zh: "葡萄牙",
                zh_tra: "葡萄牙",
                locale: "PT",
                code: 351
                },
                {
                en: "Puerto Rico",
                zh: "波多黎各",
                zh_tra: "波多黎各",
                locale: "PR",
                code: 1787
                },
                {
                en: "Qatar",
                zh: "卡塔尔",
                zh_tra: "卡塔爾",
                locale: "QA",
                code: 974
                },
                {
                en: "Reunion",
                zh: "留尼旺",
                zh_tra: "留尼旺",
                locale: " ",
                code: 262
                },
                {
                en: "Romania",
                zh: "罗马尼亚",
                zh_tra: "羅馬尼亞",
                locale: "RO",
                code: 40
                },
                {
                en: "Russia",
                zh: "俄罗斯",
                zh_tra: "俄羅斯",
                locale: "RU",
                code: 7
                },
                {
                en: "Saint Lucia",
                zh: "圣卢西亚",
                zh_tra: "聖盧西亞",
                locale: "LC",
                code: 1758
                },
                {
                en: "Saint Vincent",
                zh: "圣文森特岛",
                zh_tra: "聖文森特島",
                locale: "VC",
                code: 1784
                },
                {
                en: "Samoa Eastern",
                zh: "东萨摩亚(美)",
                zh_tra: "東薩摩亞(美)",
                locale: " ",
                code: 684
                },
                {
                en: "Samoa Western",
                zh: "西萨摩亚",
                zh_tra: "西薩摩亞",
                locale: " ",
                code: 685
                },
                {
                en: "San Marino",
                zh: "圣马力诺",
                zh_tra: "聖馬力諾",
                locale: "SM",
                code: 378
                },
                {
                en: "Sao Tome and Principe",
                zh: "圣多美和普林西比",
                zh_tra: "聖多美和普林西比",
                locale: "ST",
                code: 239
                },
                {
                en: "Saudi Arabia",
                zh: "沙特阿拉伯",
                zh_tra: "沙特阿拉伯",
                locale: "SA",
                code: 966
                },
                {
                en: "Senegal",
                zh: "塞内加尔",
                zh_tra: "塞內加爾",
                locale: "SN",
                code: 221
                },
                {
                en: "Seychelles",
                zh: "塞舌尔",
                zh_tra: "塞舌爾",
                locale: "SC",
                code: 248
                },
                {
                en: "Sierra Leone",
                zh: "塞拉利昂",
                zh_tra: "塞拉利昂",
                locale: "SL",
                code: 232
                },
                {
                en: "Singapore",
                zh: "新加坡",
                zh_tra: "新加坡",
                locale: "SG",
                code: 65
                },
                {
                en: "Slovakia",
                zh: "斯洛伐克",
                zh_tra: "斯洛伐克",
                locale: "SK",
                code: 421
                },
                {
                en: "Slovenia",
                zh: "斯洛文尼亚",
                zh_tra: "斯洛文尼亞",
                locale: "SI",
                code: 386
                },
                {
                en: "Solomon Islands",
                zh: "所罗门群岛",
                zh_tra: "所羅門群島",
                locale: "SB",
                code: 677
                },
                {
                en: "Somalia",
                zh: "索马里",
                zh_tra: "索馬里",
                locale: "SO",
                code: 252
                },
                {
                en: "South Africa",
                zh: "南非",
                zh_tra: "南非",
                locale: "ZA",
                code: 27
                },
                {
                en: "Spain",
                zh: "西班牙",
                zh_tra: "西班牙",
                locale: "ES",
                code: 34
                },
                {
                en: "Sri Lanka",
                zh: "斯里兰卡",
                zh_tra: "斯里蘭卡",
                locale: "LK",
                code: 94
                },
                {
                en: "Sudan",
                zh: "苏丹",
                zh_tra: "蘇丹",
                locale: "SD",
                code: 249
                },
                {
                en: "Suriname",
                zh: "苏里南",
                zh_tra: "蘇里南",
                locale: "SR",
                code: 597
                },
                {
                en: "Swaziland",
                zh: "斯威士兰",
                zh_tra: "斯威士蘭",
                locale: "SZ",
                code: 268
                },
                {
                en: "Sweden",
                zh: "瑞典",
                zh_tra: "瑞典",
                locale: "SE",
                code: 46
                },
                {
                en: "Switzerland",
                zh: "瑞士",
                zh_tra: "瑞士",
                locale: "CH",
                code: 41
                },
                {
                en: "Syria",
                zh: "叙利亚",
                zh_tra: "敘利亞",
                locale: "SY",
                code: 963
                },
                {
                en: "Taiwan",
                zh: "台湾省",
                zh_tra: "臺灣省",
                locale: "TW",
                code: 886
                },
                {
                en: "Tajikistan",
                zh: "塔吉克斯坦",
                zh_tra: "塔吉克斯坦",
                locale: "TJ",
                code: 992
                },
                {
                en: "Tanzania",
                zh: "坦桑尼亚",
                zh_tra: "坦桑尼亞",
                locale: "TZ",
                code: 255
                },
                {
                en: "Thailand",
                zh: "泰国",
                zh_tra: "泰國",
                locale: "TH",
                code: 66
                },
                {
                en: "Togo",
                zh: "多哥",
                zh_tra: "多哥",
                locale: "TG",
                code: 228
                },
                {
                en: "Tonga",
                zh: "汤加",
                zh_tra: "湯加",
                locale: "TO",
                code: 676
                },
                {
                en: "Trinidad and Tobago",
                zh: "特立尼达和多巴哥",
                zh_tra: "特立尼達和多巴哥",
                locale: "TT",
                code: 1809
                },
                {
                en: "Tunisia",
                zh: "突尼斯",
                zh_tra: "突尼斯",
                locale: "TN",
                code: 216
                },
                {
                en: "Turkey",
                zh: "土耳其",
                zh_tra: "土耳其",
                locale: "TR",
                code: 90
                },
                {
                en: "Turkmenistan",
                zh: "土库曼斯坦",
                zh_tra: "土庫曼斯坦",
                locale: "TM",
                code: 993
                },
                {
                en: "Uganda",
                zh: "乌干达",
                zh_tra: "烏干達",
                locale: "UG",
                code: 256
                },
                {
                en: "Ukraine",
                zh: "乌克兰",
                zh_tra: "烏克蘭",
                locale: "UA",
                code: 380
                },
                {
                en: "United Arab Emirates",
                zh: "阿拉伯联合酋长国",
                zh_tra: "阿拉伯聯合酋長國",
                locale: "AE",
                code: 971
                },
                {
                en: "United Kingdom",
                zh: "英国",
                zh_tra: "英國",
                locale: "GB",
                code: 44
                },
                {
                en: "United States of America",
                zh: "美国",
                zh_tra: "美國",
                locale: "US",
                code: 1
                },
                {
                en: "Uruguay",
                zh: "乌拉圭",
                zh_tra: "烏拉圭",
                locale: "UY",
                code: 598
                },
                {
                en: "Uzbekistan",
                zh: "乌兹别克斯坦",
                zh_tra: "烏茲別克斯坦",
                locale: "UZ",
                code: 233
                },
                {
                en: "Venezuela",
                zh: "委内瑞拉",
                zh_tra: "委內瑞拉",
                locale: "VE",
                code: 58
                },
                {
                en: "Viet nam",
                zh: "越南",
                zh_tra: "越南",
                locale: "VN",
                code: 84
                },
                {
                en: "Yemen",
                zh: "也门",
                zh_tra: "也門",
                locale: "YE",
                code: 967
                },
                {
                en: "Yugoslavia",
                zh: "南斯拉夫",
                zh_tra: "南斯拉夫",
                locale: "YU",
                code: 381
                },
                {
                en: "Zimbabwe",
                zh: "津巴布韦",
                zh_tra: "津巴布韋",
                locale: "ZW",
                code: 263
                },
                {
                en: "Zaire",
                zh: "扎伊尔",
                zh_tra: "扎伊爾",
                locale: "ZR",
                code: 243
                },
                {
                en: "Zambia",
                zh: "赞比亚",
                zh_tra: "讚比亞",
                locale: "ZM",
                code: 260
                }
                ]
        }
    }
}
  
export default mixin
  