<%@ page import="com.example.film.model.Scene" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.film.model.FilmValider" %><%--
  Created by IntelliJ IDEA.
  User: mickl
  Date: 28/03/2023
  Time: 23:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<FilmValider> scene = (List<FilmValider>)request.getAttribute("liste");%>
<!doctype html>
<html lang="en">
<body>
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
                <a href="<%= request.getContextPath() %>/pagination?numero=1">
                    <i class="ti-view-list"></i>
                    <p>Voir la liste</p>
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
<div class="wrapper">
    <div class="main-panel">
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                <h4>Les scènes planifiées</h4>
                    <div class="col-md-12">
                        <div class="card card-plain">
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover">
                                    <thead>
                                    <th>Nom scene</th>
                                    <th>Date</th>
                                    </thead>
                                    <tbody>
                                    <%for(FilmValider s:scene){%>
                                    <tr>
                                        <td><%=s.getScene().getNomScene()%></td>
                                        <td><%=s.getDaty()%></td>
                                    </tr>
                                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
</body>
</html>
