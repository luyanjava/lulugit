<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
    <title>送祝福</title>
    <script type="text/javascript" src="<%=path %>/js/jquery-plugins/layui/layui.all.js"></script>
	<script type="text/javascript" src="<%=path %>/user/getRandomQuestion/jquery-1.8.0.js.js"></script>
    <link rel="stylesheet" href="<%=path %>/css/sendBlessing/wxui.css"/>
    <link rel="stylesheet" href="<%=path %>/css/sendBlessing/eidtBlessing.css"/>
</head>
<body>
<header class="demos-header"><h1 class="demos-title yellow">祝福卡</h1></header>
<form action="" id="form1" name=""  method="post">
<div class="weui-cells weui-cells_form eidtBlessing">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label yellow"><span>*</span>录入人电话:</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input"  name="phonenum" id="phonenum" onblur="javascript:phoneNumCheck(this)">
        </div>
        <div id="phoneNumberHint"></div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label yellow"><span>*</span>被祝福人:</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" type="text"  id="name" name="name"  onblur="javascript:nameCheckLocal(this)">
        </div>
        <div id="nameHint"></div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label yellow"><span>*</span>被祝福部门:</label>
        </div>
        <div class="weui-cell__bd">
            <select class="weui-select" name="department" id="department"></select>
        </div>
        <div id="departmentHint"></div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label yellow"><span>*</span>祝福语:</label>
        </div>

    </div>
    <div class="weui-cells weui-cells_form blessing">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <textarea rows="3"  class="weui-textarea"
					id="blessing" name="blessing" maxlength="72" value=""
                    onkeyup="this.value=this.value.substring(0, 72)"
                    placeholder="此处填写，最多可输入72字"></textarea>               
                <div class="weui-textarea-counter yellow"><span id="text-count" value="">0</span>/72</div>
            </div>
        </div>
        <div id="blessingHint"></div>
    </div>
</div>
<div class="btnBox">
    <input type="button" class="weui-btn weui-btn_primary" value="保存" id="add_user" onclick="addmessage()" /> 
    <!-- <input type="button" class="weui-btn weui-btn_primary" value="取消"  onclick="formReset();"/> -->
    
</div>
</form>

<script type="text/javascript">
	var checkNameLocal = null;
	var checkPhoneLocal = null;
	$(document).ready(function(){
		var json = JSON.parse('${departmentList}');
		$("#department").html("");
		$("#department").append('<option value ="">所有部门▼</option>');
			if ("" != json && json!=null && json.length>0) {
				for(var i=0;i<json.length;i++){
   					$("#department").append('<option value ="'+json[i].department+'">'+json[i].department+'</option>');
   			}
		}
	});
	        
	$('#blessing').keyup(function() {
        var len=this.value.length
        $('#text-count').text(len);

        })
	
        function phoneNumCheck() {
        	var obj = document.getElementById("phonenum");
        	//alert("obj="+obj);
        	var reg = /^((1[3,5,8][0-9])|(14[5,7])|(17[0,3,6,7,8])|(16[6])|(19[7]))\d{8}$/;
        	if (obj.value == "") {
        		phoneNumberHint.innerHTML = "<i  class='icon-info-sign'></i><font class='font1'> ×请输入手机号</font>";
        		checkPhoneLocal = false;
        	} else if (!reg.test(obj.value)) {
        		phoneNumberHint.innerHTML = "<i  class='icon-info-sign'></i><font class='font1'> ×手机号码格式错误</font>";
        		checkPhoneLocal = false;
        	} else {
        		var pn = $("#phonenum").val();     		
                var url = "<%=path%>/admin/checkphonenum.do";
                $.ajax({
                    type : "post",
                    url : url,
                    data : {
                    	phonenum : pn
                    },
                    success : function(msg) {
                        if (msg == false) {
                        	phoneNumberHint.innerHTML = "<font class='dialogbox_tip_wrong'><i  class='icon-info-sign'></i>　×不是预留的手机号码</font>";
                        	checkPhoneLocal = false;
                        } else {
                        	phoneNumberHint.innerHTML = "<font class='dialogbox_tip_right'> √可用</font>";
                        	checkPhoneLocal = true;
                        }
                    }
                });
        	}
        }
        
        function nameCheckLocal() {
            var obj = $("#name").val();
            if (obj.length == 0) {
            	nameHint.innerHTML = "<font class='dialogbox_tip_wrong'><i  class='icon-info-sign'></i> ×姓名不能为空</font>";
                checkNameLocal = false;
            }else if (obj.length > 5) {
            	nameHint.innerHTML = "<font class='dialogbox_tip_wrong'><i  class='icon-info-sign'></i> ×姓名不能超过5个字</font>";
                checkNameLocal = false;
            }else{
            	nameHint.innerHTML = "<font class='dialogbox_tip_wrong'><i  class='icon-info-sign'></i> √可用</font>";
            	checkNameLocal = true;
            }
        }
        
		function addmessage() {
			//alert("123123123");
			var name = $("#name").val();
			var phonenum = $("#phonenum").val();
			var department = $("#department").val();
			var blessings = $("#blessing").val();		
			 if(!checkPhoneLocal){
				 console.log("checkPhoneLocal="+checkPhoneLocal);
				return false;
			}
			 if(!checkNameLocal){
					console.log("checkNameLocal="+checkNameLocal);
					return false;
				}
			if(department==""){
				departmentHint.innerHTML = "<font class='dialogbox_tip_right'> ×请选择部门</font>";
				return false;
			}
            if(blessings==""){
            	blessingHint.innerHTML = "<font class='dialogbox_tip_right'> ×请填写祝福语</font>";
				return false;
            }
						
            $.ajax({
                type : "post",
                url : "<%=path%>/admin/phonenumifuse.do",
                data : {
                	phonenum : phonenum
                },
                success : function(msg) {
                    if (msg == true) {
                        //layer.alert("您已经参该活动，敬请期待开奖结果！",{icon: 0});
                        layer.msg("抱歉，您已经过参该活动，敬请期待开奖结果！");
                        return;
                    } else {
                        $.ajax({
                            url:"<%=path%>/admin/addmessage.do",
                            type:"post",
                            data:{
                                name : name,
                                phonenum : phonenum,
                                department : department,
                                blessings : blessings
                                
                            },
                            success:function(data){
                                if(data){
                                	layer.msg("添加成功！");
                                }
                            }
                        });
                   }
                }
            }); 

		}		
		function formReset(){
			document.getElementById("form1").reset();
			nameHint.innerHTML = "";
			checkNameLocal = false;
			phoneNumberHint.innerHTML = "";
			checkPhoneLocal = false;
			departmentHint.innerHTML = "";
		}
		
	</script>
</body>
</html>
