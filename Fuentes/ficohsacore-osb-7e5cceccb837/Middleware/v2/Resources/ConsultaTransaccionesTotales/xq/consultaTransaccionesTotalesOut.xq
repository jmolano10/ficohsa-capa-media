(:: pragma bea:global-element-parameter parameter="$consultaDeTransaccionesTotalesResponse1" element="ns0:ConsultaDeTransaccionesTotalesResponse" location="../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransaccionesTotalesResponse" location="../xsd/consultaTransaccionesTotalesTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionesTotalesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionesTotales/xq/consultaTransaccionesTotalesOut/";

declare function xf:consultaTransaccionesTotalesOut($consultaDeTransaccionesTotalesResponse1 as element(ns0:ConsultaDeTransaccionesTotalesResponse))
    as element(ns1:consultaTransaccionesTotalesResponse) {
        <ns1:consultaTransaccionesTotalesResponse>
            <TOTAL>
                <CURRENCY>{ data($consultaDeTransaccionesTotalesResponse1/FICOSELLBUYTOTAVAFXWSType[1]/gFICOSELLBUYTOTAVAFXWSDetailType/mFICOSELLBUYTOTAVAFXWSDetailType[1]/CURRENCY) }</CURRENCY>
                <TOTAL_SALES>{ data($consultaDeTransaccionesTotalesResponse1/FICOSELLBUYTOTAVAFXWSType[1]/gFICOSELLBUYTOTAVAFXWSDetailType/mFICOSELLBUYTOTAVAFXWSDetailType[1]/TOTALSALES) }</TOTAL_SALES>
                <TOTAL_PURCHASES>{ data($consultaDeTransaccionesTotalesResponse1/FICOSELLBUYTOTAVAFXWSType[1]/gFICOSELLBUYTOTAVAFXWSDetailType/mFICOSELLBUYTOTAVAFXWSDetailType[1]/TOTALPURCHASES) }</TOTAL_PURCHASES>
                <AVAILABLE>{ data($consultaDeTransaccionesTotalesResponse1/FICOSELLBUYTOTAVAFXWSType[1]/gFICOSELLBUYTOTAVAFXWSDetailType/mFICOSELLBUYTOTAVAFXWSDetailType[1]/AVAILABLE) }</AVAILABLE>
            </TOTAL>
        </ns1:consultaTransaccionesTotalesResponse>
};

declare variable $consultaDeTransaccionesTotalesResponse1 as element(ns0:ConsultaDeTransaccionesTotalesResponse) external;

xf:consultaTransaccionesTotalesOut($consultaDeTransaccionesTotalesResponse1)