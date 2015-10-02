var cities_no = ['7', '8', '9', '10'];
var current_city_no_index = 0;


var bet_times = {
  '7' : 1,
  '8' : 3,
  '9' : 8,
  '10' : 19,
  '11' : 41,
  '12' : 85,
  '13' : 180,
  '14' : 380,
  '15' : 800
};

var money;


var my_caipiao_datas = {};  //我的彩票记录
var caipiao_datas = {
  '7' : {
    'current_no' : '2015090534',
    'meta' : {
      'max_lost' : 0,
      'max_lost_num' : '01'
    },
    'nums' : {
      '01' : {'lost' : 5},
      '02' : {'lost' : 0},
      '03' : {'lost' : 0},
      '04' : {'lost' : 0},
      '05' : {'lost' : 4},
      '06' : {'lost' : 1},
      '07' : {'lost' : 0},
      '08' : {'lost' : 1},
      '09' : {'lost' : 1},
      '10' : {'lost' : 3},
      '11' : {'lost' : 0},
    }
  },
  '8' : {
    'current_no' : '2015090535',
    'meta' : {
      'max_lost' : 0,
      'max_lost_num' : '01'
    },
    'nums' : {
      '01' : {'lost' : 1},
      '02' : {'lost' : 1},
      '03' : {'lost' : 1},
      '04' : {'lost' : 0},
      '05' : {'lost' : 0},
      '06' : {'lost' : 1},
      '07' : {'lost' : 0},
      '08' : {'lost' : 2},
      '09' : {'lost' : 0},
      '10' : {'lost' : 2},
      '11' : {'lost' : 0},
    }
  },
  '9' : {
    'current_no' : '2015090534',
    'meta' : {
      'max_lost' : 0,
      'max_lost_num' : '01'
    },
    'nums' : {
      '01' : {'lost' : 0},
      '02' : {'lost' : 0},
      '03' : {'lost' : 1},
      '04' : {'lost' : 4},
      '05' : {'lost' : 0},
      '06' : {'lost' : 1},
      '07' : {'lost' : 1},
      '08' : {'lost' : 2},
      '09' : {'lost' : 6},
      '10' : {'lost' : 0},
      '11' : {'lost' : 0},
    }
  },
  '10' : {
    'current_no' : '2015090534',
    'meta' : {
      'max_lost' : 0,
      'max_lost_num' : '01'
    },
    'nums' : {
      '01' : {'lost' : 0},
      '02' : {'lost' : 7},
      '03' : {'lost' : 0},
      '04' : {'lost' : 5},
      '05' : {'lost' : 3},
      '06' : {'lost' : 0},
      '07' : {'lost' : 0},
      '08' : {'lost' : 1},
      '09' : {'lost' : 1},
      '10' : {'lost' : 0},
      '11' : {'lost' : 1},
    }
  },      
};  //我的彩票记录

function generateNewCaipiao(_city_no, _no){
  //购买新彩票
  var _new_caipiao = null;

  var _max_lost = caipiao_datas[_city_no.toString()]['meta']['max_lost'];
  var _max_lost_num = caipiao_datas[_city_no.toString()]['meta']['max_lost_num'];

  if(_max_lost > min_lost){
    //遗漏大于min_lost开始购买

    var _first_no = parseInt(_no);
    var _caipiaos = [];
    for(var i = _max_lost; i< max_lost; i++){
      _new_caipiao = {'city_no': _city_no.toString(), 'no': (_first_no+_caipiaos.length).toString(), 'times' : bet_times[i], 'num' : _max_lost_num, 'lost' : i, 'award' : false, 'is_win' : false, 'is_bought' : false};
      _caipiaos.push(_new_caipiao);
    }
    return _caipiaos;
    // _new_caipiao = {'city_no': _city_no.toString(), 'no': _no, 'times' : bet_times[_max_lost.toString()], 'num' : _max_lost_num, 'lost' : _max_lost, 'award' : false, 'is_win' : false, 'is_bought' : false};
    // my_caipiao_datas[_city_no+'-'+_no] = _new_caipiao;
    // console.log('购买 '+ _city_no + ' 城市的 第' + _no + ' 期新彩票');
    // return _new_caipiao;
  }else{
    console.log('未达到购买条件！');
    return null;
  }
}

