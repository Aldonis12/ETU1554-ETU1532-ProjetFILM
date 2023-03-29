<%@ page import="com.example.film.model.Plateau" %>
<%@ page import="com.example.film.model.Disponibilite" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%Plateau plateau = (Plateau)request.getAttribute("plateau");%>
<%List<Disponibilite> dispo = (List<Disponibilite>)request.getAttribute("disponible");%>
<!doctype html>
<html lang="en">
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        </ul>
    </div>
</div>
<div class="wrapper">
    <div class="main-panel">
        <div class="content">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-12">
                        <div class="card card-plain">
                            <h4 class="title">Liste des plateaux non disponibles</h4>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover">
                                    <thead>
                                    <th>Plateau</th>
                                    <th>Scene</th>
                                    <th>Dates</th>
                                    </thead>
                                    <tbody>
                                    <%for(Disponibilite d:dispo){%>
                                    <tr>
                                        <td><%=plateau.getNomPlateau()%></td>
                                        <td><%=d.getScene().getNomScene()%></td>
                                        <td><%=d.getDates()%></td>
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