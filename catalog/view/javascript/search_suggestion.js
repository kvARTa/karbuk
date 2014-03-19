//var orfFilter = (function () {
//
//    var $delChar = /[\!&\?\/]/,
//        $countErrorWords = 0,
//        $errorWords = {"b":true, "d":true, "yt":true, "jy":true, "yf":true, "z":true, "xnj":true, "c":true, "cj":true, "njn":true, ",snm":true, "f":true, "dtcm":true, "'nj":true, "rfr":true, "jyf":true, "gj":true, "yj":true, "jyb":true, "r":true, "e":true, "ns":true, "bp":true, "pf":true, "ds":true, "nfr":true, ";t":true, "jn":true, "crfpfnm":true, "'njn":true, "rjnjhsq":true, "vjxm":true, "xtkjdtr":true, "j":true, "jlby":true, "tot":true, ",s":true, "nfrjq":true, "njkmrj":true, "ct,z":true, "cdjt":true, "rfrjq":true, "rjulf":true, "e;t":true, "lkz":true, "djn":true, "rnj":true, "lf":true, "ujdjhbnm":true, "ujl":true, "pyfnm":true, "vjq":true, "lj":true, "bkb":true, "tckb":true, "dhtvz":true, "herf":true, "ytn":true, "cfvsq":true, "yb":true, "cnfnm":true, ",jkmijq":true, "lf;t":true, "lheujq":true, "yfi":true, "cdjq":true, "ye":true, "gjl":true, "ult":true, "ltkj":true, "tcnm":true, "cfv":true, "hfp":true, "xnj,s":true, "ldf":true, "nfv":true, "xtv":true, "ukfp":true, ";bpym":true, "gthdsq":true, "ltym":true, "nenf":true, "ybxnj":true, "gjnjv":true, "jxtym":true, "[jntnm":true, "kb":true, "ghb":true, "ujkjdf":true, "yflj":true, ",tp":true, "dbltnm":true, "blnb":true, "ntgthm":true, "nj;t":true, "cnjznm":true, "lheu":true, "ljv":true, "ctqxfc":true, "vj;yj":true, "gjckt":true, "ckjdj":true, "pltcm":true, "levfnm":true, "vtcnj":true, "cghjcbnm":true, "xthtp":true, "kbwj":true, "njulf":true, "dtlm":true, "[jhjibq":true, "rf;lsq":true, "yjdsq":true, ";bnm":true, "ljk;ys":true, "cvjnhtnm":true, "gjxtve":true, "gjnjve":true, "cnjhjyf":true, "ghjcnj":true, "yjuf":true, "cbltnm":true, "gjyznm":true, "bvtnm":true, "rjytxysq":true, "ltkfnm":true, "dlheu":true, "yfl":true, "dpznm":true, "ybrnj":true, "cltkfnm":true, "ldthm":true, "gthtl":true, "ye;ysq":true, "gjybvfnm":true, "rfpfnmcz":true, "hf,jnf":true, "nhb":true, "dfi":true, "e;":true, "ptvkz":true, "rjytw":true, "ytcrjkmrj":true, "xfc":true, "ujkjc":true, "ujhjl":true, "gjcktlybq":true, "gjrf":true, "[jhjij":true, "ghbdtn":true, "pljhjdj":true, "pljhjdf":true, "ntcn":true, "yjdjq":true, "jr":true, "tuj":true, "rjt":true, "kb,j":true, "xnjkb":true, "ndj.":true, "ndjz":true, "nen":true, "zcyj":true, "gjyznyj":true, "x`":true, "xt":true},
//        $expectWord = {"\.ьу":"/me"},
//        $arrReplace = {"q":"й","w":"ц","e":"у","r":"к","t":"е","y":"н","u":"г","i":"ш","o":"щ","p":"з","[":"х","]":"ъ","a":"ф","s":"ы","d":"в","f":"а","g":"п","h":"р","j":"о","k":"л","l":"д",";":"ж","'":"э","z":"я","x":"ч","c":"с","v":"м","b":"и","n":"т","m":"ь",",":"б",".":"ю","/":".","`":"ё","Q":"Й","W":"Ц","E":"У","R":"К","T":"Е","Y":"Н","U":"Г","I":"Ш","O":"Щ","P":"З","{":"Х","}":"Ъ","A":"Ф","S":"Ы","D":"В","F":"А","G":"П","H":"Р","J":"О","K":"Л","L":"Д",":":"^","\"":"Э","|":"/","Z":"Я","X":"Ч","C":"С","V":"М","B":"И","N":"Т","M":"Ь","<":"Б",">":"Ю","?":",","~":"Ё","@":"\"","#":"№","$":";","^":":","&":"?","й":"q","ц":"w","у":"e","к":"r","е":"t","н":"y","г":"u","ш":"i","щ":"o","з":"p","х":"[","ъ":"]","ф":"a","ы":"s","в":"d","а":"f","п":"g","р":"h","о":"j","л":"k","д":"l","ж":";","э":"'","я":"z","ч":"x","с":"c","м":"v","и":"b","т":"n","ь":"m","б":",","ю":".","ё":"`","Й":"Q","Ц":"W","У":"E","К":"R","Е":"T","Н":"Y","Г":"U","Ш":"I","Щ":"O","З":"P","Х":"{","Ъ":"}","Ф":"A","Ы":"S","В":"D","А":"F","П":"G","Р":"H","О":"J","Л":"K","Д":"L","Ж":":","Э":"\"","Я":"Z","Ч":"X","С":"C","М":"V","И":"B","Т":"N","Ь":"M","Б":"<","Ю":">","Ё":"~","№":"#"};
//
//    return function ($string){
//        var result = $string.toLowerCase().replace($delChar,'').split(/\s+/);
//        var $countError=0;
//        for(var i=0;i<result.length;i++){
//            if($errorWords[result[i]])
//                $countError++;
//        }
//        if ($countError< $countErrorWords)
//            return $string;
//        result='';
//        for(i=0;i<$string.length;i++){
//            result += $arrReplace[$string.charAt(i)] || $string.charAt(i);
//        }
//        for(i in $expectWord){
//            result = result.replace(new RegExp(i), $expectWord[i]);
//        }
//        return result;
//
//    }
//})();
$(document).ready(function () {
    var searchInput = $('#search input[name="filter_name"]');
    var keywordList = $('#keywordList');
//    var map = {
//        'q' : 'й', 'w' : 'ц', 'e' : 'у', 'r' : 'к', 't' : 'е', 'y' : 'н', 'u' : 'г', 'i' : 'ш', 'o' : 'щ', 'p' : 'з', '[' : 'х', ']' : 'ъ', 'a' : 'ф', 's' : 'ы', 'd' : 'в', 'f' : 'а', 'g' : 'п', 'h' : 'р', 'j' : 'о', 'k' : 'л', 'l' : 'д', ';' : 'ж', '\'' : 'э', 'z' : 'я', 'x' : 'ч', 'c' : 'с', 'v' : 'м', 'b' : 'и', 'n' : 'т', 'm' : 'ь', ',' : 'б', '.' : 'ю','Q' : 'Й', 'W' : 'Ц', 'E' : 'У', 'R' : 'К', 'T' : 'Е', 'Y' : 'Н', 'U' : 'Г', 'I' : 'Ш', 'O' : 'Щ', 'P' : 'З', '[' : 'Х', ']' : 'Ъ', 'A' : 'Ф', 'S' : 'Ы', 'D' : 'В', 'F' : 'А', 'G' : 'П', 'H' : 'Р', 'J' : 'О', 'K' : 'Л', 'L' : 'Д', ';' : 'Ж', '\'' : 'Э', 'Z' : '?', 'X' : 'ч', 'C' : 'С', 'V' : 'М', 'B' : 'И', 'N' : 'Т', 'M' : 'Ь', ',' : 'Б', '.' : 'Ю',
//    };
//
//
//    searchInput.on('keyup', function () {
//        var str = searchInput.val();
//        var result = '';
//        for (var i = 0; i < str.length; i++) {
//            result += map[str.charAt(i)] || str.charAt(i);
//        }
//        searchInput.val(result);
//    });
    searchInput.autocomplete({
        source: function (request, response) {
//            if ($("#switch").length === 0) {
//                $("#search").css('position', 'relative');
//                $("#search").append('<a href="#" id="switch" style="position: absolute; top: 10px; right: 80px">Сменить расскладку</a>');
//            }
//            $("#switch").click(function(){
//                request.term = orfFilter(request.term);
//                searchInput.val(orfFilter(request.term));
//            });
//            var fineVersion = orfFilter(request.term);
//            searchInput.val(fineVersion);
//            request.term = orfFilter(request.term);
            $.ajax({
                url: 'index.php?route=product/search_json',
                dataType: 'json',
                data: {
                    keyword: request.term
                },
                success: function (json) {
                    response($.map(json, function (item) {
                        return {
                            label: item.name,
                            price: item.price,
                            special: item.special,
                            value: item.href,
                            img: item.thumb,
                            typeResult: item.typeResult,
                            keywordList: item.keywordList
                        }
                    }));
                }
            });
        },
        minLength: 1,
        select: function (event, ui) {
            if (ui.item.value == "") {
                return false;
            } else {
                location.href = ui.item.value;
                return false;
            }
        },
        open: function () {
            $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
        },
        close: function () {
            $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
        },
        focus: function (event, ui) {
            $('#search input[name="filter_name"]').val(ui.item.label);
            return false;
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        var product_img = '';
        var nameItem = '<div class="name">' + item.label + '</div>';

        $("div .button-search").mouseover(function() {
            searchInput.val(item.keywordList);
        });
        $('div .button-search').keypress(function(event){
            var keyCode = event.keyCode ? event.keyCode :
                event.charCode ? event.charCode :
                    event.which ? event.which : void 0;

            //if pressed "Enter" key
            if(keyCode == 13)
            {
                searchInput.val(item.keywordList);
            }
        });


        switch (item.typeResult) {
            case 'category' :
                if (item.img || item.img == '') {
                    product_img = item.img ? '<img src="' + item.img + '">' : '<img src="/image/data/search/category.png">';
                }
                nameItem = '<div class="name" style="font-weight: bold">' + item.label + '</div>';
                break;
            case 'product' :
                if (item.img || item.img == '') {
                    product_img = item.img ? '<img src="' + item.img + '">' : '<img src="/image/cache/no_image-100x100.jpg">';
                }
                break;
        }
        var product_price = item.special ? '<span class="price-old">' + item.price + '</span><span class="price-new">' + item.special + '</span>' : item.price;
        product_price = (product_price === undefined) ? '' : product_price;
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append('<a class="product-list-sa"><div class="image">' + product_img + '</div>' + nameItem + '<div class="price">' + product_price + '</div></a>')
            .appendTo(ul);
    };
});
