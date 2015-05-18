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
</style>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="http://cdn.sockjs.org/sockjs-0.3.4.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<script type="text/javascript">
	$(function start(){
		$("#searchbutton").click(searchMovies);
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
			$("<h1 />",{
				text : "Movie: "+movie.originalTitle
			}).appendTo("#infobox");
			
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
			
			$.each(movie.castAndCrew, function(i, castAndCrewMember){
				$("<tr/>",{
					id: "movrow"+castAndCrewMember.id
				}).appendTo("table");
				
				
				$("#movrow"+castAndCrewMember.id)
					.append($("<td/>",{
						text : castAndCrewMember.role
					}))
					.append($("<td/>",{
						text : castAndCrewMember.firstName+" "+castAndCrewMember.lastName
					}));
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