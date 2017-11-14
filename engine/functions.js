function setTrucs() {
    if($('#user').val()!="" && $('#make').val()!="" && $('#model').val()!="" && $('#carnum').val()!=""
&& $('#trailernum').val()!="" && $('#owner').val()!="" && $('#driver').val()!="" && $('#t_type').val()!=""
&& $('#c_type').val()!="" && $('#spec1_l').val()!="" && $('#spec1_v').val()!="") {
        var post = {};
        post['action'] = "setTrucs";
        post['id'] = $('#user').val();
        post['make'] = $('#make').val();
        post['model'] = $('#model').val();
        post['carnum'] = $('#carnum').val();
        post['trailernum'] = $('#trailernum').val();
        post['owner'] = $('#owner').val();
        post['driver'] = $('#driver').val();
        post['t_type'] = $('#t_type').val();
        post['c_type'] = $('#c_type').val();
        post['spec1_l'] = $('#spec1_l').val();
        post['spec1_v'] = $('#spec1_v').val();
        if ($('#spec2_l').val() != "" && $('#spec2_v').val() != "") {
            post['spec2_l'] = $('#spec2_l').val();
            post['spec2_v'] = $('#spec2_v').val();
        }
        $.ajax({
            method: "post",
            url: "engine/server.php",
            data: post,
            success: function (html) {
                $("#msg").html(html);
            }
        });
        $(".reset").val("");

        getUsers();
        getTypeTransport();
        $("#spec").html("");
        $("#t_c").html("");
    }
    else{
        $("#msg").html("Заполни все поля!");
    }
}


function getSpecification() {
    var id=$('#c_type').val();
    $.ajax({
        method:"POST",
        url:"engine/server.php",
        data:"action=getTypeSpecification&id="+id,
        success:function (html) {
            $("#spec").html(html);
        }
    });
}

function getTypeCarcas() {
    var id=$('#t_type').val();
    $.ajax({
        method:"POST",
        url:"engine/server.php",
        data:"action=getTypeCarcas&id="+id,
        success:function (html) {
            $("#t_c").html(html);
            $("#spec").html("");
        }
    });
}


function getTypeTransport() {
  $.ajax({
      method:"POST",
      url:"engine/server.php",
      data:"action=getTypeTransport",
      success:function (html) {
          $("#t_t").html(html);
      }
  });
}

function getUsers() {
    $.ajax({
        method:"POST",
        url:"engine/server.php",
        data:"action=getUsers",
        success:function (html) {
            $("#users").html(html);
        }
    });
}

function getUsersTrucks() {
    $.ajax({
        method:"POST",
        url:"engine/server.php",
        data:"action=getUsersTrucks",
        success:function (html) {
            $("#users_truck").html(html);
        }
    });
}

function getUserTrucks() {
    var id=$("#users_id").val();
    $.ajax({
        method:"POST",
        url:"engine/server.php",
        data:"action=getUserTrucks&id="+id,
        success:function (html) {
            $("#user_trucks").html(html);
        }
    });
}

$(document).ready(function(){
    getUsers();
    getTypeTransport();
    getUsersTrucks();
});