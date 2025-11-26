(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns3:OutputParameters" location="../../../../BusinessServices/AbanksGT/PagoPolizaSeguro/xsd/MCPagoPolizaSeguro_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:billPaymentResponse" location="../../xsd/BillOperationsTypes.xsd" ::)


declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/billOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillPayment/xq/billPaymentInsuranceIVEGTOut/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCPagoPolizaSeguro";

declare function xf:billPaymentInsuranceIVEGTOut($outputParameters as element(ns3:OutputParameters),
    $contractId as xs:string,
    $debtorCode as xs:string)
    as element(ns1:billPaymentResponse) {
        <ns1:billPaymentResponse>
            <ns1:CONTRACT_ID>{ data($contractId) }</ns1:CONTRACT_ID>
            <ns1:DEBTOR_CODE>{ data($debtorCode) }</ns1:DEBTOR_CODE>
            {
              if(empty($outputParameters/ns3:PR_TRANSACTION_INFO/*)) then(
                 )else(
            <ns1:TRANSACTION_INFO>
                <ns2:DEALSLIP>
                 {
                     for $dsRecord in $outputParameters/ns3:PR_TRANSACTION_INFO/ns3:DEALSLIP/ns3:DS_RECORD/ns3:DS_RECORD_ITEM
                     return
                    <ns2:DS_RECORD>{ data($dsRecord) }</ns2:DS_RECORD>
                  }
                </ns2:DEALSLIP>
                <ns2:TXN_REF_ID>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:TXN_REF_ID) }</ns2:TXN_REF_ID>
                <ns2:TXN_TYPE_ID>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:TXN_TYPE_ID) }</ns2:TXN_TYPE_ID>
                <ns2:TXN_DATE>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:TXN_DATE) }</ns2:TXN_DATE>
                <ns2:CURRENCY>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:CURRENCY) }</ns2:CURRENCY>
                <ns2:AMOUNT>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:AMOUNT) }</ns2:AMOUNT>
                <ns2:DATE_TIME>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:DATE_TIME) }</ns2:DATE_TIME>
                <ns2:USER>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:USER_TX) }</ns2:USER>
                <ns2:BRANCH_ID>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:BRANCH_ID) }</ns2:BRANCH_ID>
                <ns2:BRANCH_NAME>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:BRANCH_NAME) }</ns2:BRANCH_NAME>
                <ns2:REQUIRES_CTR>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:REQUIRES_CTR) }</ns2:REQUIRES_CTR>
                <ns2:DEALSLIP_URL>{ data($outputParameters/ns3:PR_TRANSACTION_INFO/ns3:DEALSLIP_URL) }</ns2:DEALSLIP_URL>
            </ns1:TRANSACTION_INFO>
            )
            }
        </ns1:billPaymentResponse>
};

declare variable $outputParameters as element(ns3:OutputParameters) external;
declare variable $contractId as xs:string external;
declare variable $debtorCode as xs:string external;

xf:billPaymentInsuranceIVEGTOut($outputParameters,
    $contractId,
    $debtorCode)