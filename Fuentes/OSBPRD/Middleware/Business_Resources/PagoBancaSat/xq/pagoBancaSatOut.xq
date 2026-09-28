(:: pragma bea:global-element-parameter parameter="$aplicaCargoCuentaMessageOut" element="ns4:AplicaCargoCuentaMessageOut" location="../../../v2/BusinessServices/ICB/BancaSatService/wsdl/BancaSatServiceSingle.wsdl" ::)
(:: pragma bea:global-element-return element="ns3:pagoBancaSatResponse" location="../xsd/pagoBancaSatTypes.xsd" ::)

declare namespace ns6 = "urn:infocorp.framework.businessentities.security";
declare namespace ns5 = "urn:infocorp.framework.services.common";
declare namespace ns8 = "urn:Infocorp.framework.services.common";
declare namespace ns7 = "urn:infocorp.framework.businessentities.common";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "urn:infocorp.framework.businessentities.logging";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/pagoBancaSatOut/";
declare namespace ns4 = "urn:tailored.icbanking.services.bancasat";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/pagoBancaSatTypes";

declare function xf:pagoBancaSatOut($aplicaCargoCuentaMessageOut as element(ns4:AplicaCargoCuentaMessageOut))
    as element(ns3:pagoBancaSatResponse) {
        <ns3:pagoBancaSatResponse>
            {
                for $debited_account in $aplicaCargoCuentaMessageOut/ns4:debited_account
                return
                    <DEBIT_ACCOUNT>{ data($debited_account) }</DEBIT_ACCOUNT>
            }
            {
                for $charged_amount in $aplicaCargoCuentaMessageOut/ns4:charged_amount
                return
                    <PAYMENT_AMOUNT>{ data($charged_amount) }</PAYMENT_AMOUNT>
            }
            {
                for $currency in $aplicaCargoCuentaMessageOut/ns4:currency
                return
                    <CURRENCY>{ data($currency) }</CURRENCY>
            }
        </ns3:pagoBancaSatResponse>
};

declare variable $aplicaCargoCuentaMessageOut as element(ns4:AplicaCargoCuentaMessageOut) external;

xf:pagoBancaSatOut($aplicaCargoCuentaMessageOut)