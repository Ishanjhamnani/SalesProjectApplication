<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Place Order</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
body{margin:0;font-family:Arial;background:#0f172a;color:white;}
.container{display:flex;}
.content{flex:1;padding:30px;}
input,button{padding:10px;margin:5px;}
</style>
</head>

<body>
<div class="container">
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp"/>
    <div class="content">
        <h2>Place Order</h2>

        <p>Customer ID:</p>
        <input id="customerId"/>

        <p>Product ID:</p>
        <input id="productId"/>

        <p>Quantity:</p>
        <input id="qty"/>

        <button onclick="placeOrder()">Place Order</button>
    </div>
</div>

<script>
function placeOrder(){
    const data = {
        customerId: $('#customerId').val(),
        items:[
            {
                productId: $('#productId').val(),
                quantity: $('#qty').val()
            }
        ]
    };

    $.ajax({
        url:'/orders/place',
        type:'POST',
        contentType:'application/json',
        data: JSON.stringify(data),
        success:function(res){
            alert("Order placed. ID = " + res.orderId);
        },
        error:function(){
            alert("Order failed");
        }
    });
}
</script>

</body>
</html>