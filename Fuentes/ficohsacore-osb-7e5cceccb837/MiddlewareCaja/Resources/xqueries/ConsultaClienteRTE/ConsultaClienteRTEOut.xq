(:: pragma bea:global-element-parameter parameter="$consultaperfildeclienteResponse" element="ns0:ConsultaperfildeclienteResponse" location="../../xsds/PerfilCliente/XMLSchema_-994245660.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteRTEResponse" location="../../xsds/ConsultaClienteRTE/ConsultaClienteRTE.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteRTETypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaClienteRTE/ConsultaClienteRTEOut/";
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

(:: Calcula la posición de la dirección del tipo deseado dentro del ADRRESSTYPE :)
declare function index-of-type( $addresstype as xs:string?, $type as xs:string?) 
	as xs:integer?{
	let $result := 
		for $item at $i in fn:tokenize($addresstype, '!!')
		return
			if(fn:string($item) = $type) then (
				$i
			) else ()
	return 
		if (fn:string($result[1]) = "" or $result[1] < 1) then (
			-1
		)  else (
			$result[1]
		)
};

declare function xf:ConsultaClienteRTEOut($consultaperfildeclienteResponse as element(ns0:ConsultaperfildeclienteResponse))
    as element(ns1:consultaClienteRTEResponse) {
        <ns1:consultaClienteRTEResponse>
            {
            	let $homeIndex := index-of-type(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/ADDRESSTYPE/text()), "1")
            	let $workIndex := index-of-type(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/ADDRESSTYPE/text()), "2")
            	let $sectorIndex := index-of-type(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/SECTORIZATIONTYPE/text()), "SB13")
            	let $LEGALDOCNAME1 :=  fn:concat(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/LEGALDOCNAME/text()), '||')
                let $LEGALDOCNAME := substring($LEGALDOCNAME1, 1, functx:index-of-string-first($LEGALDOCNAME1,'||')-1)
				let $LEGALID1 := fn:concat(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/LEGALID/text()), '||')
                let $LEGALID := substring($LEGALID1, 1, functx:index-of-string-first($LEGALID1,'||')-1)
				let $CUSTOMER1 := fn:concat(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/CUSTOMER/text()), '||')
                let $CUSTOMER := substring($CUSTOMER1, 1, functx:index-of-string-first($CUSTOMER1,'||')-1)
				let $SHORTNAME1 := fn:concat(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/SHORTNAME/text()), '||')
                let $SHORTNAME := substring($SHORTNAME1, 1, functx:index-of-string-first($SHORTNAME1,'||')-1)
				let $DATEOFBIRTH := format-date(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/DATEOFBIRTH/text()))
                let $GENDER1 := fn:concat(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/GENDER/text()), '||')
                let $GENDER := substring($GENDER1, 1, functx:index-of-string-first($GENDER1,'||')-1)
				let $COUNTRYCODE1 := fn:concat(fn:tokenize(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/COUNTRYCODE/text()),"!!")[$homeIndex], '||')
                let $COUNTRYCODE := substring($COUNTRYCODE1, 1, functx:index-of-string-first($COUNTRYCODE1,'||')-1)
				let $STATECODE1 := fn:concat(fn:tokenize(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/STATECODE/text()),"!!")[$homeIndex], '||')
                let $STATECODE := substring($STATECODE1, 1, functx:index-of-string-first($STATECODE1,'||')-1)
				let $CITYCODE1 := fn:concat(fn:tokenize(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/CITYCODE/text()),"!!")[$homeIndex], '||')
                let $CITYCODE := substring($CITYCODE1, 1, functx:index-of-string-first($CITYCODE1,'||')-1)
				let $ADDRESSLINE11 := fn:concat(fn:tokenize(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/ADDRESSLINE1/text()),"!!")[$homeIndex], '||')
                let $ADDRESSLINE1 := substring($ADDRESSLINE11, 1, functx:index-of-string-first($ADDRESSLINE11,'||')-1)
				let $ADDRESSLINE21 := fn:concat(fn:tokenize(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/ADDRESSLINE2/text()),"!!")[$homeIndex], '||')
                let $ADDRESSLINE2 := substring($ADDRESSLINE21, 1, functx:index-of-string-first($ADDRESSLINE21,'||')-1)
				let $HOME_PHONE1 := fn:concat(fn:tokenize(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/PHONE/text()),"!!")[$homeIndex], '||')
                let $HOME_PHONE := substring($HOME_PHONE1, 1, functx:index-of-string-first($HOME_PHONE1,'||')-1)
				let $WORK_PHONE1 := fn:concat(fn:tokenize(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/PHONE/text()),"!!")[$workIndex], '||')
                let $WORK_PHONE := substring($WORK_PHONE1, 1, functx:index-of-string-first($WORK_PHONE1,'||')-1)
				let $PROFESSIONORTRADE1 := fn:concat(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/PROFESSIONORTRADE/text()), '||')
                let $PROFESSIONORTRADE := substring($PROFESSIONORTRADE1, 1, functx:index-of-string-first($PROFESSIONORTRADE1,'||')-1)
				let $EMPLOYERSNAME1 := fn:concat(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/EMPLOYERSNAME/text()), '||')
                let $EMPLOYERSNAME := substring($EMPLOYERSNAME1, 1, functx:index-of-string-first($EMPLOYERSNAME1,'||')-1)
				let $SECTORIZATIONCODE1 := fn:concat(fn:tokenize(fn:string($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/gWSCUSTOMERFULLDetailType/mWSCUSTOMERFULLDetailType[1]/SECTORIZATIONCODE/text()),"!!")[$sectorIndex], '||')
                let $SECTORIZATIONCODE := substring($SECTORIZATIONCODE1, 1, functx:index-of-string-first($SECTORIZATIONCODE1,'||')-1)
				return
                	if($CUSTOMER != "") then (
                    	<RTE_HEADER>{ concat($LEGALDOCNAME , "|" , $LEGALID , "|" , $SHORTNAME , "|" , $DATEOFBIRTH , "|" , $GENDER , "|" , $COUNTRYCODE , "|" , $COUNTRYCODE , "|" , $STATECODE , "|" , $CITYCODE , "|" , $ADDRESSLINE1 , $ADDRESSLINE2 , "|" , $HOME_PHONE , "|" , $PROFESSIONORTRADE , "|" , $EMPLOYERSNAME , "|" , $WORK_PHONE , "|" , $SECTORIZATIONCODE) }</RTE_HEADER>
                    ) else ()
            }
        </ns1:consultaClienteRTEResponse>
};

declare variable $consultaperfildeclienteResponse as element(ns0:ConsultaperfildeclienteResponse) external;
declare function functx:index-of-string-first 
  ( $arg as xs:string? ,
    $substring as xs:string )  as xs:integer? {
       
  if (contains($arg, $substring))
  then string-length(substring-before($arg, $substring))+1
  else ()
 } ;
 
xf:ConsultaClienteRTEOut($consultaperfildeclienteResponse)