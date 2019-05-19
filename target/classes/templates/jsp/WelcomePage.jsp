<!DOCTYPE html>
<html lang="ru">

<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<% HashMap<Integer, String> linksCpe = (HashMap<Integer, String>) request.getAttribute("linksCpe");%>
<% HashMap<Integer, String> linksPe = (HashMap<Integer, String>) request.getAttribute("linksPe");%>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="/js/refresh.js"></script><!-- Script for generate PE/CPE-->
<script async="" src="../welcomeBootstrapFiles/watch.js.download"></script>
<script async="" src="../welcomeBootstrapFiles/analytics.js.download"></script>

<!-- NAVIGATION BAR-->
<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">

    <a class="navbar-brand" href="">Мониторинг сети</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault"
            aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" data-toggle="modal" data-target="#PeList">Список Pe</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="modal" data-target="#CpeList">Список Cpe</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="https://bootstrap-4.ru/docs/4.3.1/examples/starter-template/#"
                   id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Добавить
                    устройство</a>
                <div class="dropdown-menu" aria-labelledby="dropdown01">
                    <a class="dropdown-item" data-toggle="modal" data-target="#addCPE">Добавить Cpe</a>
                    <a class="dropdown-item" data-toggle="modal" data-target="#addPE">Добавить Pe</a>
                </div>
            </li>
        </ul>
        <label class="btn btn-secondary"><input type="radio" name="chooseStyle" value="block" checked=""> <span
                style="vertical-align: 3px;">Динамика</span></label>
        <label class="btn btn-secondary" style="margin-left: 10px"><input type="radio" name="chooseStyle"
                                                                          value="none"><span
                style="vertical-align: 3px;"> Статика</span> </label>
        <script>
            (function () {
                var styles = {
                    block: $("#light"),
                    none: $("#dark").detach()
                };
                $("input[name=chooseStyle]").click(function () {
                    var other = this.value === "block" ? "none" : "block";
                    styles[this.value].appendTo('head');
                    styles[other].detach();
                });
            })();
        </script>
    </div>
</nav>
<!-- /NAVIGATION BAR-->

<!-- Modal for List Cpe -->
<div class="modal fade" id="CpeList" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="CpeListTitle">Список CPE</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- List Cpe -->
            <div id="cpeListId">
                <div class="list-group">
                </div>
            </div>
            <!-- /List Cpe -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- /Modal for List Cpe -->

<!-- Modal for List Pe -->
<div class="modal fade" id="PeList" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="PeListTitle">Список PE</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- List Pe -->
            <div id="peListId">
                <div class="list-group">
                </div>
            </div>
            <!-- /List Pe -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- /Modal for List Pe -->

<!-- Modal for add CPE-->
<div class="modal fade" id="addCPE" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="CPEModalLongTitle">Добавить CPE</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Form for data СPE-->
                <form name="addCpeForSend">
                    <div class="form-group">
                        <label for="inputCpeIp">CPE IP address</label>
                        <input type="text" class="form-control" id="inputCpeIp" name="inputCpeIp"
                               placeholder="192.168.1.1">
                    </div>
                    <div class="form-group">
                        <label for="inputPeIpAddressForCpe">PE IP address</label>
                        <input type="text" class="form-control" id="inputPeIpAddressForCpe" placeholder="192.168.1.1">
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-10">
                            <div class="form-check">
                                <label class="form-check-label" for="InternetActive">
                                    <input class="form-check-input" type="checkbox" id="InternetActive">
                                    Включить интернет
                                </label>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary" onclick="sendCpe('<%=linksCpe.get(1)%>')">Добавить
                    </button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                </form>
                <!-- /Form for data СPE-->
            </div>
        </div>
    </div>
</div>
<!-- /Modal for add CPE-->

<!-- Modal for add PE-->
<div class="modal fade" id="addPE" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="PEModalLongTitle">Добавить PE</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Form for data PE-->
                <form>
                    <div class="form-group">
                        <label for="inputPeIp">PE IP address</label>
                        <input type="text" class="form-control" id="inputPeIp" placeholder="192.168.1.1">
                    </div>
                    <button type="submit" class="btn btn-primary" onclick="sendPe('<%=linksPe.get(1)%>')">Добавить
                    </button>
                    <span style="visibility: hidden">.</span>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                </form>
                <!-- /Form for data PE-->
            </div>
        </div>
    </div>
</div>
<!-- /Modal for add PE-->

<!-- MAP -->
<div id="container">
    <svg width="1920px" height="1080px" id="svgId" style="filter: brightness(0.5); z-index: 5; pointer-events: none;"></svg>
    <div id="refreshPeAndCpe" style="z-index: 10"></div>
</div>
<!-- /MAP -->
<script>
    setInterval('refresh1()', 3000);
    setInterval('refresh2()', 3000);
    setInterval('refresh3()', 2000);
    setInterval('lines()', 500);
