(:: pragma bea:global-element-parameter parameter="$consultadeMontoTSPResponse" element="ns1:ConsultadeMontoTSPResponse" location="../../../BusinessServices/T24/svcOperacionesTSP/xsd/XMLSchema_-163607763.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMultipleMontoTSPResponse" location="../../OperacionesTSP/xsd/operacionesTSPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTSPTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleMontoTSP/xq/consultaMultipleMontoTSPOut/";

declare function xf:consultaMultipleMontoTSPOut($consultadeMontoTSPResponse as element(ns1:ConsultadeMontoTSPResponse))
    as element(ns0:consultaMultipleMontoTSPResponse) {
        <ns0:consultaMultipleMontoTSPResponse>
            <TRANSACTIONS>
            {
                 for $responseTSP in $consultadeMontoTSPResponse/FICOTSPCONSULTAMONTOWSType[1]/gFICOTSPCONSULTAMONTOWSDetailType/mFICOTSPCONSULTAMONTOWSDetailType
                   return
                <TRANSACTION>
                    <TRANSACTION_ID>{ data($responseTSP/IdTransaccion) }</TRANSACTION_ID>
                    <TRANSACTION_REFERENCE>{ data($responseTSP/RefrenciaTransaccion) }</TRANSACTION_REFERENCE>
                    <RATABLE_INDICATOR>{ data($responseTSP/AplicaCobro) }</RATABLE_INDICATOR>
                    <NON_RATABLE_REASON>{ data($responseTSP/Motivo) }</NON_RATABLE_REASON>
                    <AMOUNT>{ data($responseTSP/Monto) }</AMOUNT>
                    <RATE_AMOUNT>{ data($responseTSP/MontoTSP) }</RATE_AMOUNT>
                    <CREDIT_ACCOUNT>{ data($responseTSP/CuentaCredito) }</CREDIT_ACCOUNT>
                    <SUCCESS_INDICATOR>{ data($responseTSP/Indicador) }</SUCCESS_INDICATOR>
                    <ERROR_MESSAGE>{ data($responseTSP/Error) }</ERROR_MESSAGE>
                </TRANSACTION>
             }   
            </TRANSACTIONS>
        </ns0:consultaMultipleMontoTSPResponse>
};

declare variable $consultadeMontoTSPResponse as element(ns1:ConsultadeMontoTSPResponse) external;

xf:consultaMultipleMontoTSPOut($consultadeMontoTSPResponse)
