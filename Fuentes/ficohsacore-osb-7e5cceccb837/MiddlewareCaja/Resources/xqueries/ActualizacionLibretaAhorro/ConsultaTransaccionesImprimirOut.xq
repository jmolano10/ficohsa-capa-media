(:: pragma bea:global-element-parameter parameter="$tellerPassbookEnquiryResponse" element="ns0:TellerPassbookEnquiryResponse" location="../../xsds/BkFicPBookEnq/XMLSchema_-1374990530.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizacionLibretaAhorroResponse" location="../../xsds/ActualizacionLibretaAhorro/ActualizacionLibretaAhorro.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionLibretaAhorroTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActualizacionLibretaAhorro/ConsultaTransaccionesImprimirOut/";

(:: Se encarga de rellenar a la izquierda hasta completar el tamaño solicitado. Si el tamaño deseado es menor al
 string a rellenar, se devuelve el string a completar:)
declare function left-pad 
  ( $stringToPad as xs:string? ,
    $padChar as xs:string ,
    $length as xs:integer )  as xs:string {
    if(string-length($stringToPad) > $length) then (
    	$stringToPad
    ) else (
	   substring(
	     string-join (
	       (for $i in (1 to ($length - string-length($stringToPad))) return $padChar, $stringToPad)
	       ,'')
	    ,1,$length)
	)
 };
 
(:: Se encarga de rellenar a la derecha hasta completar el tamaño solicitado. Si el tamaño deseado es menor al
 string a rellenar, se devuelve el string a completar:)
declare function right-pad 
  ( $stringToPad as xs:string? ,
    $padChar as xs:string ,
    $length as xs:integer )  as xs:string {
    if(string-length($stringToPad) > $length) then (
    	$stringToPad
    ) else (
	   substring(
	     string-join (
	       ($stringToPad, for $i in (1 to $length) return $padChar)
	       ,'')
	    ,1,$length)
	)
 };
 
(:: Recibe string que representa una fecha en formato yyyyMMdd. Retorna string que representa fecha en formato ddMMyyyy :)
declare function format-date( $date as xs:string?) 
	as xs:string {
	if ( fn-bea:trim(fn:string($date)) != "") then ( 
		fn-bea:fail-over(concat(
			substring($date, 7, 2), "/", substring($date, 5, 2), "/", substring($date, 1, 4)), "")
	) else (
		""
	)
};

(:: Se encarga de repetir n veces el caracter enviado :)
declare function repeat-string 
  ( $stringToRepeat as xs:string? ,
    $count as xs:integer )  as xs:string {
       
   string-join((for $i in 1 to $count return $stringToRepeat),
                        '')
 } ;
 
declare function xf:ConsultaTransaccionesImprimirOut($tellerPassbookEnquiryResponse as element(ns0:TellerPassbookEnquiryResponse),
    $registros as xs:int,
    $registrosPorImprimir as xs:int,
    $next_passbook_line as xs:int)
    as element(ns1:actualizacionLibretaAhorroResponse) {
        <ns1:actualizacionLibretaAhorroResponse>
            {
                let $result :=
                    for $i in (1 to min( ($registros, count($tellerPassbookEnquiryResponse/NOFILETTTWSEXPType[1]/gNOFILETTTWSEXPDetailType/mNOFILETTTWSEXPDetailType)) ))
                    return
                    	let $mNOFILETTTWSEXPDetailType := $tellerPassbookEnquiryResponse/NOFILETTTWSEXPType[1]/gNOFILETTTWSEXPDetailType/mNOFILETTTWSEXPDetailType[$i]
                    	let $TXNAMOUNT := left-pad(fn-bea:format-number(abs(number(tokenize($mNOFILETTTWSEXPDetailType/TXNAMOUNT, "\|")[1])), "#,###,##0.00"),"*",16)
                    	let $ENTRYDATE := format-date($mNOFILETTTWSEXPDetailType/ENTRYDATE)
                    	let $TXNDESC := data($mNOFILETTTWSEXPDetailType/TXNDESC)
                    	let $NEWBALANCE := left-pad(fn-bea:format-number(abs(number(tokenize($mNOFILETTTWSEXPDetailType/TXNAMOUNT, "\|")[2])), "#,###,##0.00"),"*",16)
                    	let $NROLINE := $next_passbook_line + $i -1
                    	return
	                        if( number(tokenize($mNOFILETTTWSEXPDetailType/TXNAMOUNT, "\|")[1]) > 0 ) then (
	                        	if( $NROLINE = 11 and $next_passbook_line != 11 ) then (
	                        		concat("!!@54@ ",$NROLINE," ",$ENTRYDATE," ",$TXNDESC," ","@87@ ",$TXNAMOUNT,"@100@ ",$NEWBALANCE)
	                        	) else (
	                        		concat("!@54@ ",$NROLINE," ",$ENTRYDATE," ",$TXNDESC," ","@87@ ",$TXNAMOUNT,"@100@ ",$NEWBALANCE)
	                        	)
	                        ) else (
	                        	if( $NROLINE = 11 and $next_passbook_line != 11 ) then (
	                        		concat("!!@54@ ",$NROLINE," ",$ENTRYDATE," ",$TXNDESC," ","@74@ ",$TXNAMOUNT,"@100@ ",$NEWBALANCE)
	                        	) else (
	                        		concat("!@54@ ",$NROLINE," ",$ENTRYDATE," ",$TXNDESC," ","@74@ ",$TXNAMOUNT,"@100@ ",$NEWBALANCE)
	                        	)
	                        )
                return
                	let $Detail := concat(repeat-string ('!', ($next_passbook_line - 1)), string-join($result,''))
                	return
                	if($next_passbook_line <= 10)then (
                    	<PASSBOOK_DETAIL>{ data($Detail) }</PASSBOOK_DETAIL>
                    )else(
                    	<PASSBOOK_DETAIL>{  concat("!",$Detail) }</PASSBOOK_DETAIL>
                    )
            }
            {
            	let $registrosPendientes := $registrosPorImprimir - $registros
            	return
	            	if($registrosPendientes > 0) then (
	            		<TELLER_MESSAGE>{ "Siga actualizando; Aun hay txns pend." }</TELLER_MESSAGE>
	            	) else (
	            		<TELLER_MESSAGE>Ya no hay movimientos pendientes</TELLER_MESSAGE>
	            	)
            }
        </ns1:actualizacionLibretaAhorroResponse>
};

declare variable $tellerPassbookEnquiryResponse as element(ns0:TellerPassbookEnquiryResponse) external;
declare variable $registros as xs:int external;
declare variable $registrosPorImprimir as xs:int external;
declare variable $next_passbook_line as xs:int external;

xf:ConsultaTransaccionesImprimirOut($tellerPassbookEnquiryResponse,
    $registros,
    $registrosPorImprimir,
    $next_passbook_line)