</script><!-- call refresh.js-->
<script>
    var container = document.querySelector("#container");
    var activeItem = null;
    var active = false;

    container.addEventListener("touchstart", dragStart, false);
    container.addEventListener("touchend", dragEnd, false);
    container.addEventListener("touchmove", drag, false);

    container.addEventListener("mousedown", dragStart, false);
    container.addEventListener("mouseup", dragEnd, false);
    container.addEventListener("mousemove", drag, false);

    function dragStart(e) {
        if (e.target !== e.currentTarget) {
            active = true;
            activeItem = e.target;
            if (activeItem !== null) {
                if (!activeItem.xOffset) {
                    activeItem.xOffset = 0;
                }
                if (!activeItem.yOffset) {
                    activeItem.yOffset = 0;
                }
                if (e.type === "touchstart") {
                    activeItem.initialX = e.touches[0].clientX - activeItem.xOffset;
                    activeItem.initialY = e.touches[0].clientY - activeItem.yOffset;
                } else {
                    console.log("doing something!");
                    activeItem.initialX = e.clientX - activeItem.xOffset;
                    activeItem.initialY = e.clientY - activeItem.yOffset;
                }
            }
        }
    }

    function dragEnd(e) {
        if (activeItem !== null) {
            activeItem.initialX = activeItem.currentX;
            activeItem.initialY = activeItem.currentY;

            var coords = activeItem.getBoundingClientRect();
            var strElementId = activeItem.id;
            refreshXY(strElementId, (coords.top), coords.left);
        }

        active = false;
        activeItem = null;
    }

    function drag(e) {
        if (active) {
            if (e.type === "touchmove") {
                e.preventDefault();
                activeItem.currentX = e.touches[0].clientX - activeItem.initialX;
                activeItem.currentY = e.touches[0].clientY - activeItem.initialY;
            } else {
                activeItem.currentX = e.clientX - activeItem.initialX;
                activeItem.currentY = e.clientY - activeItem.initialY;
            }
            activeItem.xOffset = activeItem.currentX;
            activeItem.yOffset = activeItem.currentY;
            setTranslate(activeItem.currentX, activeItem.currentY, activeItem);
        }
    }

    function setTranslate(xPos, yPos, el) {
        el.style.transform = "translate3d(" + xPos + "px, " + yPos + "px, 0)";
    }
</script>
<!-- SCRIPTS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
<!-- /SCRIPTS -->
</body>
<head>
    <meta http-equiv="content-Type" content="text/html" charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style src="..//css/line.css"></style>
    <title>Главная страница</title>
    <!-- CSS -->
    <style>
        body {
            background: #c7b39b url(/images/map.jpg);
            backdrop-repeat: no-repeat;
            color: black;
            background-size: cover;
            width: 1920px;
            height: 980px;
        }
    </style>
    <!-- DRAGIN CSS -->
    <style>
        #container {
            width: 2020px;
            height: 980px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 7px;
            touch-action: none;
            position: relative;
        }

        .two {
            width: 50px;
            height: 50px;
            background: url(/images/PE.png);
        }

        .three {
            width: 60px;
            height: 48px;
            background: url(/images/CPE.png);
        }

        .item:active {
            opacity: .75;
        }

        .item:hover {
            cursor: pointer;
        }

        h1 {
            margin-bottom: 10px;
        }

        .pcl {
            margin-left: 10px;
        }

    </style>
    <!-- /DRAGIN CSS -->
    <style>
        .descr {
            display: none;
        }

        .descrCPE {
            padding-top: 10px;
            height: 370%;
            width: 200px;
            margin-left: 75px;
            margin-top: -25px;
            background: #f3f3f3;
            -moz-box-shadow: 0 5px 5px rgba(0, 0, 0, 0.3);
            -webkit-box-shadow: 0 5px 5px rgba(0, 0, 0, 0.3);
            box-shadow: 0 5px 5px rgba(0, 0, 0, 0.3);
        }

        .descrPE {
            padding-top: 10px;
            height: 440%;
            width: 200px;
            margin-left: 55px;
            margin-top: -50px;
            /*margin-top:-75px;*/
            background: #f3f3f3;
            -moz-box-shadow: 0 5px 5px rgba(0, 0, 0, 0.3);
            -webkit-box-shadow: 0 5px 5px rgba(0, 0, 0, 0.3);
            box-shadow: 0 5px 5px rgba(0, 0, 0, 0.3);
        }

        .two:hover .descrPE {
            display: block;
            margin-left: 55px;
            margin-top: -50px;
            height: 440%;
            z-index: 9999;
            width: 200px;
        }

        .three:hover .descrCPE {
            display: block;
            margin-left: 75px;
            margin-top: -25px;
            height: 370%;
            z-index: 9999;
            width: 200px;
        }

        .pcl {
            margin-left: 10px;
        }
    </style>

    <style id="dark">
        .descr {
            display: block;
        }
    </style>

    <!-- /CSS -->
</head>
</html>