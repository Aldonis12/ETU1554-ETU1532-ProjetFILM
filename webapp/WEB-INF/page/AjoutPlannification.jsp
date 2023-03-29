<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List,com.example.film.model.*"%>
<%Film film = (Film)request.getAttribute("film");%>
<%List<Scene> scene = (List<Scene>)request.getAttribute("scene");%>

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
                    <div class="col-md-12">
                        <div class="card card-plain">
                            <h4 class="title">Planifier le film : <%=film.getFilm()%></h4>
                            <p class="category">Checker au moins une scène</p>
                        </div>
                    </div>
                <form action="<%= request.getContextPath()%>/ReponsePlannification" method="GET">
                    <div class="row">
                        <div class="col-md-5">
                            <div class="form-group">
                                <label>Date Debut</label>
                                <input rows="2" type="date" name="debut" class="form-control border-input">
                            </div>
                            <div class="form-group">
                                <label>Date Fin</label>
                                <input rows="2" type="date" name="fin" class="form-control border-input">
                            </div>
                        </div>
                        <input type="hidden" name="id" value="<%=film.getId()%>">
                    </div>

                    <div class="content table-responsive table-full-width">
                        <table class="table table-hover">
                            <thead>
                            <th>CHECK</th>
                            <th>Nom scene</th>
                            <th>Auteur</th>
                            <th>Plateau</th>
                            <th>Debut</th>
                            <th>duree</th>
                            </thead>
                            <tbody>
                            <%for(Scene s:scene){%>
                            <tr>
                                <td><input type="checkbox" name="scene" value="<%=s.getId() %>"></td>
                                <td><%=s.getNomScene()%></td>
                                <td><%=s.getAuteur()%></td>
                                <td><%=s.getPlateau().getNomPlateau()%></td>
                                <td><%=s.getDebut()%></td>
                                <td><%=s.getFin()%></td>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>


                    <br>
                    <div class="text-center">
                        <button type="submit" class="btn btn-info btn-fill btn-wd">Voir</button>
                    </div>
                    <div class="clearfix"></div>
                </form>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
</body>
</html>