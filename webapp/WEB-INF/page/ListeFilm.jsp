<%@ page import="java.util.List" %>
<%@ page import="com.example.film.model.Film" %>
<%--
  Created by IntelliJ IDEA.
  User: mickl
  Date: 28/01/2023
  Time: 00:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<body>
<jsp:include page="lien.jsp"/>
<div class="sidebar" data-background-color="white" data-active-color="danger">
  <div class="sidebar-wrapper">
    <div class="logo">
      <a class="simple-text">
        F I L M
      </a>
    </div>
    <ul class="nav">
      <li>
        <a href="<%= request.getContextPath() %>/AddFilm">
          <i class="ti-plus"></i>
          <p>Créer un film</p>
        </a>
      </li>
      <li>
        <a href="<%= request.getContextPath() %>/DetailsIndisponibilite">
          <i class="ti-line-dashed"></i>
          <p>Indisponiblité</p>
        </a>
      </li>
    </ul>
  </div>
</div>
<%
  List<Film> valider = (List<Film>) request.getAttribute("liste");
  String vide ="";

  int size = 8;
  int y = 1;
  int i = valider.size();
  if (i<=size){
    y=y;
  } else if (i>size && i<=size*2) {
    y=y+1;
  } else if (i>size*2 && i<=size*4) {
    y=y+2;
  }

%>
<div class="wrapper">
  <div class="main-panel">
    <div class="content">
      <div class="container-fluid">
        <div class="row justify-content-around custom-line">
          <h1>Les films inventés</h1>
          <br>

          <% for(Film ar : valider) { %>
          <a href="<%=request.getContextPath()%>/ListScene?id=<%=ar.getId()%>&div=1">
          <div class="col-lg-3 col-md-2">
            <div class="card card-user">
              <div class="image">
                <img src="${pageContext.request.contextPath}/images/<%= ar.getImage()%>" alt="..."/>
              </div>
              <div class="content">
                <div class="author">
                  <br>
                  <br>
                  <br>
                  <br>
                </div>
                <p>
                  <hr>
                  Titre : <strong style="color:black"><%= ar.getFilm() %></strong>
                  <hr>
                  Createur : <strong><%= ar.getAuteur() %></strong>
                  <hr>
                  <br>
                <a href="<%=request.getContextPath()%>/ListeAPlannifier?id=<%=ar.getId()%>">   Planifier </a>
                <br>
                <br>
                <a href="<%= request.getContextPath() %>/ScenePlanifie?id=<%= ar.getId()%>">SCENES planifiés</a>
                </p>
              </div>
            </div>
          </div>
          </a>
          <% } %>
        </div>
      </div>
    </div>

    <nav aria-label="Page navigation example">
      <ul class="pagination">
        <% for (int x=1; x<y; x++) { %>
        <li class="page-item"><a class="page-link" href="<%= request.getContextPath() %>/pagination?numero=<%=(i)%>"><%=i%></a></li>
        <% } %>
      </ul>
    </nav>



    <jsp:include page="footer.jsp"/>
  </div>
</div>
</body>
</html>