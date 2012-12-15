/****************************************/
/* *********************************** */
/* 管理ページ用JS */
/* js_lib_admin.jsはprototype.jsが必要 */
/* 2007.09.26 ZUTTO T.Kikuchi */
/* *********************************** */
/****************************************/

/*****************************************************
 * ExeKeydown(keyCode)：：キーダウン時アクション
 *
 * 2006.05.27 iDena Kikuchi
 *
 */
function ExeKeydown(keyCode) {
    if (keyCode == 112) {
        //F1
    }
    if (keyCode == 113) {
        //F2
    }
    if (keyCode == 114) {
        //F3
    }
    if (keyCode == 115) {
        //F4
    }
    if (keyCode == 116) {
        //F5
    }
    if (keyCode == 117) {
        //F6
    }
    if (event.keyCode == 118) {
        //F7
    }
    if (event.keyCode == 119) {
        //F8
    }
    if (event.keyCode == 120) {
        //F9
    }
    if (event.keyCode == 121) {
        //F10
    }
    if (event.keyCode == 122) {
        //F11
    }
    if (event.keyCode == 123) {
        //F12
        event.keyCode = 0
        try { $("btnF12").click(); } catch(e) {}
        return false;
    }
    if (event.keyCode == 37) {
        //←
    }
    if (event.keyCode == 39) {
        //→
    }
    if (event.keyCode == 38) {
        //↑
    }
    if (event.keyCode == 40) {
        //↓
    }
    if (event.keyCode == 33) {
        //PageUp
    }
    if (event.keyCode == 34) {
        //PageDown
    }
    if (event.keyCode == 36) {
        //Hm
    }
}


/*****************************************************
 * ExePosi(obj)
 * objが表示上真ん中になる位置
 * 2008.06.27 ZUTTO T.Kikuchi
 *
 */
function ExePosi(obj) {

    //ウインドウ内の座標取得
    var cw;
    var ch;
    var ctop;
    var objtop;
    var objleft;

    //tip用オブジェクトの幅取得
    var tw = document.getElementById(obj).style.width.replace("px","");
    var th = document.getElementById(obj).style.height.replace("px","");

    if(document.all){

        cw = document.body.clientWidth;
        ch = document.documentElement.clientHeight || document.body.clientHeight;
        ctop = document.documentElement.scrollTop || document.body.scrollTop;

    } else {

        cw = innerWidth;
        ch = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
        ctop = document.body.scrollTop || document.documentElement.scrollTop;

    }

    //表示させる位置を取得

    objtop = ctop + ((ch - th) / 2);
    objleft = ((cw - tw) / 2);

    var pos = new Array();
    pos = [objtop,objleft];
    return pos;

}


/*****************************************************
 * ExeShowTip(obj)
 * Tipの表示
 * 2008.06.27 ZUTTO T.Kikuchi
 *
 */
function ExeShowMapSet(obj,model) {

    var pos = new Array();
    pos = ExePosi(obj);

    var objtop;
    var objleft;

    objtop = pos[0];
    objleft = pos[1];

    document.getElementById("txt_address").value = document.getElementById(model+"_address").value ;

    document.getElementById(obj).style.position = "absolute";
    document.getElementById(obj).style.top = objtop + "px";
    document.getElementById(obj).style.left = objleft + "px";

    document.getElementById(obj).style.display = "block";

    if(navigator.userAgent.indexOf("MSIE 6.") >= 0) {
        document.getElementById("tipframe").style.position = "absolute";
        document.getElementById("tipframe").style.top = objtop + "px";
        document.getElementById("tipframe").style.left = objleft + "px";
        document.getElementById("tipframe").style.display = "block";
    }

    ExeShowMap(model);

}

var map;
var geocoder;

/*****************************************************
 * ExeShowMap()
 * GoogleMapの表示
 * 2008.07.01 ZUTTO T.Kikuchi
 *
 */
