xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$ParametersIn" type="xs:anyType" ::)
(:: pragma bea:schema-type-return type="ns0:serviceRequest" location="../../../BusinessServices/enrutadorConvenios/xsd/XMLSchema_-1423180259.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/EnrutadorConveniosIn/";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";

declare function xf:EnrutadorConveniosIn($ParametersIn as element(*))
    as element() {
        <ns0:serviceRequest>
            <requestData>{ data($ParametersIn) }</requestData>                                  
        </ns0:serviceRequest>
};

declare variable $ParametersIn as element(*) external;

xf:EnrutadorConveniosIn($ParametersIn)