xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$actualizaSistemasT24" element="ns0:actualizaSistemasT24" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:actualizaSistemasT24Response" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizaSistemasT24Out/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";

declare function xf:actualizaSistemasT24Out($actualizaSistemasT24 as element(ns0:actualizaSistemasT24), $countryId as xs:string, $errorCode as xs:string, $validationMessage as xs:string)
    as element(ns0:actualizaSistemasT24Response) {
        <ns0:actualizaSistemasT24Response>
                              <UUID>{ string($actualizaSistemasT24/CUSTOMER_DATA/CUSTOMER_INFO/UUID/text()) }</UUID>
                              <CUSTOMER_ID>{ fn:tokenize($actualizaSistemasT24/CUSTOMER_DATA/CUSTOMER_INFO/CUSTOMER_ID,'#')[1] }</CUSTOMER_ID>
                              <TARGET_SYSTEM>T24</TARGET_SYSTEM>
                              <COUNTRY_ID>{ $countryId }</COUNTRY_ID>
                              <OBSERVATION>{ concat($errorCode,$validationMessage) }</OBSERVATION>
        </ns0:actualizaSistemasT24Response>
};

declare variable $actualizaSistemasT24 as element(ns0:actualizaSistemasT24) external;
declare variable $countryId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:actualizaSistemasT24Out($actualizaSistemasT24,$countryId,$errorCode,$validationMessage )