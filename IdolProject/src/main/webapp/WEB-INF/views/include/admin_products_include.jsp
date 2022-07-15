<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!-- calendar -->
<script src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


<style type="text/css">

	/*********** celeb_link_tag  **************/
	.celeb_link_tag {
		color: white;
		font-family: 'Press Start 2P', cursive;
		display: flex;
		flex-direction: row;
		/*border: 1px solid white;*/
		justify-content: end;
    	margin-right: 4.5%;
   	 	align-items: center;
   	 	padding-bottom: 20px;
	}	
	
	.search_text {
		height: 23px;
    	width: 213px;
    	background-color: black;
    	color: white;
    	font-size: 1.5em;
    	font-family: 'Creepster','Kirang Haerang', cursive;
    	
	}
	
	.search_btn {
		padding: 0px 18px;
		color: white;
		background-color: black;
		font-family: 'Press Start 2P', cursive;
		font-size: 1em;
	}
	
	.insert_btn a {
		color: white;
		text-decoration: none;
	}
	.search_btn:hover {
		color: red;
		cursor: pointer;
	}
	
	.insert_btn a:hover {
		color: red;
		cursor: pointer;
	}
	
	.insert {
		padding-left: 18px;
	}
	
  	/*********** celeb_link_tag **************/

	.calendar {
		margin-right: 20px;
	}
	
	.calendar_btn {
		color: white;
    	background-color: black;
    	font-family: 'Press Start 2P', cursive;
    	font-size: 1em;
	}
	
	.calendar_btn:hover {
		color: red;
		cursor: pointer;
	}
	
	.dateRage_selector {
		background-color: black;
	    color: white;
	    height: 23px;

	}
	
	.calendar_btn {
		margin-top: 9px;
	}
	
</style>

<script type="text/javascript">

	$(function() {
		  $('input[name="daterange"]').daterangepicker({
	locale: {
		      "separator": "-",                     // 시작일시와 종료일시 구분자
	      "format": 'YYYY/MM/DD',     // 일시 노출 포맷
	      },
	  
	  ranges: {
	        'Today': [moment(), moment()],
	        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
	        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
	        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
	        'This Month': [moment().startOf('month'), moment().endOf('month')],
	        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
	    },
	    format: 'YYYY-MM-DD',
	    alwaysShowCalendars: true,
	    opens: 'conter'
	  }, function(start, end, label) {
	    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
	  });
	});
	
</script>


</head>
<body>

	<div class="celeb_link_tag">
	
		<div class="insert_btn calendar">
			<form action="<%=request.getContextPath() %>/test_result.do">
				<input class="dateRage_selector" name="daterange">
				<input class="calendar_btn" type="submit" value="GO">
			</form>
		</div>
		<div class="insert_btn">
			<a href="<%=request.getContextPath()%>/admin_products_management.do">
				SALES
			</a>
		</div>
		<div class="insert_btn insert">
			<a href="<%=request.getContextPath()%>/admin_products_insert.do">
				INSERT
			</a>
		</div>
		<form method="post" action="<%=request.getContextPath()%>/admin_products_search.do">
			<input type="submit" class="search_btn" value="SEARCH">
			<input name="group_search" class="search_text" minlength="2">
		</form>
		
	</div>

</body>
</html>