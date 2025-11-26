(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/emisionChequesGerencia/xsd/emisionChequesGerencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/emisionChequesGerencia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EmisionChequesGerencia/xq/emisionChequesGerenciaGTHeaderOut/";

declare function xf:emisionChequesGerenciaGTHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                let $successIndicator := fn:string($outputParameters/ns1:ERROR_CODE/text())
                let $transactionID := fn:string($outputParameters/ns1:TRANSACTION_ID/text())
                let $valueDate := fn:string($outputParameters/ns1:VALUE_DATE/text())
                let $message := fn:string($outputParameters/ns1:ERROR_MESSAGE/text())
                return 
                    if (fn:upper-case($successIndicator)  = "SUCCESS") then (
                        <transactionId>{ $transactionID }</transactionId>,
                        <successIndicator>Success</successIndicator>,
                        <valueDate>{ $valueDate }</valueDate>
                    ) else (
                        <successIndicator>{ $successIndicator }</successIndicator>,
                        <messages>{ $message }</messages>
                    ) 
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:emisionChequesGerenciaGTHeaderOut($outputParameters)
