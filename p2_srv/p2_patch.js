var show_confirm = function() {
    var btn_confirm = document.getElementById("testBtnConfirm");
    btn_confirm.style.display = "block";
}

var prev_handler = window.onload;
window.onload = function () {
    if (prev_handler) {
        prev_handler();
    }
    
    setTimeout(show_confirm, 500);
};
