//
//= require jquery_ujs
//= require_tree ./admin_theme

$(function() {
    "use strict";

    var socket = $.atmosphere;
    var subSocket;

    var request = {
        url: "http://localhost:8090/rheaSocketApi/v1/5022d9105e2a0132e43c0a5f603a4ac0::ask4prasath",
        contentType: "application/json",
        logLevel: 'debug',
        transport: 'websocket',
        fallbackTransport: 'long-polling'
    };

    request.onOpen = function(response) {
        console.log("connected")
        subSocket.push("5022d9105e2a0132e43c0a5f603a4ac0::ask4prasath");
    };

    request.onMessage = function(rs) {
        console.log(rs)
        var serverStats = jQuery.parseJSON(rs.responseBody)
        networkRealtimeChartTick(serverStats.totalPerSec,  serverStats.successPerSec, serverStats.failurePerSec);
        networkRealtimeGaugeTick(serverStats.guage);
//        networkRealtimeMBupdate()
    }

    subSocket = socket.subscribe(request);
});
