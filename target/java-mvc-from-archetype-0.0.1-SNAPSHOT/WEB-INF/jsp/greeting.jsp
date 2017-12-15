<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<title>Spring MVC From Archetype</title>
	</head>
	<body>
		<h1>Hello to</h1>
		<ul>
			<c:forEach items="${persons}" var="person">
				<li>${person.firstName} ${person.lastName}</li>
			</c:forEach>
		</ul>
	</body>
</html>