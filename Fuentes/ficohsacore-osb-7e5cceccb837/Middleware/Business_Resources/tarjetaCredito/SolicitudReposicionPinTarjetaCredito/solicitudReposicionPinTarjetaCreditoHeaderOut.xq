(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../Resources/SolicitudReposicionPinTarjetaCreditoT24/xsd/ORA_BANK_OSB_SOL_REPOSICION_PIN_TC_T24.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_SOL_REPOSICION_PIN_TC_T24/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudReposicionPinTarjetaCredito/solicitudReposicionPinTarjetaCreditoHeaderOut/";

declare function xf:solicitudReposicionPinTarjetaCreditoHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $ERROR_CODE in $outputParameters/ns1:ERROR_CODE
                return
                    <successIndicator>{ data($ERROR_CODE) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $outputParameters/ns1:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:solicitudReposicionPinTarjetaCreditoHeaderOut($outputParameters)