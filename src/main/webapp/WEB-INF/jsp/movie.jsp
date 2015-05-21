<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<link rel="stylesheet" type="text/css" href="../css/movieweb.css">
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
</style>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="../js/movieweb.js"></script>
<script type="text/javascript">
	$(function (){
		useLoadingSpinner();
		buttonAndEnterFiresFunction("#searchbutton", "#searchfield", searchMovies);
		$("#savebutton").click(saveMovie);
		$("#savebutton").css("display", "none");
	});
	function searchMovies(){
		var q = $("#searchfield").val();
		$.getJSON("${searchUrl}?q="+q, showSearchResult);
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
		});
		<c:if test="${type=='external'}">
			$("#savebutton").css("display", "block");
			$("#movieId").val(movieId);
		</c:if>
	}
	function saveMovie(){
		var id = $("#movieId").val();
		$.post("${saveMovieUrl}?id="+id)
		.done(function() {
    		$("#saveresult").removeClass().addClass("res_ok").text("Save success!");
  		})
  		.fail(function() {
  			$("#saveresult").removeClass().addClass("res_fail").text("Save failed!");
  		});
	}
	function clear(){
		$("#infobox").empty();
		$("#listbox").empty();
		$("#savebutton").css("display", "none");
		$("#saveresult").empty();
	}
</script>
</head>
<body>
	<div id="container">
		<div id="searchbox">
			<input type="text" id="searchfield" /> <button id="searchbutton">Search</button>
			<button id="savebutton">Save</button>
			<span id="saveresult"></span>
		</div>
		<div id="infobox">		
		</div>
		<div id="listbox">		
		</div>
		<input type="hidden" id="movieId">
	</div>
</body>
</html>