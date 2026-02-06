xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$crearOrdenEmpaqueResponse" element="ns0:crearOrdenEmpaqueResponse" location="../../../BusinessServices/OrdenEmpaqueCloud/wsdl/ordenEmpaqueCloud.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ordenEmpaqueTDResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_crearOrdenEmpaque";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OrdenEmpaqueTD/xq/ordenEmpaqueTDOut/";

declare function xf:ordenEmpaqueTDOut($crearOrdenEmpaqueResponse as element(ns0:crearOrdenEmpaqueResponse))
    as element(ns1:ordenEmpaqueTDResponse) {
        <ns1:ordenEmpaqueTDResponse>
            {
                for $OrdenEmpaque in $crearOrdenEmpaqueResponse/ns0:result/ns0:OrdenEmpaque
                return
                    <REFERENCE_NUMBER>{ data($OrdenEmpaque) }</REFERENCE_NUMBER>
            }
        </ns1:ordenEmpaqueTDResponse>
};

declare variable $crearOrdenEmpaqueResponse as element(ns0:crearOrdenEmpaqueResponse) external;

xf:ordenEmpaqueTDOut($crearOrdenEmpaqueResponse)