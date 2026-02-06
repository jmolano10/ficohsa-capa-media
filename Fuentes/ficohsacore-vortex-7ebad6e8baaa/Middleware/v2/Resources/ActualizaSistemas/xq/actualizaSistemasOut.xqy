xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaSistemas1" element="ns0:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:actualizaSistemasResponse" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizaSistemasOut/";

declare function xf:actualizaSistemasOut($actualizaSistemas1 as element(ns0:actualizaSistemas), $targetSytem as xs:string, $countryId as xs:string, $errorCode as xs:string, $validationMessage as xs:string)
    as element(ns0:actualizaSistemasResponse) {
        <ns0:actualizaSistemasResponse>
        {
                let $actualizaSistemas := $actualizaSistemas1/CUSTOMER_DATA
                return(
                    for $uuid in $actualizaSistemas/CUSTOMER_INFO/INFO[NAME = 'UUID']
                    return  
                              <UUID>{ data($uuid/VALUE) }</UUID>,
                    for $customerId in $actualizaSistemas/CUSTOMER_INFO/INFO[NAME = 'CUSTOMER_ID']
                    return  
                              <CUSTOMER_ID>{ data($customerId/VALUE) }</CUSTOMER_ID>,
                              <TARGET_SYSTEM>{ $targetSytem }</TARGET_SYSTEM>,
                              <COUNTRY_ID>{ $countryId  }</COUNTRY_ID>,
                              <OBSERVATION>{ concat($errorCode,$validationMessage) }</OBSERVATION>
                      )
            }
        </ns0:actualizaSistemasResponse>
};

declare variable $actualizaSistemas1 as element(ns0:actualizaSistemas) external;
declare variable $targetSytem as xs:string external;
declare variable $countryId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:actualizaSistemasOut($actualizaSistemas1, $targetSytem,$countryId,$errorCode,$validationMessage)