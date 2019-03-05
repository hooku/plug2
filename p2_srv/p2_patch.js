var crack = function() {
    var btn_confirm = document.getElementById("testBtnConfirm");
    btn_confirm.style.display = "block";
    
    checkBrowser = true;
    checkFlash = true;
}

var prev_handler = window.onload;
window.onload = function () {
    if (prev_handler) {
        prev_handler();
    }
    
    setTimeout(crack, 500);
};
