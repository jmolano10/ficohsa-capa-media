xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/PaymentCollectionAbanks";
(:: import schema at "../../../../ProviderServices/XSD/PaymentCollectionAbanks/PaymentCollectionAbanks_sp.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";


declare variable $uuid as xs:string external;
declare variable $fundsTransferType as element() external;
declare variable $cuenta as xs:string external;
declare variable $authorizationCode as xs:string external;
declare variable $paymentCollectionrequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $paymentCollectionAbanksResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $getCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::) external;

declare function local:func($uuid as xs:string,
                            $fundsTransferType as element(), 
                            $cuenta as xs:string, 
                            $authorizationCode as xs:string, 
                            $paymentCollectionrequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $paymentCollectionAbanksResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $getCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::)) 
                            as element() (:: schema-element(ns1:paymentCollectionResponse) ::) {
    <ns1:paymentCollectionResponse>
          <ns1:StatusInfo>
              <com:Status>Success</com:Status>
              <com:TransactionId>Prueba1</com:TransactionId>
              <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
              <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
              <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
          </ns1:StatusInfo>
          <ns1:paymentCollectionResponse>
            {
                for $PV_NOMBRE_CONTRATO in $paymentCollectionAbanksResponse/ns2:PV_NOMBRE_CONTRATO
                return
                    <ns1:ContractName>{ data($PV_NOMBRE_CONTRATO) }</ns1:ContractName>
            }
            {
                for $PV_NOMBRE_DEUDOR in $paymentCollectionAbanksResponse/ns2:PV_NOMBRE_DEUDOR
                return
                    <ns1:DebtorName>{ data($PV_NOMBRE_DEUDOR) }</ns1:DebtorName>
            }
            {
                let $result :=
                    for $INPUTTER in $fundsTransferType/gINPUTTER/INPUTTER
                    return
                        <ns1:Inputter>{ fn:tokenize(data($INPUTTER), "_")[2] }</ns1:Inputter>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $fundsTransferType/gDATETIME/DATETIME
                    return
                        <ns1:DateTime>{ concat("20",data($DATETIME)) }</ns1:DateTime>
                return
                    $result[1]
            }
            {
                for $USERAGENCYNAME in $getCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYNAME
                return
                    <ns1:BranchName>{ data($USERAGENCYNAME) }</ns1:BranchName>
            }
            <ns1:PaymentInformation>
                <ns1:PaymentMethod>{ data($fundsTransferType/LRPAYTYPE) }</ns1:PaymentMethod>
                <ns1:PaymentCurrency>{ data($paymentCollectionrequest/ns1:PaymentInformation/ns1:PaymentCurrency) }</ns1:PaymentCurrency>
                {
                    for $DEBITAMOUNT in $fundsTransferType/DEBITAMOUNT
                    return
                        <ns1:PaymentAmount>{ data($DEBITAMOUNT) }</ns1:PaymentAmount>
                }
                {
                    let $DEBITACCTNO := fn:string($cuenta)
                    return
                    	if ( $DEBITACCTNO != "") then (
                        	<ns1:DebitAccount>{ $DEBITACCTNO }</ns1:DebitAccount>
                        ) else ()
                }                                               
                {
                    for $CHEQUENUMBER in $fundsTransferType/CHEQUENUMBER
                    return
                        <ns1:ChequeNumber>{ data($CHEQUENUMBER) }</ns1:ChequeNumber>
                }
            </ns1:PaymentInformation>      
            {
                for $PV_RECIBO in $paymentCollectionAbanksResponse/ns2:PV_RECIBO
                return
                    <ns1:BillDetail>{ data($PV_RECIBO) }</ns1:BillDetail>
            }
            { if($authorizationCode!='')
             then 
             <ns1:ReferenceId>{$authorizationCode}</ns1:ReferenceId>
             else
             <ns1:ReferenceId></ns1:ReferenceId>
            }
            </ns1:paymentCollectionResponse>
    </ns1:paymentCollectionResponse>
};

local:func($uuid, $fundsTransferType, $cuenta, $authorizationCode, $paymentCollectionrequest, $paymentCollectionAbanksResponse, $getCoreParametersResponse)