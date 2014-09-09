$(document).ready(function () {
    DeterminHeightAndWidth();
    if (winW <= 700) {
        $(".dialog-container").hide();
    }
    $('body').bind('click', function () {
        if ($('#btn_setting').hasClass('active'))
            $('#btn_setting').trigger('click');
    });

    $('#btn_setting').toggle(function () {
        $(this)
					.addClass('active')
					.siblings('.list_setting').stop(true, true).slideToggle(300);
    }, function () {
        $(this)
					.removeClass('active')
					.siblings('.list_setting').slideToggle(300);
    });
});
$(window).resize(function () {
    SetPageElements();
});
function SetPageElements() {
    setFooterHeight();
    DeterminHeightAndWidth();
}
function setTab(index) {
    if (document.getElementById("ulTab") != null
        && document.getElementById("ancTab_" + index) != null) {
        var arrAnc = document.getElementById("ulTab").getElementsByTagName("a");
        if (arrAnc != null && arrAnc.length > 0) {
            for (var ancIndex = 0; ancIndex < arrAnc.length; ancIndex++) {
                if (arrAnc[ancIndex].id.search("ancTab_") >= 0) {
                    arrAnc[ancIndex].className = "";
                }
            }
            document.getElementById("ancTab_" + index).className = "menusel";
        }
    }
}
var winW, winH;
function DeterminHeightAndWidth() {
    if (document.body && document.body.offsetWidth) {
        winW = document.body.offsetWidth;
        winH = document.body.offsetHeight;
    }
    if (document.compatMode == 'CSS1Compat' &&
            document.documentElement &&
            document.documentElement.offsetWidth) {
        winW = document.documentElement.offsetWidth;
        winH = document.documentElement.offsetHeight;
    }
    if (window.innerWidth && window.innerHeight) {
        winW = window.innerWidth;
        winH = window.innerHeight;
    }
    HideLeftPanel();
}
function setFooterHeight() {
    var minHeight = document.documentElement.scrollHeight;
    document.getElementById("menu").style.minHeight = minHeight + "px";
    document.getElementById("hdnTap").value = "0";
}
function HideLeftPanel() {
    if (winW >= 700) {
        hideTab();
        document.getElementById("menu").style.display = "none";
        document.getElementById("hdnTap").value = "0";
        $(".dialog-container").show();
    }
    else {
        $(".dialog-container").hide();
    }
}
var _leftContentHolder;
var _currentTab;
function slideFadeToggle() {
    if (document.getElementById("hdnTap").value == "1") {
        document.getElementById("hdnTap").value = "0";
        hideTab();
    }
    else {
        document.getElementById("hdnTap").value = "1";
        document.getElementById("ulMenu").style.display = "block";
        //   $(".innerright").animate({ margin: '0px 0px 0px 31%' }, 'fast', "linear");
        $(".innerright").css('margin-left', '71%');
        $(".slidepanel").animate({ width: '70%' }, 'fast', "linear");
        document.getElementById("menu").style.display = "block";
    }
}

function hideTab() {
    $(".innerright").animate({ margin: '0px 0px 0px 0%' }, 'fast', "linear");
    $(".innerright").css('margin-left', '0%');
    $(".slidepanel").animate({ width: '0%' }, 'fast', "linear");
    document.getElementById("ulMenu").style.display = "none";
}