function generateTrackCaipiao(_no, _last_caipiao){
  //购买跟单彩票
  var _new_caipiao = null;
  var _city_no = _last_caipiao['city_no'];
  _new_caipiao = {'city_no' : _city_no, 'no': _no, 'times' : bet_times[(_last_caipiao['lost']+1).toString()], 'num' : _last_caipiao['num'], 'lost' : _last_caipiao['lost'] + 1, 'award' : false, 'is_win' : false, 'is_bought' : false};
  my_caipiao_datas[_city_no+'-'+_no] = _new_caipiao;
  console.log('购买 '+ _city_no + ' 城市的 第' + _no + ' 期跟踪彩票');
  return _new_caipiao;
}

function refreshLost(_city_no, _last_no, _last_nums){
  var _city_caipiaos = caipiao_datas[_city_no.toString()];
  if(_city_caipiaos['current_no'] == _last_no){
    //已经更新过了，不再更新
    return null;
  }else{
    _city_caipiaos['current_no'] = _last_no;

    var _last_caipiao_nums = _last_nums.split(',');

    _city_caipiaos['nums']['01']['lost']++;
    _city_caipiaos['nums']['02']['lost']++;
    _city_caipiaos['nums']['03']['lost']++;
    _city_caipiaos['nums']['04']['lost']++;
    _city_caipiaos['nums']['05']['lost']++;
    _city_caipiaos['nums']['06']['lost']++;
    _city_caipiaos['nums']['07']['lost']++;
    _city_caipiaos['nums']['08']['lost']++;
    _city_caipiaos['nums']['09']['lost']++;
    _city_caipiaos['nums']['10']['lost']++;
    _city_caipiaos['nums']['11']['lost']++;

    for(var i = 0;i < _last_caipiao_nums.length;i++){
      _city_caipiaos['nums'][_last_caipiao_nums[i]]['lost'] = 0;
    }

    var _max_lost = _city_caipiaos['nums']['01']['lost'];
    var _max_lost_num = '01';

    for(var i=2;i<12;i++){
      var _code = i < 10 ? '0'+i : ''+i;

      var _lost = _city_caipiaos['nums'][_code]['lost'];
      if(_lost > _max_lost){
        _max_lost = _lost;
        _max_lost_num = _code;
      }
    }

    _city_caipiaos['meta']['max_lost'] = _max_lost;
    _city_caipiaos['meta']['max_lost_num'] = _max_lost_num;
  }
}

function mainWorkFlow(){

  var current_time = new Date();
  var current_hour = current_time.getHours();
  if(current_hour < 9 || current_hour > 21){
    return null;
  }

  var current_city_no = cities_no[current_city_no_index%4];
  current_city_no_index++;

  fireCaiPiaoEvent('getResult', current_city_no, function(data){
    var _last_no = data['2'][1];    //开奖期数
    var _last_nums = data['2'][2];  //开奖结果
    var _new_no = data['5'][2];    //开奖期数

    var _this_caipiao = false;    //当前彩票

    var _new_caipiao = null;      //新彩票

    if(caipiao_datas[current_city_no]['current_no'] == _last_no){
      console.log('已经兑奖过了！');
      return null;
    }

    if((parseInt(_new_no)-parseInt(_last_no))!= 1){
      console.log('开奖期数不对！');
      return null;
    } 

    refreshLost(current_city_no, _last_no, _last_nums);  //更新遗漏率

    try{
      _this_caipiao = my_caipiao_datas[current_city_no+'-'+_last_no];
    }catch(error){
      _this_caipiao = false;
      console.log('没有购买 '+ current_city_no + ' 号城市第 ' + _last_no + ' 期彩票！');
    }

    if(_this_caipiao){
      //已经购买这注彩票
      console.log('已经购买 '+ current_city_no + ' 号城市第 ' + _last_no + ' 期彩票！开始兑奖……');
      if(_this_caipiao['award']){
        //已经兑奖
        return null;
      }else{
        //未兑奖，第一次兑奖
        _this_caipiao['award'] = true;
        var _is_win_var = _last_nums.indexOf(_this_caipiao['num']);
        var _is_win = (_is_win_var != -1);

        if(_is_win){
          //中奖
          console.log('恭喜，已经中奖！');
          //购买新彩票
          _new_caipiao = generateNewCaipiao(current_city_no, _new_no);
        }else{
          //未中奖
          console.log('很遗憾，未中奖！');
          // _new_caipiao = generateTrackCaipiao(_new_no, _this_caipiao);
          //购买跟单彩票
        }
      }
    }else{
      //没有购买这注彩票
      //购买新彩票
      _new_caipiao = generateNewCaipiao(current_city_no, _new_no);
    }



    if(_new_caipiao && _new_caipiao['num'] && _new_caipiao['times'] && _new_caipiao['city_no'] && _new_caipiao['no']){
      //彩票数据格式合规

      // console.log(getBetValue(_new_caipiao));
      fireCaiPiaoEvent('bet', _new_caipiao, function(data){
          if(data['c']=='100'){
            //购买成功
            _new_caipiao['is_bought'] = true;
          }
      });
    }else{
      //彩票不合规或者没有
      console.log(_new_caipiao);
    }
  });
}

