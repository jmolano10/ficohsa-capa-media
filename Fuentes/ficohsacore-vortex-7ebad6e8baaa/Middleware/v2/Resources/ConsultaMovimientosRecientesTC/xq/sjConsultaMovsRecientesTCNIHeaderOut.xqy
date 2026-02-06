xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMovsRecientesTCNIResponse" element="ns0:sjConsultaMovsRecientesTCNIResponse" location="../../../BusinessServices/SJS/consultaMovsRecientesTCNI/xsd/sjConsultaMovsRecientesTCNI.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMovsRecientesTCNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/sjConsultaMovsRecientesTCNIHeaderOut/";

declare function xf:sjConsultaMovsRecientesTCNIHeaderOut($sjConsultaMovsRecientesTCNIResponse as element(ns0:sjConsultaMovsRecientesTCNIResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $SUCCESS_INDICATOR in $sjConsultaMovsRecientesTCNIResponse/SUCCESS_INDICATOR
                return
                    <successIndicator>{ data($SUCCESS_INDICATOR) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $sjConsultaMovsRecientesTCNIResponse/ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $sjConsultaMovsRecientesTCNIResponse as element(ns0:sjConsultaMovsRecientesTCNIResponse) external;

xf:sjConsultaMovsRecientesTCNIHeaderOut($sjConsultaMovsRecientesTCNIResponse)