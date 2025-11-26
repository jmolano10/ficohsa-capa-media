(:: pragma  parameter="$ParametersIn" type="anyType" ::)
(:: pragma bea:schema-type-return type="ns0:serviceRequest" location="../../xsds/EnrutadorConvenios/XMLSchema_-1423180259.xsd" ::)

declare namespace ns1 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/PagoRecaudoEnrutadorIn2/";

declare function xf:PagoRecaudoEnrutadorIn2($ParametersIn as element(*),
    $contractId as xs:string)
    as element() {
        <ns0:serviceRequest>
            <requestData>{ fn-bea:serialize($ParametersIn) }</requestData>                                  
        </ns0:serviceRequest>
};

declare variable $ParametersIn as element(*) external;
declare variable $contractId as xs:string external;

xf:PagoRecaudoEnrutadorIn2($ParametersIn,
    $contractId)