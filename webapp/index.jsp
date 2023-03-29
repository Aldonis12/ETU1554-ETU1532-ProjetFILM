<!doctype html>
<html lang="en">
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<body>
<jsp:include page="WEB-INF/page/lien.jsp"/>
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
                <a href="<%= request.getContextPath() %>/indisponibilite">
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
                            <h4 class="title">Bienvenue!</h4>
                            <br>
                            <p class="category">Veuillez choisir un option sur le menu du coté gauche.</p>
                        </div>
                    </div>


                </div>
            </div>
        </div>
        <jsp:include page="WEB-INF/page/footer.jsp"/>
    </div>
</div>
</body>
</html>
