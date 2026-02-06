xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoBancaSatRequest" element="ns2:pagoBancaSatRequest" location="../xsd/pagoBancaSatTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns3:AplicaCargoCuentaMessageIn" location="../../../v2/BusinessServices/ICB/BancaSatService/wsdl/BancaSatServiceSingle.wsdl" ::)

declare namespace ns6 = "urn:infocorp.framework.businessentities.common";
declare namespace ns5 = "urn:infocorp.framework.businessentities.security";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoBancaSatTypes";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/pagoBancaSatIn/";
declare namespace ns4 = "urn:infocorp.framework.services.common";
declare namespace ns3 = "urn:tailored.icbanking.services.bancasat";

declare function xf:pagoBancaSatIn($pagoBancaSatRequest as element(ns2:pagoBancaSatRequest))
    as element(ns3:AplicaCargoCuentaMessageIn) {
        <ns3:AplicaCargoCuentaMessageIn>
            <ns3:BancaSatUserId>{ data($pagoBancaSatRequest/USER_ID) }</ns3:BancaSatUserId>
            <ns3:DebitAccountNumber>{ data($pagoBancaSatRequest/DEBIT_ACCOUNT) }</ns3:DebitAccountNumber>
            <ns3:Description>Pago BSat</ns3:Description>
            <ns3:InterfaceReferenceNumber>{ data($pagoBancaSatRequest/TRANSACTION_REFERENCE) }</ns3:InterfaceReferenceNumber>
            <ns3:PaymentAmount>{ data($pagoBancaSatRequest/PAYMENT_AMOUNT) }</ns3:PaymentAmount>
            <ns3:Token>{ data($pagoBancaSatRequest/SESSION_TOKEN) }</ns3:Token>
            <ns3:TransactionTypeCode>{ data($pagoBancaSatRequest/TRANSACTION_TYPE) }</ns3:TransactionTypeCode>
        </ns3:AplicaCargoCuentaMessageIn>
};

declare variable $pagoBancaSatRequest as element(ns2:pagoBancaSatRequest) external;

xf:pagoBancaSatIn($pagoBancaSatRequest)