function ExeShowMap(model){

    if(GBrowserIsCompatible()){

        var address = document.getElementById(model+"_address").value ;
        var latitude = document.getElementById(model+"_object_latitude").value;
        var longitude = document.getElementById(model+"_object_longitude").value;

        document.getElementById("txt_address").value = address;
        document.getElementById("tmp_object_latitude").value = latitude;
        document.getElementById("tmp_object_longitude").value = longitude;

        map =new GMap2(document.getElementById("map"),{draggableCursor:"crosshair",draggingCursor:"pointer"});
        new GKeyboardHandler(map);
        map.addControl(new GLargeMapControl());
        map.addControl(new GMapTypeControl());
        map.addControl(new GScaleControl());
        map.addControl(new GOverviewMapControl());
        map.enableDoubleClickZoom();

        geocoder = new GClientGeocoder();

        //map.setCenter(new GLatLng(35.866795,139.372559), 8);//東京
         map.setCenter(new GLatLng(35.154919,136.920593), 8);//名古屋

        //住所がある場合探してみる
        if (latitude != "" && longitude != "") {

            var point = new GLatLng(latitude,longitude);
            map.setCenter(point, 13);
            map.clearOverlays();//現在のオーバーレイを消す
            //表示ポイント
            var marker = new GMarker(point);
            var iconObj = new GIcon();
            iconObj.iconAnchor = new GPoint(0,0);
            iconObj = new GIcon();
            iconObj.image = "../../../images/common/orange-dot.png";
            iconObj.shadow = "../../../images/common/msmarker_shadow.png";
            iconObj.iconSize = new GSize(32,32);
            iconObj.shadowSize = new GSize(59,32);
            iconObj.iconAnchor = new GPoint(16,32);
            var marker = new GMarker(point,iconObj);
            map.addOverlay(marker);

        } else if (address != "") {

            ExeMoveAddress(address);

        }

        icon = new GIcon();
        icon.image = "../images/common/blue-dot.png";
        icon.shadow = "../images/common/msmarker_shadow.png";
        icon.iconSize = new GSize(12, 20);
        icon.shadowSize = new GSize(22, 20);
        icon.iconAnchor = new GPoint(6, 20);
        icon.infoWindowAnchor = new GPoint(5, 1);

        GEvent.addListener(map, "click", function(marker, point){
            map.clearOverlays();//現在のオーバーレイを消す
            var arr_point = new Array();
            arr_point = point.toUrlValue().split(",");
            document.getElementById("tmp_object_latitude").value = arr_point[0];
            document.getElementById("tmp_object_longitude").value = arr_point[1];
            //表示ポイント
            var marker = new GMarker(point);
            var iconObj = new GIcon();
            iconObj.iconAnchor = new GPoint(0,0);
            iconObj = new GIcon();
            iconObj.image = "../../../images/common/orange-dot.png";
            iconObj.shadow = "../../../images/common/msmarker_shadow.png";
            iconObj.iconSize = new GSize(32,32);
            iconObj.shadowSize = new GSize(59,32);
            iconObj.iconAnchor = new GPoint(16,32);
            var marker = new GMarker(point,iconObj);
            map.addOverlay(marker);

        });

    }

}

function f_pointVal(point){

    if(chMt.p_enabled){

        map.addOverlay(new GMarker(point,icon));
        f_gElmId("message").innerHTML = point.toUrlValue();

    }

}


/*****************************************************
 * ExeMoveAddress()
 * GoogleMapの表示
 * 2008.07.01 ZUTTO T.Kikuchi
 *
 */
function ExeMoveAddress(address){
    if ( geocoder ) {
        // getLatLngに住所情報を渡し、コールバック関数で地図を移動させる
        geocoder.getLatLng(
        address, function(point){
            if (point) {
                //現在のオーバーレイを消す
                map.clearOverlays();
                // コールバック関数から受け取った引数を使って地図を移動
                map.setCenter(point, 13);
                // マーカーを表示
                var iconObj = new GIcon();
                iconObj.iconAnchor = new GPoint(0,0);
                iconObj = new GIcon();
                iconObj.image = "../../../images/common/orange-dot.png";
                iconObj.shadow = "../../../images/common/msmarker_shadow.png";
                iconObj.iconSize = new GSize(32,32);
                iconObj.shadowSize = new GSize(59,32);
                iconObj.iconAnchor = new GPoint(16,32);
                var marker = new GMarker(point,iconObj);
                map.addOverlay(marker);
                var arr_point = new Array();
                arr_point = point.toUrlValue().split(",");
                document.getElementById("tmp_object_latitude").value = arr_point[0];
                document.getElementById("tmp_object_longitude").value = arr_point[1];
            }
        }
    );
    }
}
function ExeShowAddress(object_longitude,object_latitude,name){
    
    var map = new GMap(document.getElementById("map"));
    map.addControl(new GSmallMapControl());
    map.addControl(new GMapTypeControl());
    map.centerAndZoom(new GPoint(object_longitude,object_latitude), 3);

    // Creates a marker whose info window displays the given number
    function addMarker(map, lat, lng, html) {
        var point = new GPoint(lat, lng);
        var marker = new GMarker(point);

        // Show this marker's index in the info window when it is clicked
        GEvent.addListener(marker, "click", function() {
            //marker.openInfoWindowHtml(html);
        });
        map.addOverlay(marker);
    }
    addMarker(map,object_longitude,object_latitude,"<b>"+ name +"</b>");
};
function NewExeShowAddress(object_longitude,object_latitude,name){

    var map;
    var markers = new Array(5);
      map = new GMap2(document.getElementById("map"));
      map.setCenter(new GLatLng(object_latitude,object_longitude),3);
      map.addControl(new GLargeMapControl());
      map.addControl(new GMapTypeControl());
      map.addControl(new GOverviewMapControl());
      map.setMapType(G_NORMAL_MAP);
      var marker = null;
      var n_markers = 0;
      var markeropts = new Object();
      marker = new GMarker(new GPoint(object_latitude,object_longitude), markeropts);
      markers[n_markers] = marker;
      n_markers++;
      map.addOverlay(marker);
};
