
   function drawEcharts(url,str){
	 //得到日期
	alert("drawEcharts");
   	var date1=$("#d122").val();	
       var date2=$("#d123").val();	
     	var schoolid=$("#schoolId").val();
    	var companyId=$("#companyId").val();
    	if(date1!=""&& date2!=""){
    		  var arr=[];//存平均成绩
	          var examName=[];//存考试名称
     		$.ajax({
     				type: "post",
     				url: url,
     				data: {date1: date1,date2:date2,schoolId:schoolid,companyId:companyId},
     				dataType : "json", //返回数据形式为json
     				success: function(exam){
     						
     						 examName = exam[0];
     						arr = exam[1];
     						alert("examName="+examName);
     						alert("arr="+arr);
     				if(examName!="") {
    		// 路径配置
    		require.config({
    				paths : {
    					echarts : 'js/dist'
    				}
    			});
    			// 使用
    			require(['echarts','echarts/chart/line','echarts/chart/bar'],// 使用柱状图就加载bar模块，按需加载
    					function (ec){
    	   	     // 基于准备好的dom，初始化echarts图表
    	 	var myChart;  
    	   	      
    	        myChart = ec.init(document.getElementById('maincharts')); 
    	      var option = {
    	   		    title : {
    	   		        text: exam[2],
    	   		        subtext: '数据分析',
    	   		        	 x:'center'
    	   		    },
    	   		    tooltip : {
    	   		     trigger: 'item',
    	   	        formatter: "{b} <br/> {a}: {c} ({d}"+str+")"
    	   		    },
    	   		    legend: {
    	   		        data:[exam[3]],
    	   		    x:'left'
    	   		    },
    	   		    toolbox: {
    	   		        show : true,
    	   		        feature : {
    	   		            mark : {show: true},
    	   		            dataView : {show: true, readOnly: false},
    	   		            magicType : {show: true, type: ['line', 'bar']},
    	   		            restore : {show: true},
    	   		            saveAsImage : {show: true}
    	   		        }
    	   		    },
    	   		
               
    	   		    calculable : true,
    	   		    xAxis : [
    	   		        {
    	   		            type : 'category',
    	   		            boundaryGap : false,
    	   		            data :(function(){
    	  		            	 return examName;
    	  		         	          })() ,
    	   		            axisLabel:{
    	   		            	rotate:15, //刻度旋转45度角
    	   		            	textStyle:{
    	   		            	color:"red",
    	   		            	fontSize:12
    	   		            	
    	   		            	}
    	   		            	}
    	   		        }
    	   		    ],
    	   		    yAxis : [
    	   		        {
    	   		            type : 'value',
    	   		            axisLabel : {
    	   		                formatter: '{value}'+str,
    	   		            }
    	   		        }
    	   		    ],
    	   		    series : [
    	   		        {
    	   		         itemStyle: {
    	   	                 normal: {
    	   	                     label: {
    	   	                         show: true,
    	   	                         textStyle: {
    	   	                             color: '#800080'   
    	   	                         }
    	   	                     }
    	   	                 }
    	   	             },
    	   		            name:exam[3],
    	   		            type:'line',
    	   		            data:(function(){
    	   		          	 
    	   		            	 return arr;
    	   		         	     })(),
    	   		         	  
    	   		        
    	   		        }
    	   		    ]
    	   		};
    	   		                    
    	  // 为echarts对象加载数据 
    	  myChart.setOption(option); }
    			);
    	  
     				}else{
     			
     					  art.dialog({
     	    				  top: '60%',
     	    				    content: '请重新选择部门或日期，此期间无考试！'
     	    				});
     				}
     				
     				},
     		 		
     		 		error : function(errorMsg) {
                    // alert("不好意思，图表请求数据失败啦!");
                      art.dialog({
        				  top: '60%',
        				    content: '不好意思，图表请求数据失败啦!'
        				});
                      myChart.hideLoading();
                  }
     			});
	            	
    	
    	}else{
    		  art.dialog({
 				  top: '60%',
 				    content: '请选择日期！'
 				});
 
    	}
    	
	   
   }

