
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/parsearTramaCB/";

declare function xf:parsearTramaCB($trama as xs:string,
    $posicion as xs:int)
    as xs:string {
        		let $messageListFM := fn:tokenize($trama,"@FM")
        		return($messageListFM[$posicion])

};

declare variable $trama as xs:string external;
declare variable $posicion as xs:int external;

xf:parsearTramaCB($trama,
    $posicion)
