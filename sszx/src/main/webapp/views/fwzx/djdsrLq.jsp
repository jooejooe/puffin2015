<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>接收材料</title>
<jsp:include page="/common/include.jsp" />
</head>

<%
String fydm=(String)session.getAttribute("fydm");
%>
<body style="background-color: #fff;" class="easyui-layout">

	<div data-options="region:'center'">
    <table id="dsrZzSjTable"></table> 
    </div>

    <div id="search" style="width:250px;">
    <table style="font-size:12px;"><tr><td>
    <span>当事人：</span></td><td><input type="text"  id="djr" name="djr"/></td></tr>
    <tr><td><span>案号：</span></td><td><input type="text"  id="ah" name="ah"/></td></tr>
    </table>
    </div>
    
    
   
<script>
$(document).ready(function(){
	 var user="${session.user}";
     //var user="Chenl";
	 var fydm='<%=fydm%>';

	 $('#search').dialog('close');
	 //$('#add_xinming').hide();
	 
	 $('#dsrZzSjTable').datagrid({
			rownumbers:false,
			fit:true,
			border:false,
			title:'登记当事人领取材料',
			singleSelect:true,
			striped:true,
			fitColumns:true,
			singleSelect:true,
			idField:'itemid',
			pagination:true,
			url:"${path}/djdsrLqTable.do?user="+user+"&fydm="+fydm,
			
			columns:[[
		    {field:'id',title:'流水号',width:50,align:'center',
		    	 formatter:function(id){
						return id.bh;
			}},
			{field:'ah',title:'案号',width:200,align:'center'},
			{field:'sjrBmmc',title:'承办部门',width:100,align:'center'},
			{field:'sjrXm',title:'承办人',width:50,align:'center'},
		    {field:'djr',title:'当事人',width:50,align:'center'},
		    {field:'djrq',title:'递交日期',width:100,align:'center'},	
		    {field:'action',title:'操作',width:150,align:'center',
				   formatter:function(value,row,index){
					var sa=row.id.bh;
					var s = ' <a style="color:red\"'
					        +'href=\"djdsrLqJs.do?bh='+sa+'\">确认/退回</a> ';
			        var e = ' <a style="color:red\"'
				        +'href=\"#\" '
				        +'onClick=\"Word('
				        +sa+');">表单</a> ';
					return e+s;
					}
		    }
			]],
			
			toolbar:[	        
			        {text:'查询',
			        iconCls:'icon-search',
			        handler:function(){
			        	$('#djr').val('');
						$('#ah').val('');
			        	$('#search').dialog('open');
			        }},
			        
			        {text:'所有任务',
			        iconCls:'icon-reload',
			        id:'allCL'}
			    ],
			    
		     pagination:true,
			 sortName:'ah',
			 sortOrder:'desc'     
			});

	 $('#allCL').click(function(event){
		$('#dsrZzSjTable').datagrid('reload');
		 //window.location.href="djywZj.jsp";
		 //event.preventDefault();//ie6专用
	 });
	 }	 
);
</script>

<script>
$('#search').dialog({
    title:'搜索',
    iconCls:'icon-search',
    buttons:[{
        text:'搜索',
        iconCls:'icon-ok',
        handler:function(){
        	 //alert($('#add_xinming').val());
        	 $.ajax({
        	     url:'searchDjyw.do',
        	     type:'POST',
        	     data:{djr:encodeURI(encodeURI($('#djr').val())),
        	    	   ah:encodeURI(encodeURI($('#ah').val())),
        	    	   zt:7
        	      },//注意大小写data
        	     dataType:'json',
        	     success:function (res) {
        	       $('#dsrZzSjTable').datagrid('loadData',res.data);
        	       $('#search').dialog('close');
        	     }
        });
        }
    },{
        text:'取消',
        iconCls:'icon-cancel',
        handler:function(){
            $('#search').dialog('close');
        }
    }]
});

function Word(bh){
	 url='word.do?bh='+bh;
	 window.open(url,"new",
			 "height=600px,width=650px,toolbar=no,status=no,menubar=no,scrollbars=yes,resizable=yes");
	
}
</script>


</body>
</html>