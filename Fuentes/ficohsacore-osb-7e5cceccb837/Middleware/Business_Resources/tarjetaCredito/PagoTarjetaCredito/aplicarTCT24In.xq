(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoReq" element="ns1:pagoTarjetaCredito" location="pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoResponse" element="ns1:pagoTarjetaCreditoResponse" location="pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)

declare namespace ns3 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/aplicarTCT24In/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };


declare function local:generateReference() as xs:string
{    
	let $mytimestamp := fn:current-dateTime() cast as xs:string
	let $result := fn:concat(fn:substring($mytimestamp,9,2),
	                         fn:substring($mytimestamp,12,2),
	                         fn:substring($mytimestamp,15,2),
	                         fn:substring($mytimestamp,18,2),
	                         fn:substring($mytimestamp,21,2))  
	return $result
};

declare function local:getVASACurrencyCode($currency as xs:string) as xs:string
{
	let $result := if ($currency ="HNL") then ("340") else if ($currency ="USD") then ("840") else ("")
	return $result 	 
};

declare function xf:aplicarTCT24In($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),$pagoTarjetaCreditoReq as element(ns1:pagoTarjetaCredito),
    $pagodetarjetadecreditoResponse as element(ns3:PagodetarjetadecreditoResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_OPERACION>1</ns0:PN_OPERACION>
            <ns0:PN_MONTO>{ data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/LROTHAMT) }</ns0:PN_MONTO>
            <ns0:PN_NUM_TARJETA>{ data($pagoTarjetaCreditoReq/CREDIT_CARD_NUMBER) }</ns0:PN_NUM_TARJETA>
            <ns0:PN_MONEDA>{ local:getVASACurrencyCode(data($pagoTarjetaCreditoReq/BALANCE_CURRENCY)) }</ns0:PN_MONEDA>
            <ns0:PN_FORMAPAGO>1</ns0:PN_FORMAPAGO>
            <ns0:PN_CODIGOREVERSION/>
            <ns0:PV_CANAL>{ fn-bea:fail-over( local:getUsername(data($autenticacionRequestHeader/UserName)),
            											  data($autenticacionRequestHeader/UserName)) }</ns0:PV_CANAL>
            <ns0:PV_FECHA>{fn:substring(fn:concat("20",$pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME[1]),1,8)}</ns0:PV_FECHA>
            <ns0:PV_FECHAEXP/>
           {
                for $LRCRDCARDSEQ in $pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/LRCRDCARDSEQ
                return
                    <ns2:PN_NUMREFERENCIA>{ data($LRCRDCARDSEQ) }</ns2:PN_NUMREFERENCIA>
            }
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoTarjetaCreditoReq as element(ns1:pagoTarjetaCredito) external;
declare variable $pagodetarjetadecreditoResponse as element(ns3:PagodetarjetadecreditoResponse) external;

xf:aplicarTCT24In($autenticacionRequestHeader,
$pagoTarjetaCreditoReq,
    $pagodetarjetadecreditoResponse)