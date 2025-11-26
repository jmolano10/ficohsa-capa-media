(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTTResponse" element="ns0:ConsultadetransaccionTTResponse" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiolcyResponse" element="ns0:ConsultadetasadecambiolcyResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransaccionRTEResponse" location="../../xsds/ConsultaTransaccionRTE/ConsultaTransaccionRTE.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionRTETypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaTransaccionRTE/ConsultaTransaccionTTOut/";
declare namespace functx = "http://www.functx.com"; 

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

declare function xf:ConsultaTransaccionTTOut($consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse),
    $consultadetasadecambiolcyResponse as element(ns0:ConsultadetasadecambiolcyResponse))
    as element(ns1:consultaTransaccionRTEResponse) {
        <ns1:consultaTransaccionRTEResponse>
            {
                let $ID1 := fn:concat(fn:string($consultadetransaccionTTResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/ID/text()), '||')
                let $ID := substring($ID1, 1, functx:index-of-string-first($ID1,'||')-1)
                let $VALUEDATE := format-date(fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/VALUEDATE/text()))
                let $TRANSACTIONCODE1 := fn:concat(fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/TRANSACTIONCODE/text()), '||')
                let $TRANSACTIONCODE := substring($TRANSACTIONCODE1, 1, functx:index-of-string-first($TRANSACTIONCODE1,'||')-1)
                let $TRANSACTIONNAME1 := fn:concat(fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/TRANSACTIONNAME/text()), '||')
                let $TRANSACTIONNAME := substring($TRANSACTIONNAME1, 1, functx:index-of-string-first($TRANSACTIONNAME1,'||')-1)
                let $CURRENCY21 := fn:concat(fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CURRENCY2/text()), '||')
                let $CURRENCY2 := substring($CURRENCY21, 1, functx:index-of-string-first($CURRENCY21,'||')-1)
                let $AMOUNTLOCAL11 := fn:concat(fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTLOCAL1/text()), '||')
                let $AMOUNTLOCAL1 := substring($AMOUNTLOCAL11, 1, functx:index-of-string-first($AMOUNTLOCAL11,'||')-1)
                let $AMOUNTFCY11 := fn:concat(fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTFCY1/text()), '||')
                let $AMOUNTFCY1 := substring($AMOUNTFCY11, 1, functx:index-of-string-first($AMOUNTFCY11,'||')-1)
                let $BUYRATE1 := fn:concat(fn:string($consultadetasadecambiolcyResponse/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/BUYRATE/text()), '||')
                let $BUYRATE := substring($BUYRATE1, 1, functx:index-of-string-first($BUYRATE1,'||')-1)
                let $BRANCHCODE1 := fn:concat(fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/BRANCHCODE/text()), '||')
                let $BRANCHCODE := substring($BRANCHCODE1, 1, functx:index-of-string-first($BRANCHCODE1,'||')-1)
                let $BRANCHNAME1 := fn:concat(fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/BRANCHNAME/text()), '||')
                let $BRANCHNAME := substring($BRANCHNAME1, 1, functx:index-of-string-first($BRANCHNAME1,'||')-1)
                let $AMOUNT := if ($CURRENCY2 = "HNL") then ($AMOUNTLOCAL1) else ($AMOUNTFCY1)
                return
                	if($ID != "") then (
                    	<RTE_HEADER>{ concat($ID , "|" , $VALUEDATE , "|" , $TRANSACTIONCODE , "|" , $TRANSACTIONNAME , "|" , $AMOUNT , "|" , $BUYRATE , "|" , $BRANCHCODE , "|" , $BRANCHNAME , "|", "123") }</RTE_HEADER>
                    ) else ()
            }
        </ns1:consultaTransaccionRTEResponse>
};

declare variable $consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse) external;
declare variable $consultadetasadecambiolcyResponse as element(ns0:ConsultadetasadecambiolcyResponse) external;
declare function functx:index-of-string-first 
  ( $arg as xs:string? ,
    $substring as xs:string )  as xs:integer? {
       
  if (contains($arg, $substring))
  then string-length(substring-before($arg, $substring))+1
  else ()
 } ;

xf:ConsultaTransaccionTTOut($consultadetransaccionTTResponse,
    $consultadetasadecambiolcyResponse)