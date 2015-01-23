//
//= require jquery_ujs
//= require_tree ./admin_theme

$(function() {
    "use strict";

    var socket = $.atmosphere;
    var subSocket;

    var request = {
        url: "http://54.69.164.109:8090/rheaSocketApi/v1/6a9a98405e270132e43b0a5f603a4ac0::ask4prasath",
        contentType: "application/json",
        logLevel: 'debug',
        transport: 'websocket',
        fallbackTransport: 'long-polling'
    };

    request.onOpen = function(response) {
        console.log("connected")
        subSocket.push("6a9a98405e270132e43b0a5f603a4ac0::ask4prasath");
    };

    request.onMessage = function(rs) {
        console.log(rs)
        var serverStats = jQuery.parseJSON(rs.responseBody)
        console.log(serverStats)
        networkRealtimeChartTick(serverStats.totalPerSec,  serverStats.successPerSec, serverStats.failurePerSec);
        networkRealtimeGaugeTick(serverStats.guage);

        if(serverStats.alert.length > 0) {
            $(".badge-green").text(parseInt($(".badge-green").text()) + 1)
            $(".user-timeline-stories").prepend('<article class="timeline-story"><header><p><i class="fa-bell-slash-o" style="color: indianred;"></i>  &nbsp; '  + serverStats.alert +   '</p></header></article>')
            var articles = $(".user-timeline-stories article")
            if(articles.size() > 10) {
                articles.last().remove()
            }
        }

        if(serverStats.rule.length > 0) {
            $(".badge-purple").text(parseInt($(".badge-purple").text()) + 1)
            $(".user-timeline-stories").prepend('<article class="timeline-story"><header><p><i class="fa-exclamation-circle" style="color: indianred;"></i>  &nbsp; '  + serverStats.rule +   '</p></header></article>')
            var articles = $(".user-timeline-stories article")
            if(articles.size() > 10) {
                articles.last().remove()
            }
        }
//        networkRealtimeMBupdate()
    }

    subSocket = socket.subscribe(request);
});