/*
  core frameWork
*/


var is_plugin = true;
var url_text;
var submit_btn;
var valueText;

var autoPlay;

var min_lost = 9; //最小遗漏数
var max_lost = 14; //最大遗漏数
var base_time;  //基础倍数

var unit;

var custom_time = 3;  //自定义倍数，n就是所有出来再乘以n倍

if(is_plugin){
  //mac postman plugin;
  url_text = $('#url');
  submit_btn = $('#submit-request');
  valueText = $($('.keyvalueeditor-value-text')[2]);
}else{
  //postman client
  var url_text = $('#url');
  var submit_btn = $('#submit-request');
  var valueText = $($('.keyvalueeditor-value-text')[2]);  
}



var base_url = "http://cbot5.cbin777.com:8088";

//请求
var requests = {
  'getMoney' : {'url' : base_url+'/z/mem-m'},
  'getResult' : {'url' : base_url+'/z/00', 'b' : getLastAwardResult},
  'bet' : {'url' : base_url+'/z/o-trans', 'b' : getBetValue}
}

var bet_rate = '4.27';


var first_at;
var _tempDate = new Date();

var first_at_str = ''+_tempDate.getUTCFullYear()+'-'+_tempDate.getUTCMonth()+'-'+_tempDate.getUTCDay()+' 09:00:00';

first_at = new Date(first_at_str).getTime();


//获取新彩票 传入参数值
function getBetValue(caipiao){

  var _times = caipiao['times'];
  var _recommend_num = caipiao['num'];
  var _no = caipiao['no'];
  var _city_no = caipiao['city_no'];

  var model = '3016';

  _times = _times * custom_time;

  var string_value = _city_no+"%0%1%1%"+_no+",1%"+model+"^"+bet_rate+"^"+_recommend_num+"^"+_times+"^1^"+unit+"^0";
  console.log(string_value);
  return string_value
}

function getLastAwardResult(_city_no){

  var time = new Date();
  var this_time_str_value = time.getTime();   
  return first_at.toString()+','+this_time_str_value+','+_city_no+",1440635075"
}


function fireCaiPiaoEvent(key, data, callback){
  resultJsonData = null;
  var request = requests[key];
  url_text.val(request['url']);
  if(request['b']){
    value = request['b'](data);
    valueText.val(value);
  }

  submit_btn.click();

  setTimeout(function(){
    try{
      resultJsonData = getRequestJsonResult();
      callback(resultJsonData);
    }catch(error){
      console.log(error);
      console.log('返回数据错误……');
    }
  }, 7000);
}

function getRequestJsonResult(){

  var valueData;
  var valueDataStr;
  if(is_plugin){
    var resultPre = $($('div .CodeMirror-lines div pre').last());
    valueDataStr = resultPre.html();
  }else{
    //postman client
    valueDataStr = $(document.getElementById('previewIframe').contentWindow.document.body).html();
  }

  valueData = JSON.parse(valueDataStr);
  console.log(valueData);
  return valueData;
}

function initMoney(){
  console.log('----初始化资金和倍率----');
  fireCaiPiaoEvent('getMoney', null, function(data){
    money = parseFloat(data[1]);
    console.log('初始资金为:'+ money);
    var _total = 0;
    for(var i=(min_lost+1);i<15;i++){
      _total = _total + parseInt(bet_times[i.toString()]);
    }
    console.log('总倍数为：'+_total+' ,所需金额最小为：'+_total*2);
    base_time = money/(_total*2)
    console.log('基础倍率为：'+ base_time);
    //切换单位
    if(base_time < 0.1){
      //改单位
      unit = 3; //分
    }else{
      if(base_time < 1){
        unit = 2; //角
      }else{
        unit = 1; //元
      }
    }

    console.log('----初始化完毕----投注单位已设为：'+unit);
    console.log('----程序即将自动执行----');
  });
}

//推送金额到服务器
function pushMoney(){
  fireCaiPiaoEvent('getMoney', null, function(data){
    $.post('http://ssda.cc/api/caipiao/my_money', {'strValue' : data}, function(_data){
      if(_data){
        console.log('金额推送成功！');
      }
    })
  });
}

//client
initMoney();
mainWorkFlow();
autoPlay = setInterval(mainWorkFlow, 1000*60*1);