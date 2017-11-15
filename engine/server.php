<?php
/**
 * Created by PhpStorm.
 * User: Тимурка
 * Date: 12.11.2017
 * Time: 12:34
 */
require_once "../models/config.php";
switch ($_POST['action']){
    case "getTypeTransport":
        echo getTypeTransport();
        break;
    case "getTypeCarcas":
            echo getTypeCarcas($_POST['id']);
        break;
    case "getTypeSpecification":
        echo getSpecification($_POST['id']);
        break;
    case "getUsers":
        echo getUsers();
        break;
    case "setTrucs":
        echo setTrucs();
        break;
    case "getUsersTrucks":
        echo getUsersTrucks();
        break;
    case "getUserTrucks":
        $id=(int)htmlspecialchars(strip_tags($_POST['id']));
        echo getUserTrucks($id);
        break;
}


function getTypeTransport(){
    $mysqli=mysqli_connect(SQL_SERVER,SQL_USER,SQL_PASS,SQL_DBNAME,SQL_PORT);
    $res=$mysqli->query("SELECT * FROM transport_type");
    $result="<label>Выберите тип транспорта<select id='t_type' class='reset' onchange='getTypeCarcas()' required><option></option>";
    while($row=$res->fetch_assoc()){
        $result.="<option value=".$row['id_tr'].">".$row['type']."</option>";
    }
    $mysqli->close();
    $result.="</select></label>";
    return $result;
}

