(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns3:pagoTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagodetarjetadecreditoResponse" element="ns1:PagodetarjetadecreditoResponse" location="../../../../Business_Resources/tarjetaCredito/Resources/XMLSchema_-604480245.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../Business_Resources/tarjetaCredito/Resources/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCredito/xq/aplicarTCT24In/";

declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function local:getVASACurrencyCode($currency as xs:string) as xs:string
{
	let $result := if ($currency ="HNL") then ("340") else if ($currency ="USD") then ("840") else ("")
	return $result 	 
};

declare function xf:aplicarTCT24In($requestHeader as element(ns0:RequestHeader),
    $pagoTarjetaCredito as element(ns3:pagoTarjetaCredito),
    $pagodetarjetadecreditoResponse as element(ns1:PagodetarjetadecreditoResponse))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PN_OPERACION>1</ns2:PN_OPERACION>
            <ns2:PN_MONTO>{ data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/LROTHAMT) }</ns2:PN_MONTO>
            <ns2:PN_NUM_TARJETA>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns2:PN_NUM_TARJETA>
            <ns2:PN_MONEDA>{ local:getVASACurrencyCode(data($pagoTarjetaCredito/BALANCE_CURRENCY)) }</ns2:PN_MONEDA>
            <ns2:PN_FORMAPAGO>1</ns2:PN_FORMAPAGO>
            <ns2:PV_CANAL>
                {
                    fn-bea:fail-over( local:getUsername(data($requestHeader/Authentication/UserName)),
                    data($requestHeader/Authentication/UserName))
                }
</ns2:PV_CANAL>
            <ns2:PV_FECHA>{ fn:substring(fn:concat("20",$pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME[1]),1,8) }</ns2:PV_FECHA>
            {
                for $LRCRDCARDSEQ in $pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/LRCRDCARDSEQ
                return
                    <ns2:PN_NUMREFERENCIA>{ data($LRCRDCARDSEQ) }</ns2:PN_NUMREFERENCIA>
            }
        </ns2:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoTarjetaCredito as element(ns3:pagoTarjetaCredito) external;
declare variable $pagodetarjetadecreditoResponse as element(ns1:PagodetarjetadecreditoResponse) external;

xf:aplicarTCT24In($requestHeader,
    $pagoTarjetaCredito,
    $pagodetarjetadecreditoResponse)
