$(()=> {        
    init()
    window.addEventListener("message", (event)=> {

        if (event.data.showMenu == true){
            $("#app").fadeIn("fast")            
        }else {
            $("#app").fadeOut("fast")
        }

    })

    document.onkeyup = function(data) {
        if (data.which == 27) {          
            $.post("https://extra_lojas/close", JSON.stringify({}))
        }        
    };

    


    $("#comidas").click(()=>{

        $("#c-bebidas").fadeOut("fast");        
        $("#c-comidas").fadeIn("fast");

    })

    $("#bebidas").click(()=>{

        $("#c-comidas").fadeOut("fast");        
        $("#c-bebidas").fadeIn("fast");

    })

    $("#all").click(()=>{

        $("#c-comidas").fadeIn("fast");        
        $("#c-bebidas").fadeIn("fast");

    })

    $("#close").click(()=>{
        $.post("https://extra_lojas/close", JSON.stringify({}))
    });

    $("#close-modal").click(()=>{

        $(".modal").fadeOut();

    });

})


function init(){

    $(".btn").each(function (i, obj) { 

        if ($(this).attr("data-action")) {

            $(this).click(function(){
                
                var data = $(this).data("action");                                         
                $(".modal").fadeIn();
                
                $("#comprar").click(()=>{
                    $.post('http://extra_lojas/click-item', JSON.stringify({data}));
                    $(".modal").fadeOut();
                });

            })

        }

    })

}