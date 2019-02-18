/**
 * 添加试题 弹出层切换
 */
$('[data-toggle="modal"]').click(function() {
	var target = $(this).data('target');
	var node = $('#tg').treegrid('getSelected');
	if (node) {
		var courseId = document.getElementById('courseId').value;
		var chapterId = "";
		var level=0;
		if (node.level > 0) {
			chapterId = node.id;
			level=node.level;
		}
		$.ajax({
			data : {
				courseId : courseId,
				chapterId : chapterId,
				level : level,
				courseType : courseType,
				examType : examType
			},
			dataType : 'json',
			type : 'post',
			url : path + '/admin/paper/find_question_exbihition.do',
			success : function(msg) {
				var singleSelection = $("#singleSelection td");
				singleSelection.eq(0).text(msg['singleSelection'][0]);
				singleSelection.eq(1).text(msg['singleSelection'][1]);
				singleSelection.eq(2).text(msg['singleSelection'][2]);

				var judge = $("#judge td");
				judge.eq(0).text(msg['judge'][0]);
				judge.eq(1).text(msg['judge'][1]);
				judge.eq(2).text(msg['judge'][2]);

				var multiSelect = $("#multiSelect td");
				multiSelect.eq(0).text(msg['multiSelect'][0]);
				multiSelect.eq(1).text(msg['multiSelect'][1]);
				multiSelect.eq(2).text(msg['multiSelect'][2]);

				var blank = $("#blank td");
				blank.eq(0).text(msg['blank'][0]);
				blank.eq(1).text(msg['blank'][1]);
				blank.eq(2).text(msg['blank'][2]);

				var shortAnswer = $("#shortAnswer td");
				shortAnswer.eq(0).text(msg['shortAnswer'][0]);
				shortAnswer.eq(1).text(msg['shortAnswer'][1]);
				shortAnswer.eq(2).text(msg['shortAnswer'][2]);

				var realPractice = $("#realPractice td");
				realPractice.eq(0).text(msg['realPractice'][0]);
				realPractice.eq(1).text(msg['realPractice'][1]);
				realPractice.eq(2).text(msg['realPractice'][2]);

				var reportForm = $("#reportForm td");
				reportForm.eq(0).text(msg['reportForm'][0]);
				reportForm.eq(1).text(msg['reportForm'][1]);
				reportForm.eq(2).text(msg['reportForm'][2]);
			}
		});
	}
	$(target).show();
});

$('[data-dismiss="modal"]').click(function() {
	var target = $(this).data('target') || $(this).parents('.dec26-modal');
	$(target).hide();
	dialog_hide();
});