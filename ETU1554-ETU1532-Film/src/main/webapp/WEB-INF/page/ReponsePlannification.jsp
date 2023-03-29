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
                    <div class="card card-plain">
                        <div class="header">
                            <h4 class="title">Planning du film : <%=film.getFilm()%> </h4>
                        </div>
                    <div class="content table-responsive table-full-width">
                        <form action="<%= request.getContextPath() %>/ValidationScene" method="post">
                            <input type="hidden" name="IdFilm" value="<%=film.getId()%>">

                        <table class="table table-hover">
                            <thead>
                            <th>date</th>
                            <th>Nom scene</th>
                            <th>Auteur</th>
                            <th>Plateau</th>
                            <th>Debut</th>
                            <th>duree</th>
                            <th>Validation</th>
                            </thead>
                            <tbody>
                            <%for(Scene s:scene){%>
                            <input type="hidden" name="daty" value="<%=s.getDates().toString() %>">
                            <tr>
                                <td><%=s.getDates().toString() %> <%=s.getDebut()%></td>
                                <td><%=s.getNomScene()%></td>
                                <td><%=s.getAuteur()%></td>
                                <td><%=s.getPlateau().getNomPlateau()%></td>
                                <td><%=s.getDebut()%></td>
                                <td><%=s.getFin()%></td>
                                <td><input type="checkbox" name="scene" value="<%=s.getId() %>"></td>
                            </tr>
                            <%}%>
                            <tr>
                                <td></td><td></td><td></td><td></td><td></td><td></td>
                                <td><button type="submit">Valider</button></td>
                            </tr>

                            </tbody>
                        </table>
                        </form>
                    </div>
                    </div>


                </div>
            </div>
            <form method="get" action="<%= request.getContextPath() %>/Version_pdf">
                <input type="hidden" name="Film" value="<%=film.getFilm()%>">
                <input type="hidden" name="idfilm" value="<%=film.getId()%>">

                <% for (int i=0; i<scene.size();i++) {%>
                <input type="hidden" name="myDate" value="<%=scene.get(i).getDates().toString() %> <%=scene.get(i).getDebut()%>">
                <input type="hidden" name="myArray" value="<%=scene.get(i).getNomScene()%>">
                <input type="hidden" name="myAuteur" value="<%=scene.get(i).getAuteur()%>">
                <input type="hidden" name="myPlateau" value="<%=scene.get(i).getPlateau().getNomPlateau()%>">
                <input type="hidden" name="myDebut" value="<%=scene.get(i).getDebut()%>">
                <input type="hidden" name="myFin" value="<%=scene.get(i).getFin()%>">
                <%}%>
                <input type="submit" value="Version pdf">
            </form>
        </div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
</body>
</html>