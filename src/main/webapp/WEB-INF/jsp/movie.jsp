<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Movies</title>
<spring:url value="/movie/search" var="searchUrl" />
<spring:url value="/movie/get" var="getMovieUrl" />
<style type="text/css">
th{
	 text-align: left;
}
table{
	width: 15%;
}
</style>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script type="text/javascript">
	$(document).ready(start);
	function start(){
		$("#searchbutton").click(searchMovies);
	}
	function searchMovies(){
		var q = $("#searchfield").val();
		$.getJSON("${searchUrl}?q="+q, showSearchResult);
	}
	function showSearchResult(result){
		clear();
		$("#listbox").append("<span>Movies</span>");
		$("#listbox").append("<ul></ul>");
		$.each(result.list, function(i, movie){
            $("ul").append("<li id='"+movie.id+"'>"+movie.originalTitle+"</li>");
        });
		$("#listbox li").click(function() {
			showMovie(this.id);
		});
	}
	function showMovie(movieId){
		clear();
		$.getJSON("${getMovieUrl}?id="+movieId, function(movie){
			$("#infobox").append("<span>Movie: "+movie.originalTitle+"</span>");
			$("#listbox").append("<span>Cast and Crew</span>");
			$("#listbox").append("<table><th>Role</th><th>Name</th></table>");
			$.each(movie.castAndCrew, function(i, castAndCrewMember){
				$("table").append("<tr><td>"+castAndCrewMember.role+"</td><td>"+castAndCrewMember.firstName+" "+castAndCrewMember.lastName+"</td></tr>");
	        });
		});
	}
	function clear(){
		$("#infobox").empty();
		$("#listbox").empty();
	}
</script>
</head>
<body>
	<div id="container">
		<div id="searchbox">
			<input type="text" id="searchfield" /> <button id="searchbutton">Search</button>	
		</div>
		<div id="infobox">		
		</div>
		<div id="listbox">		
		</div>
	</div>
</body>
</html>