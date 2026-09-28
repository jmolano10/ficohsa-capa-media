(:: pragma bea:global-element-parameter parameter="$desembolsoporcreditoacuentaResponse" element="ns0:DesembolsoporcreditoacuentaResponse" location="../../../BusinessServices/T24/DesembolsoPrestamoCreditoCuenta/xsd/svcDesembolsoPrestamoCredCtaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/desembolsoPorCreditoACuentaHeaderOut/";

declare function xf:desembolsoPorCreditoACuentaHeaderOut($desembolsoporcreditoacuentaResponse as element(ns0:DesembolsoporcreditoacuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $desembolsoporcreditoacuentaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $desembolsoporcreditoacuentaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $desembolsoporcreditoacuentaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $desembolsoporcreditoacuentaResponse as element(ns0:DesembolsoporcreditoacuentaResponse) external;

xf:desembolsoPorCreditoACuentaHeaderOut($desembolsoporcreditoacuentaResponse)