function getTypeCarcas($id){
    if (($id)>0) {
        $mysqli = mysqli_connect(SQL_SERVER, SQL_USER, SQL_PASS, SQL_DBNAME, SQL_PORT);
        $res = $mysqli->query("select truck_type.id_car,carcas_type.`type` from truck_type
inner join carcas_type on carcas_type.id_carc=truck_type.id_car
where truck_type.id_tr=" . $id . ";");
        $result = "<label>Выберите тип кузова<select id='c_type' class='reset' onchange='getSpecification()' required><option></option>";
        while ($row = $res->fetch_assoc()) {
            $result .= "<option value=" . $row['id_car'] . ">" . $row['type'] . "</option>";
        }
        $mysqli->close();
        $result .= "</select></label>";
        return $result;
    }
    else{
        return "";
    }
}

function getSpecification($id){
    $result="<label>Укажите длину прицепа, м<input type='number' class='reset' id='spec1_l' step='0.1'required></label><br>";
    $result.="<label>Укажите объем прицепа, м<sup>3</sup><input type='number' id='spec1_v' required></label>";
    if ($id==2){
        $result.="<br><label>Укажите длину прицепа, м<input type='number' class='reset' id='spec2_l' step='0.1'required></label><br>";
        $result.="<label>Укажите объем прицепа, м<sup>3</sup><input type='number' class='reset' id='spec2_v' required></label>";
    }
    return $result;
}

function getUsers(){
    $mysqli = mysqli_connect(SQL_SERVER, SQL_USER, SQL_PASS, SQL_DBNAME, SQL_PORT);
    $res=$mysqli->query("SELECT * FROM users");
    $result="<label>Выберите юзера<select id='user' required><option></option>";
    while($row=$res->fetch_assoc()){
        $result.="<option value=".$row['id'].">".$row['user']."</option>";
    }
    $mysqli->close();
    $result.="</select>";
    return $result;
}

function setTrucs(){
    $id_user=(int)htmlspecialchars(strip_tags($_POST['id']));
    $make=strtoupper(htmlspecialchars(strip_tags($_POST['make'])));
    $model=strtoupper(htmlspecialchars(strip_tags($_POST['model'])));
    $c_num=htmlspecialchars(strip_tags($_POST['carnum']));
    $t_num=htmlspecialchars(strip_tags($_POST['trailernum']));
    $owner=htmlspecialchars(strip_tags($_POST['owner']));
    $driver=htmlspecialchars(strip_tags($_POST['driver']));
    $t=(int)htmlspecialchars(strip_tags($_POST['t_type']));
    $c=(int)htmlspecialchars(strip_tags($_POST['c_type']));
    $sl=(float)htmlspecialchars(strip_tags($_POST['spec1_l']));
    $sv=(int)htmlspecialchars(strip_tags($_POST['spec1_v']));
    $mysqli = mysqli_connect(SQL_SERVER, SQL_USER, SQL_PASS, SQL_DBNAME, SQL_PORT);
    $mysqli->query("INSERT INTO truck (id_truck_type,make,model,car_num,trailer_num,driver,`owner`) 
VALUES ((select id_truck_type from truck_type where id_tr=$t AND id_car=$c),'$make','$model','$c_num','$t_num','$driver','$owner');");

    $i=$mysqli->query("SELECT LAST_INSERT_ID()");
    $i=$i->fetch_row();
    $i=$i[0];
    $mysqli->query("INSERT INTO specific_prim(id_truck,`lenght`,capacity) VALUES($i,'$sl',$sv)");
    if (isset($_POST['spec2_l'])&&isset($_POST['spec2_v'])){
        $sl=(float)htmlspecialchars(strip_tags($_POST['spec2_l']));
        $sv=(int)htmlspecialchars(strip_tags($_POST['spec2_v']));
        $mysqli->query("INSERT INTO specific_second(id_truck,lenght,capacity) VALUES($i,'$sl',$sv)");
    }
    $mysqli->query("INSERT INTO user_cars (id_user,id_truck) VALUES ($id_user,$i)");
    $mysqli->close();
    return "Данные успешно внесены!";
}

function getUsersTrucks(){
    $mysqli = mysqli_connect(SQL_SERVER, SQL_USER, SQL_PASS, SQL_DBNAME, SQL_PORT);
    $res=$mysqli->query("SELECT * FROM users");
    $result="<label>Выберите юзера<select id='users_id' onchange='getUserTrucks()'><option></option>";
    while($row=$res->fetch_assoc()){
        $result.="<option value=".$row['id'].">".$row['user']."</option>";
    }
    $mysqli->close();
    $result.="</select>";
    return $result;
}
 function getUserTrucks($id){
    if ($id>0) {
        $mysqli = mysqli_connect(SQL_SERVER, SQL_USER, SQL_PASS, SQL_DBNAME, SQL_PORT);
        $res = $mysqli->query("select truck.make,truck.model, transport_type.type as transport,carcas_type.type as carcas,
specific_prim.lenght as len1,specific_prim.capacity as cap1, specific_second.lenght as len2,
specific_second.capacity as cap2, truck.car_num,truck.trailer_num,truck.driver,truck.`owner`
from user_cars
inner join truck on truck.id_truck=user_cars.id_truck
inner join truck_type on truck_type.id_truck_type=truck.id_truck_type
inner join transport_type on transport_type.id_tr=truck_type.id_tr
inner join carcas_type on carcas_type.id_carc=truck_type.id_car
inner join specific_prim on specific_prim.id_truck=user_cars.id_truck
left join specific_second on specific_second.id_truck=user_cars.id_truck
where user_cars.id_user=$id;");
        if ($res->num_rows!=0) {
            $result = "<table border='1'><tr><td>Марка</td><td>Модель</td><td>Тип транспорта</td><td>Тип кузова</td><td>№ головы</td>";
            $result .= "<td>Длина1</td><td>Объем1</td><td>Длина2</td><td>Объем2</td>";
            $result .= "<td>№ прицепа</td><td>Водитель</td><td>Владелец</td></tr>";
            while ($row = $res->fetch_assoc()) {
                $result.="<tr><td>".$row['make']."</td><td>".$row['model']."</td><td>".$row['transport']."</td><td>".$row['carcas']."</td>";
                $result.="<td>".$row['len1']."</td><td>".$row['cap1']."</td><td>".$row['len2']."</td><td>".$row['cap2']."</td>";
                $result.="<td>".$row['car_num']."</td><td>".$row['trailer_num']."</td><td>".$row['driver']."</td>";
                $result.="<td>".$row['owner']."</td></tr>";
            }
            $mysqli->close();
            $result.="</table>";
        }
        else{
            $result = "Не обнурежено машин в автопарке";
        }
        return $result;
    }
 }