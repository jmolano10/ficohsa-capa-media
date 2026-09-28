(:: pragma bea:global-element-parameter parameter="$consultaCuentaBeneficios" element="ns0:consultaCuentaBeneficios" location="../xsd/consultaCuentaBeneficiosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/consultaCuentaBeneficios/xsd/ConsultaCuentaBeneficios_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaBeneficiosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCuentaBeneficios";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaBeneficios/xq/consultaCtaBeneficioIn/";

declare function xf:consultaCtaBeneficioIn($consultaCuentaBeneficios as element(ns0:consultaCuentaBeneficios),
    $ACCOUNT_STATUS as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $ACCOUNT_NUMBER in $consultaCuentaBeneficios/ACCOUNT_NUMBER
                return
                    <ns1:PV_ACCOUNT_NUMBER>{ data(string($ACCOUNT_NUMBER)) }</ns1:PV_ACCOUNT_NUMBER>
            }
            <ns1:PV_ACCOUNT_STATUS>{ $ACCOUNT_STATUS }</ns1:PV_ACCOUNT_STATUS>
        </ns1:InputParameters>
};

declare variable $consultaCuentaBeneficios as element(ns0:consultaCuentaBeneficios) external;
declare variable $ACCOUNT_STATUS as xs:string external;

xf:consultaCtaBeneficioIn($consultaCuentaBeneficios,
    $ACCOUNT_STATUS)