xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$parametersIn" type="xs:anyType" ::)
(:: pragma bea:schema-type-return type="ns0:serviceRequest" location="../../xsds/EnrutadorConvenios/XMLSchema_-1423180259.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeDepositoGarantia/pagoRecaudoEnrutador/";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";

declare function xf:pagoRecaudoEnrutador($parametersIn as element(*))
    as element() {
         <ns0:serviceRequest>
            <requestData>{ fn-bea:serialize($parametersIn) }</requestData>                                  
        </ns0:serviceRequest>
};

declare variable $parametersIn as element(*) external;

xf:pagoRecaudoEnrutador($parametersIn)
