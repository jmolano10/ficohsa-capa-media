(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTFSResponse" element="ns0:ConsultadetransaccionTFSResponse" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiolcyResponse" element="ns0:ConsultadetasadecambiolcyResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransaccionRTEResponse" location="../../xsds/ConsultaTransaccionRTE/ConsultaTransaccionRTE.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionRTETypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaTransaccionRTE/ConsultaTransaccionTFSOut/";
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

declare function xf:ConsultaTransaccionTFSOut($consultadetransaccionTFSResponse as element(ns0:ConsultadetransaccionTFSResponse),
    $consultadetasadecambiolcyResponse as element(ns0:ConsultadetasadecambiolcyResponse))
    as element(ns1:consultaTransaccionRTEResponse) {
        <ns1:consultaTransaccionRTEResponse>
            {	
            	
                let $ID1 := fn:concat(fn:string($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/ID/text()), '||')
                let $ID := substring($ID1, 1, functx:index-of-string-first($ID1,'||')-1)
                let $BOOKINGDATE := format-date(fn:string($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/BOOKINGDATE/text()))
                let $ORIGTXN1 := fn:concat(fn:string($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/ORIGTXN/text()), '||')
				let $ORIGTXN := substring($ORIGTXN1, 1, functx:index-of-string-first($ORIGTXN1,'||')-1)
                let $TXNDESC1 := fn:concat(fn:string($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/TXNDESC/text()), '||')
				let $TXNDESC := substring($TXNDESC1, 1, functx:index-of-string-first($TXNDESC1,'||')-1)
                let $TXNAMOUNT1 := fn:concat(fn:string($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/TXNAMOUNT/text()), '||')
				let $TXNAMOUNT := substring($TXNAMOUNT1, 1, functx:index-of-string-first($TXNAMOUNT1,'||')-1)
                let $BUYRATE1 := fn:concat(fn:string($consultadetasadecambiolcyResponse/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/BUYRATE/text()), '||')
				let $BUYRATE := substring($BUYRATE1, 1, functx:index-of-string-first($BUYRATE1,'||')-1)
                let $BRANCHCODE1 := fn:concat(fn:string($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/BRANCHCODE/text()), '||')
				let $BRANCHCODE := substring($BRANCHCODE1, 1, functx:index-of-string-first($BRANCHCODE1,'||')-1)
                let $BRANCHNAME1 := fn:concat(fn:string($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/BRANCHNAME/text()), '||')
				let $BRANCHNAME := substring($BRANCHNAME1, 1, functx:index-of-string-first($BRANCHNAME1,'||')-1)
                let $PRIMARYACCOUNT1 := fn:concat(fn:string($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/PRIMARYACCOUNT/text()), '||')
				let $PRIMARYACCOUNT := substring($PRIMARYACCOUNT1, 1, functx:index-of-string-first($PRIMARYACCOUNT1,'||')-1)
                return
                if($ID != "") then (
                	<RTE_HEADER>{ concat($ID , "|" , $BOOKINGDATE , "|" , $ORIGTXN , "|" , $TXNDESC , "|" , $TXNAMOUNT , "|" , $BUYRATE , "|" , $BRANCHCODE , "|" , $BRANCHNAME , "|" , $PRIMARYACCOUNT) }</RTE_HEADER>
                ) else ()
            }
        </ns1:consultaTransaccionRTEResponse>
};

declare variable $consultadetransaccionTFSResponse as element(ns0:ConsultadetransaccionTFSResponse) external;
declare variable $consultadetasadecambiolcyResponse as element(ns0:ConsultadetasadecambiolcyResponse) external;
declare function functx:index-of-string-first 
  ( $arg as xs:string? ,
    $substring as xs:string )  as xs:integer? {
       
  if (contains($arg, $substring))
  then string-length(substring-before($arg, $substring))+1
  else ()
 } ;
 
xf:ConsultaTransaccionTFSOut($consultadetransaccionTFSResponse,
    $consultadetasadecambiolcyResponse)