<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>2019年年会送祝福</title>
    <link rel="stylesheet" href="<%=path %>/css/sendBlessing/sendBlessing.css"/>
    <script type="text/javascript" src="<%=path %>/user/getRandomUser/jquery-1.8.0.js.js"></script>
</head>
<body >
    <div class="container">
        <div class="nameBox">
            <div class="name" id="name"></div>
            <div class="dep" id="dep"></div>
        </div>
        <div class="blessings" id="blessings"><span class="zwf"></span> </div>
        
    </div>
    <!-- <div class="start" id="btntxt" onclick="start()">开始</div> -->

</body>
<script type="text/javascript">
	var gameNum= new Array();
	var xinm = new Array();
	var department = new Array();
	var blessings = new Array();
	var videoQuestion = JSON.parse('${luckUserList}');
	
	for(var i=0;i<videoQuestion.length;i++){
		gameNum[i]=videoQuestion[i].gameNum;
		xinm[i]=videoQuestion[i].name;
		department[i]=videoQuestion[i].department;
		blessings[i]=videoQuestion[i].blessings;
		console.log(xinm[i]);
	}
	var nametxt = $('#name');
	var deptxt = $('#dep');
	var blessingstxt = $('#blessings');
	var comcount = xinm.length-1;//参加人数
	var runing = true;
	var td = 20;//内定中奖,从最小奖开始，共10个名额
	var num = 0;
	var t;
	
	//开始停止
  	document.onkeydown =  function start(e) {
		//alert("开始摇奖");
		if(td==0){
			alert("已超过规定抽取数目！");
			return false;
		}else{
			var ev = document.all ? window.event : e;
			if(ev.keyCode==32) {
				//alert("按下spacebar");
				if (runing) {
				//start();
				$('#name').html("");
				$('#blessings').html("").append("<span class='zwf'></span>");
				$('#dep').html("");
				runing = false;
				startNum()
				}
			}
			if(ev.keyCode==13) {
				//alert("按下enter");
				if (!runing) {
				runing = true;
				stop();
				zd();
			    }
			   }
			}
		} 
	
/*  	function start() {
		if(td==0){
			alert("已超过规定抽取数目！");
			return false;
		}else{
			if (runing) {
				$('#blessings').html("");
				$('#dep').html("");
				runing = false;
				$('#btntxt').removeClass('start').addClass('stop');
				$('#btntxt').html('停止');
				startNum()
			} else {
				runing = true;
				$('#btntxt').removeClass('stop').addClass('start');
				$('#btntxt').html('开始');
				stop();
				zd();
			}
		}
	} */
	//循环参加名单
	function startNum() {
		num = Math.floor(Math.random() * comcount);
		nametxt.html(xinm[num]);
		deptxt.html(department[num]);
		//blessingstxt.append(blessings[num]);
		blessingstxt.html("").append("<span class='zwf'></span>")
		blessingstxt.append(blessings[num]);
		t = setTimeout(startNum, 30);
	}
	//停止跳动
	function stop() {
		clearTimeout(t);
		comcount = xinm.length-1;
	}
	//从一等奖开始指定前3名
	function zd() {
		//打印中奖者名单
		//$('#blessings').prepend(blessings[num]);
		//$('.dep').prepend("<p>姓名："+xinm[num]+"</p>");
		//$('#dep').prepend(department[num]);
		//将已中奖者从数组中"删除",防止二次中奖
		gameNum.splice(num, 1);
		xinm.splice(num, 1);
		department.splice(num, 1);
		blessings.splice(num, 1);
		td = td - 1;
	} 

	</script>
</html>