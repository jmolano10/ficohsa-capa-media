(:: pragma bea:global-element-parameter parameter="$consultaAnticipoSalarioResponse1" element="ns0:ConsultaAnticipoSalarioResponse" location="../../../BusinessServices/T24/AnticipoSalario/xsd/AnticipoSalarioTypes02.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesAdvanceSalaryHeaderOUT/";

declare function xf:consultaComisionesAdvanceSalaryHeaderOUT($consultaAnticipoSalarioResponse1 as element(ns0:ConsultaAnticipoSalarioResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultaAnticipoSalarioResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultaAnticipoSalarioResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultaAnticipoSalarioResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultaAnticipoSalarioResponse1 as element(ns0:ConsultaAnticipoSalarioResponse) external;

xf:consultaComisionesAdvanceSalaryHeaderOUT($consultaAnticipoSalarioResponse1)