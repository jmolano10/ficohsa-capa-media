xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getRemittancesType";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittancesType/getRemittancesType_sp.xsd" ::)

declare variable $remittanceKey as xs:string external;
declare variable $user as xs:string external;

declare function local:func($remittanceKey as xs:string, 
                            $user as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_CLAVE>{fn:data($remittanceKey)}</ns1:PV_CLAVE>
        <ns1:PV_USUARIO_SERVICIO>{fn:data($user)}</ns1:PV_USUARIO_SERVICIO>
    </ns1:InputParameters>
};

local:func($remittanceKey, $user)
