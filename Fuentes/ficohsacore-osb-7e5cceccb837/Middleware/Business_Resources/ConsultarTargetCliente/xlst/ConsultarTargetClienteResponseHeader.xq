(:: pragma bea:global-element-parameter parameter="$consultaTargetClienteResponse1" element="ns1:ConsultaTargetClienteResponse" location="../xsd/svcGetTargetFromAccount_TypeArray.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../xsd/GetTargetFromAccountTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/GetTargetFromAccountTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultarTargetCliente/xlst/ConsultarTargetClienteResponseHeader/";

declare function xf:ConsultarTargetClienteResponseHeader($consultaTargetClienteResponse1 as element(ns1:ConsultaTargetClienteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ data($consultaTargetClienteResponse1/Status/successIndicator) }</successIndicator>
        </ns0:ResponseHeader>
};

declare variable $consultaTargetClienteResponse1 as element(ns1:ConsultaTargetClienteResponse) external;

xf:ConsultarTargetClienteResponseHeader($consultaTargetClienteResponse1)