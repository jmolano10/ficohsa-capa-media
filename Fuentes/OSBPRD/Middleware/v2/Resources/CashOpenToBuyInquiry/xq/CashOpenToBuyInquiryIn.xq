(:: pragma bea:global-element-parameter parameter="$cashOpenToBuyInquiry" element="ns0:cashOpenToBuyInquiry" location="../xsd/cashOpenToBuyInquiryTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CashOTBInquiryRequest" location="../../../BusinessServices/VisionPlusHN/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cashOpenToBuyInquiryTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CashOpenToBuyInquiry/xq/CashOpenToBuyInquiryIn/";

declare function xf:CashOpenToBuyInquiryIn($cashOpenToBuyInquiry as element(ns0:cashOpenToBuyInquiry))
    as element(ns1:CashOTBInquiryRequest) {
        <ns1:CashOTBInquiryRequest>
        {
        	for $OrgNumber in $cashOpenToBuyInquiry/OrgNumber
        	return
        	<OrgNumber>{ data($OrgNumber) }</OrgNumber>        	
        }
        {
        	for $ForeignUse in $cashOpenToBuyInquiry/ForeignUse
        	return
        	<ForeignUse>{ data($ForeignUse) }</ForeignUse>        	
        }
        {
        	for $AccountNumber in $cashOpenToBuyInquiry/AccountNumber
        	return
        	<AccountNumber>{ data($AccountNumber) }</AccountNumber>
        }
        </ns1:CashOTBInquiryRequest>
};

declare variable $cashOpenToBuyInquiry as element(ns0:cashOpenToBuyInquiry) external;

xf:CashOpenToBuyInquiryIn($cashOpenToBuyInquiry)