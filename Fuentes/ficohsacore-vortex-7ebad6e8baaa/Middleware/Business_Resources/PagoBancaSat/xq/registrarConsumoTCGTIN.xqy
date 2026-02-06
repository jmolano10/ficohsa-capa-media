xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$RequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoBancaSatRequest1" element="ns1:pagoBancaSatRequest" location="../xsd/pagoBancaSatTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsumoNOR" location="../../../v2/BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoBancaSatTypes";
declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/registrarConsumoTCGTIN/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		     $data/con:password/text()
 };


declare function xf:registrarConsumoTCGTIN($RequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoBancaSatRequest1 as element(ns1:pagoBancaSatRequest),
    $SecuenciaObtenida as xs:string,
    $DescripcionConsumo as xs:string)
    as element(ns0:ConsumoNOR) {
        <ns0:ConsumoNOR>
            {
                for $CREDIT_CARD in $pagoBancaSatRequest1/CREDIT_CARD_PAYMENT_INFO/CREDIT_CARD
                return
                    <ns0:noTarjetaCredito>{ data($CREDIT_CARD) }</ns0:noTarjetaCredito>
            }
            {
                for $EXPIRATION_DATE in $pagoBancaSatRequest1/CREDIT_CARD_PAYMENT_INFO/EXPIRATION_DATE
         
                return
                    <ns0:FechaExpiracion>{string($EXPIRATION_DATE) }</ns0:FechaExpiracion>
            }
            <ns0:montoConsumo>{ fn:string($pagoBancaSatRequest1/PAYMENT_AMOUNT/text()) }</ns0:montoConsumo>
            <ns0:monedaConsumo>{ 
            
            	let $PAYMENT_CURRENCY := fn:string($pagoBancaSatRequest1/BILL_INFORMATION/CURRENCY/text())
            	return
            	if ($PAYMENT_CURRENCY = "GTQ") then (
            		320
            	) else if ($PAYMENT_CURRENCY = "USD") then (
            		840
            	) else (
            		0
            	)
								
			 }</ns0:monedaConsumo>
            <ns0:DescripcionConsumo>{ $DescripcionConsumo }</ns0:DescripcionConsumo>
            <ns0:canalConsumo>{ fn-bea:fail-over( getUsername(data($RequestHeader1/Authentication/UserName)), 
									data($RequestHeader1/UserName)) }</ns0:canalConsumo>
            <ns0:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns0:fechaConsumo>
            <ns0:idRefConsumo>{ $SecuenciaObtenida }</ns0:idRefConsumo>
        </ns0:ConsumoNOR>
};

declare variable $RequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoBancaSatRequest1 as element(ns1:pagoBancaSatRequest) external;
declare variable $SecuenciaObtenida as xs:string external;
declare variable $DescripcionConsumo as xs:string external;

xf:registrarConsumoTCGTIN($RequestHeader1,
    $pagoBancaSatRequest1,
    $SecuenciaObtenida,
    $DescripcionConsumo)