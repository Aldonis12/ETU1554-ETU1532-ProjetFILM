<%@ page import="com.example.film.model.Plateau" %>
<%@ page import="com.example.film.model.Personnage" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.film.model.Film" %><%--
  Created by IntelliJ IDEA.
  User: mickl
  Date: 21/03/2023
  Time: 06:55
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html lang="en">
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<Plateau> plateau = (List<Plateau>)request.getAttribute("plateau");%>
<%List<Personnage> perso = (List<Personnage>)request.getAttribute("personnage");%>
<%List<Film> film = (List<Film>)request.getAttribute("film");%>

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

<script>
    function cacher() {
        var plateau = document.getElementById("plateau");
        var personnage = document.getElementById("personnage");
        plateau.style.display = "none";
        personnage.style.display = "none";
    }

    function montrerPlateau() {
        var personnage = document.getElementById("personnage");
        var plateau = document.getElementById("plateau");
        var choix = document.getElementById("choix");
        choix.style.display = "none";
        personnage.style.display = "none";
        plateau.style.display="block";
    }

    function montrerPersonnage() {
        var plateau = document.getElementById("plateau");
        var choix = document.getElementById("choix");
        var personnage = document.getElementById("personnage");
        choix.style.display = "none";
        plateau.style.display = "none";
        personnage.style.display = "block";
    }

    window.onload = function() {
        cacher();
    };
</script>

<div class="wrapper">
    <div class="main-panel">
        <!-- commentaire -->
        <div class="content" id="choix">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card card-plain">
                            <h4 class="title">INDISPONIBILITE</h4>
                            <br>
                            <p class="category">Mettre l'indisponibilité pour :</p>
                            <br>
                            <ul>
                                <li class="category" id="choix-acteur"><a onclick="montrerPersonnage()">Acteur</a></li>
                                <br>
                                <li class="category" id="choix-plateau"><a onclick="montrerPlateau()">Plateau</a></li>
                            </ul>
                            <br>
                            <p class="category">Voir l'indisponibilité :</p>
                            <br>
                            <ul>
                                <li class="category"><a href="<%=request.getContextPath()%>/ListePlateau">Plateau</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- commentaire -->
        <div class="content" id="plateau">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 col-md-7">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Indisponiblité du plateau / <a onclick="montrerPersonnage()">Mettre pour l'acteur</a></h4>
                                <br>
                                <h6 class ="title">Plateaux pour les scènes du film :</h6>
                            </div>
                            <div class="content">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Film :</label>
                                                <ul>
                                                    <%for(Film p: film) {%>
                                                    <li><a href="<%=request.getContextPath()%>/IndisponibilitePlateau?id=<%=p.getId()%>"><%=p.getFilm()%></a></li>
                                                    <%}%>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- commentaire -->
        <div class="content" id="personnage">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 col-md-7">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Indisponiblité pour l'acteur / <a onclick="montrerPlateau()">Mettre pour le plateau</a></h4>
                            </div>
                            <div class="content">
                                <form method="post" action="<%=request.getContextPath()%>/indispoPerso">

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Personnage</label>
                                                <select name = "idperso" class="form-control border-input">
                                                    <%for(Personnage p: perso) {%>
                                                    <option value="<%=p.getId()%>"><%=p.getNomPersonnage()%></option>
                                                    <%}%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Debut</label>
                                                <input rows="2" type="date" name="debut" class="form-control border-input">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Fin</label>
                                                <input rows="2" type="date" name="fin" class="form-control border-input">
                                            </div>
                                        </div>
                                    </div>

                                    <br>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-info btn-fill btn-wd">Ajouter</button>
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
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
