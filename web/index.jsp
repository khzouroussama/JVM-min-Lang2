<%--
  Created by IntelliJ IDEA.
  User: temp
  Date: 12/12/19
  Time: 9:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1.0" name="viewport"/>
    <title>Rapport de TP ASGBD</title>

    <!-- CSS  -->
    <link href="css/materialize.css" media="screen,projection" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" media="screen,projection" rel="stylesheet" type="text/css"/>
    <style>
        .clickable {
            cursor: pointer;
        }

        #toast-container {
            top: 15%;
            right: auto !important;
            bottom: auto !important;
            left: 85%;
        }

    </style>
</head>
<body>


<nav class="nav-extended  light-blue darken-2">
    <div class="nav-wrapper">
        <a href="#" class="brand-logo center"><i class="material-icons">code</i>SmallJava Editor</a>
        <a href="#" data-target="mobile-demo" class="sidenav-trigger"><i class="material-icons">menu</i></a>
        <ul id="nav-mobile" class="right hide-on-med-and-down">
            <li><a href=""><i class="material-icons">search</i></a></li>
            <li><a href=""><i class="material-icons">apps</i></a></li>
            <li><a href=""><i class="material-icons">refresh</i></a></li>
            <li><a href=""><i class="material-icons">more_vert</i></a></li>
        </ul>
    </div>
    <div class="nav-content container">
        <ul class="tabs tabs-transparent">
            <li class="tab"><a class=" waves-effect waves-light active" href="#tab1">Programme.sj</a></li>
            <li class="tab"><a class=" waves-effect waves-light " href="#tab2">Quadreplet.quad</a></li>
            <li class="tab"><a class=" waves-effect waves-light " href="#tab3">ObjectCode.j</a></li>
        </ul>
        <div id="build-app">
            <a class="btn-floating btn-large halfway-fab waves-effect waves-light teal lighten-3 tooltipped"
               data-position="top" data-tooltip="Build" style="right: 90px"
               v-on:click="build">
                <i class="material-icons">build</i>
            </a>
            <a class="btn-floating btn-large halfway-fab waves-effect waves-light red lighten-3 tooltipped"
               data-position="top" data-tooltip="Run"
               v-on:click="run"
            >
                <i class="material-icons">play_arrow</i>
            </a>
        </div>
    </div>
</nav>

<ul class="sidenav" id="mobile-demo">
    <li><a href="sass.html">Sass</a></li>
    <li><a href="badges.html">Components</a></li>
    <li><a href="collapsible.html">JavaScript</a></li>
</ul>

<br>
<div id="tab1" class="container">
    <div class="row">
        <div class="col s12">
            <div class="edit card" id="editor1">import Small_Java.lang ;

protected sj_class SmallJava {

    MainSj{
        sj_int x , z ;
        sj_float y ;

        x := x * 5 / 3.2 ;
    }
}
            </div>
        </div>
    </div>
</div>
<div id="tab2" class="container">
    <div class="row">
        <div class="col s8 push-s2">
            <div class="edit card">
                <table class="centered highlight">
                    <thead>
                    <tr>
                        <th>OP</th>
                        <th>OP1</th>
                        <th>OP2</th>
                        <th>RES</th>
                    </tr>
                    </thead>

                    <tbody id="print-quads">
                    <tr v-for="quad in quads[0]">
                        <td>{{ quad[0] }}</td>
                        <td>{{ quad[1] }}</td>
                        <td>{{ quad[2] }}</td>
                        <td>{{ quad[3] }}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="tab3" class="container">
    <div class="row">
        <div class="col s12">
            <div class="edit card" id="editor3">No Code yet ..</div>
        </div>
    </div>
</div>

<div class="container">
    <div class="card light-blue lighten-3 ">
        <div class="col s12 center-align teal-text "><i class="material-icons">laptop_mac</i>Output</div>
        <div class="row">
            <div class="col s12">
                <div class="edit card grey lighten-4" id="printOutput" style="padding: 10px">
                    <div class="grey lighten-4" style="max-height: 200px;min-height:200px;overflow: auto">
                        <span v-if="compiled && outs[0].length == 0" class="teal-text text-lighten-2 left-align">
                            > Programme a ete compiler avec sucsses
                            <br>
                        </span>
                        <%--errs will go here --%>
                        <span v-if="compiled && outs[0].length != 0" class="teal-text text-lighten-2 left-align">
                            <span class="red-text text-lighten-2 left-align" v-for="err in outs[0]" style="">
                                {{ err }}<br>
                            </span>
                        </span>
    <%--                        Outputs will go here--%>
                        <span v-if="compiled && outs[0].length == 0 && run" class="left-align">
                            <span class="blue-grey-text left-align" v-for="out in outs[1]" style="">
                                {{ out }}<br>
                            </span>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!--  Scripts-->
<script src="js/http_code.jquery.com_jquery-2.1.1.js"></script>
<script src="js/materialize.js"></script>
<script src="aceEditor/ace-builds-master/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>

<script src="js/vue.js"></script>
<script src="js/axios.js"></script>
<script src="js/init.js"></script>

<script>

    var printQuadsApp = new Vue({
            el: '#print-quads',
            data: {
                quads: []
            }
        }
        // define methods under the `methods` object
    );

    var outputApp = new Vue({
            el: '#printOutput',
            // outs[0] contains Errs , 1 contains output ( 0errs => output )
            //TODO NO time for Vue.js !!!!
            data: {
                outs: [],
                compiled : false,
                run : false
            }
        }
        // define methods under the `methods` object
    );
    var buildapp = new Vue({
        el: '#build-app',
        data: {
            cis: ''
        },
        // define methods under the `methods` object
        methods: {
            run :function(event){
                fetch('Run').then(res => res.json())
                    .then( res => {
                        Vue.set(outputApp.outs,1,res.out.split('##') );
                        outputApp.run = true;
                        // TODO some Condition to toast
                        M.toast({
                            html: '<i class="material-icons">done_all</i> Build completed successfully  !', classes:' lighten-3  toastFix center-align'
                        });
                    }).catch(reason =>
                    M.toast({
                        html: '<i class="material-icons">not_interested</i> '+reason, classes: ' red lighten-3  toastFix'
                    }) )
                ;
            },
            build: function (event) {

                outputApp.run = false;
                var usr_code = editor1.getValue();
                usr_code = usr_code.replace('/\n/g','') ;
                var headers = {
                    "Content-Type": "application/json",
                    "Access-Control-Origin": "*"
                };
                fetch('Build', {
                    method: 'POST',
                    headers: headers,
                    body:  usr_code ,
                }).then(res => res.json())
                .then( res => {
                      this.cis = res;
                      editor3.setValue(this.cis.JVM.replace(/##/g, '\n'));
                      Vue.set(printQuadsApp.quads,0,this.cis.quads);
                      Vue.set(outputApp.outs,0,this.cis.errs);
                      outputApp.compiled = true;
                      // TODO some Condition to toast
                            M.toast({
                              html: '<i class="material-icons">done_all</i> Programme a ete compiler avec '+(this.cis.errs.length)+' erreurs !', classes: ((this.cis.errs.length ===0)?'teal':'red')+' lighten-3  toastFix center-align'
                            });
                }).catch(reason =>
                      M.toast({
                          html: '<i class="material-icons">not_interested</i> '+reason, classes: ' red lighten-3  toastFix'
                      }) )
                ;


                // editor2.setValue(this.quads.quads)

            }
        }
    })




</script>

</body>
</html>