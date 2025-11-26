(:: pragma bea:global-element-parameter parameter="$envioTransferenciasACH1" element="ns1:envioTransferenciasACH" location="../xsd/envioTransferenciasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SendDebitHNL" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/envioTransferenciasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioTransferenciasACH/xq/envioTransferenciasACHHNLIn/";

declare function xf:envioTransferenciasACHHNLIn($envioTransferenciasACH1 as element(ns1:envioTransferenciasACH))
    as element(ns0:SendDebitHNL) {
        <ns0:SendDebitHNL>
            <ns0:vReceivingBankId>{ data($envioTransferenciasACH1/BANK_ID) }</ns0:vReceivingBankId>
            <ns0:vRemittanceArray>{ data($envioTransferenciasACH1/TRANSACTION/DESCRIPTION) }</ns0:vRemittanceArray>
            <ns0:vInstruction>{ data($envioTransferenciasACH1/TRANSACTION/REFERENCE) }</ns0:vInstruction>
            <ns0:vOriginatorId>{ data($envioTransferenciasACH1/ORIGINATOR/ID) }</ns0:vOriginatorId>
            <ns0:vOriginatorAccount>{ data($envioTransferenciasACH1/ORIGINATOR/ACCOUNT) }</ns0:vOriginatorAccount>
            <ns0:vOriginatorAccountType>{ data($envioTransferenciasACH1/ORIGINATOR/ACCOUNT_TYPE) }</ns0:vOriginatorAccountType>
            <ns0:vOriginatorName>{ data($envioTransferenciasACH1/ORIGINATOR/NAME) }</ns0:vOriginatorName>
            <ns0:vReceivingId>{ data($envioTransferenciasACH1/BENEFICIARY/ID) }</ns0:vReceivingId>
            <ns0:vDestinationAccount>{ data($envioTransferenciasACH1/BENEFICIARY/ACCOUNT) }</ns0:vDestinationAccount>
            <ns0:vDestinationAccountType>{ data($envioTransferenciasACH1/BENEFICIARY/ACCOUNT_TYPE) }</ns0:vDestinationAccountType>
            <ns0:vRecipientName>{ data($envioTransferenciasACH1/BENEFICIARY/NAME) }</ns0:vRecipientName>
            <ns0:vAmount>{ data($envioTransferenciasACH1/TRANSACTION/AMOUNT) }</ns0:vAmount>
        </ns0:SendDebitHNL>
};

declare variable $envioTransferenciasACH1 as element(ns1:envioTransferenciasACH) external;

xf:envioTransferenciasACHHNLIn($envioTransferenciasACH1)