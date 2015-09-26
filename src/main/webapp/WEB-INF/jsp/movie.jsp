<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Movies</title>
<c:choose>
<c:when test="${type=='external'}">
	<spring:url value="/movie/searchext" var="searchUrl" />
	<spring:url value="/movie/getext" var="getMovieUrl" />
	<spring:url value="/movie/save" var="saveMovieUrl" />
</c:when>
<c:otherwise>
	<spring:url value="/movie/search" var="searchUrl" />
	<spring:url value="/movie/get" var="getMovieUrl" />
</c:otherwise>
</c:choose>
<style type="text/css">
table, th, td{
	border: 1px solid green;
	border-collapse: collapse;
}
th, td{
	padding: 3px;
}
th{
	 text-align: left;
	 background-color: green;
     color: white;
}
table{
	width: 25%;
}
.head1{
	color: blue;
	font-family: cursive;
	font-weight: bold;
	font-size: 20px;
}
.result{
	color: red;
}
</style>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="http://cdn.sockjs.org/sockjs-0.3.4.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<script type="text/javascript">
	$(function start(){
		$("#savebutton").click(saveMovie);
		$("#savebutton").css("display", "none");
		$("#loadAnim").css("display", "none");
	});
	function searchMovies(){
		var q = $("#searchfield").val();
		$("#loadAnim").css("display", "block");
		$.getJSON("${searchUrl}?q="+q, showSearchResult)
		.fail(function() {
			$("#actionresult").text("Search error!");
  		})
		.always(function() {
			$("#loadAnim").css("display", "none");
  		});
	}
	
	function showSearchResult(result){
		clear();
		$("<span />",{
			"class" : "head1",
			text : "Movies"
		}).appendTo("#listbox");
		$("<ul />").appendTo("#listbox");
		$.each(result.list, function(i, movie){
			$("<li />",{
				id : movie.id,
				text : movie.originalTitle
			}).appendTo("#listbox ul");
        });
		$("#listbox li").click(function() {
			showMovie(this.id);
		});
	}
	function showMovie(movieId){
		clear();
		$("#loadAnim").css("display", "block");
		$.getJSON("${getMovieUrl}?id="+movieId, function(movie){
			$("<ul />").appendTo("#listbox");
			$.each(movie, function(key, value){
				if (value != null && value.constructor !== Array){
					$("<li />",{
						text : key+": "+value
					}).appendTo("#listbox ul");
				}
			});
			$("<span />",{
				"class" : "head1",
				text : "Cast and Crew"
			}).appendTo("#listbox");
			
			$("<table />").appendTo("#listbox");
			$("<th />",{
				text: "Role"
			}).appendTo("table");
			$("<th />",{
				text: "Name"
			}).appendTo("table");
			
			$.each(movie.workingRoles, function(i, workingRole){
				$("<tr/>",{
					id: "movrow"+i
				}).appendTo("table");
				
				
				$("#movrow"+i)
					.append($("<td/>",{
						text : workingRole.role
					}))
					.append($("<td/>",{
						text : workingRole.person.firstName+" "+workingRole.person.lastName
					}));
	        });
		})
		.done(function() {
			<c:if test="${type=='external'}">
				$("#savebutton").css("display", "block");
				$("#movieId").val(movieId);
			</c:if>
		})
		.fail(function() {
			$("#actionresult").text("Showing movie error!");
  		})
		.always(function() {
			$("#loadAnim").css("display", "none");
  		});
	}
	function saveMovie(){
		var id = $("#movieId").val();
		$.post("${saveMovieUrl}?id="+id)
		.done(function() {
    		$("#actionresult").text("Save success!");
  		})
  		.fail(function() {
  			$("#actionresult").text("Save failed!");
  		});
	}
	function clear(){
		$("#infobox").empty();
		$("#listbox").empty();
		$("#savebutton").css("display", "none");
		$("#actionresult").empty();
	}
</script>
</head>
<body>
	<div id="container">
		<div id="searchbox">
			<form action="javascript:searchMovies();">
				<input type="text" id="searchfield" /> 
				<input type="submit" value="Search"><img id="loadAnim" src="../img/green-spinner.gif" />
			</form>			
			<button id="savebutton">Save</button>
			<span id="actionresult" class="result"></span>
		</div>
		<div id="infobox">		
		</div>
		<div id="listbox">		
		</div>
		<input type="hidden" id="movieId">
	</div>
</body>
</html>