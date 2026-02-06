xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaComportamientoCuenta1" element="ns0:consultaComportamientoCuenta" location="../xsd/consultaComportamientoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataGT/conDatoComportamientoCuenta/xsd/conDatoComportamientoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComportamientoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoComportamientoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComportamientoCuenta/xq/conDatoComportamientoCuentaGTIn/";

declare function xf:conDatoComportamientoCuentaGTIn($consultaComportamientoCuenta1 as element(ns0:consultaComportamientoCuenta),
    $countryCode as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $countryCode }</ns1:Pais>
            {
                for $ORG in $consultaComportamientoCuenta1/ORG
                return
                if(string($ORG/text()) != "")then(
                	<ns1:Org>{ data($ORG) }</ns1:Org>
                )else()
            }
            <ns1:NumCuenta>{ data($consultaComportamientoCuenta1/CARD_NUMBER) }</ns1:NumCuenta>
        </ns1:InputParameters>
};

declare variable $consultaComportamientoCuenta1 as element(ns0:consultaComportamientoCuenta) external;
declare variable $countryCode as xs:string external;

xf:conDatoComportamientoCuentaGTIn($consultaComportamientoCuenta1,
    $countryCode)