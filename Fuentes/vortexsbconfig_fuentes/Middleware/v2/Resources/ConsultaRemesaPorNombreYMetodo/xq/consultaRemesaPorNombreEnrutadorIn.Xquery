<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma  parameter="$ParametersIn" type="xs:anyType" ::)
(:: pragma bea:schema-type-return type="ns0:serviceRequest" location="../../../BusinessServices/enrutadorConvenios/xsd/XMLSchema_-1423180259.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/EnrutadorConveniosIn/";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";

declare function xf:EnrutadorConveniosIn($ParametersIn as element(*))
    as element() {
        &lt;ns0:serviceRequest>
            &lt;requestData>{ data($ParametersIn) }&lt;/requestData>                                  
        &lt;/ns0:serviceRequest>
};

declare variable $ParametersIn as element(*) external;

xf:EnrutadorConveniosIn($ParametersIn)</con:xquery>
    <con:dependency location="../../../BusinessServices/enrutadorConvenios/xsd/XMLSchema_-1423180259.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/enrutadorConvenios/xsd/XMLSchema_-1423180259"/>
    </con:dependency>
</con:xqueryEntry>