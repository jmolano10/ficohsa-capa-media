(:: pragma bea:global-element-parameter parameter="$consultaSeguros" element="ns1:consultaSeguros" location="../xsd/consultaSegurosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CLIENTDATA/consultaSeguros/xsd/consultaSeguros_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSegurosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSeguros";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSeguros/xq/consultaSegurosIn/";

declare function xf:consultaSegurosIn($consultaSeguros as element(ns1:consultaSeguros),
    $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ACCOUNT_NUMBER>{ data($consultaSeguros/ACCOUNT_NUMBER) }</ns0:PV_ACCOUNT_NUMBER>
            <ns0:PV_ORG>{ data($consultaSeguros/ORG) }</ns0:PV_ORG>
            <ns0:PV_COUNTRY_CODE>{ $countryCode }</ns0:PV_COUNTRY_CODE>
        </ns0:InputParameters>
};

declare variable $consultaSeguros as element(ns1:consultaSeguros) external;
declare variable $countryCode as xs:string external;

xf:consultaSegurosIn($consultaSeguros,
    $countryCode)