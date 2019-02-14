
$(document).ready(function(){
	//menu的高度获取

	$("#liu-content").height($(document).height() - "78");
	$(".liu-content").height($(document).height() - "128");
	

	// 表单样式控制
	$(".liu-uredit .edit1 li:nth-child(2n+1)").addClass('name');

	//用户列表按钮控制
	$("#caozuo li").hover(function(){
		$(this).find('.caozuo').show();
	},function(){
		$(this).find('.caozuo').hide();
	});
});

//左侧菜单
$(function() {
	var Accordion = function(el, multiple) {
		this.el = el || {};
		this.multiple = multiple || false;

		// Variables privadas
		var links = this.el.find('.liu-link');
		// Evento
		links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown);
	};

	Accordion.prototype.dropdown = function(e) {
		var $el = e.data.el;
			$this = $(this),
			$next = $this.next();

		$next.slideToggle();
		$this.parent().toggleClass('liu-open');

		if (!e.data.multiple) {
			$el.find('.liu-submenu').not($next).slideUp().parent().removeClass('liu-open');
		};
	};	

	var accordion = new Accordion($('#liu-accordion'), false);
});





//选择用户 全选功能
$(function () {  
	//全选  
	$("#selectAll").click(function () {
		$(".demo-table .table :checkbox").attr("checked", true);  
	});  

	//全不选
	$("#unSelect").click(function () {  
		$(".demo-table .table :checkbox").attr("checked", false);  
	});  

	//反选  
	$("#reverse").click(function () {
		$(".demo-table .table :checkbox").each(function () {  
			$(this).attr("checked", !$(this).attr("checked"));  
		});  
	});  
});

// <div class="div_red01" id="divlia_'+n+'">新添加的DIV</div>
//动态生成试题
  

