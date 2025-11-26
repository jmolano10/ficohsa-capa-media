(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ConsultaMovimientosCajero/ConsultaMovimientosCajero_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMovimientosCajero";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaMovimientosCajero/ConsultaMovsCajeroIn/";

declare function xf:ConsultaMovsCajeroIn($requestHeader1 as element(ns1:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TELLERID>{ data($requestHeader1/TellerInfo/TellerId) }</ns0:PV_TELLERID>
            <ns0:PV_BRANCHCODE>{ data($requestHeader1/TellerInfo/BranchCode) }</ns0:PV_BRANCHCODE>
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;

xf:ConsultaMovsCajeroIn($requestHeader1)