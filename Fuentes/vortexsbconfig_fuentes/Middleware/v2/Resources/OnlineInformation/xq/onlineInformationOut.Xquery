<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$onlineInformationResponse" element="ns1:OnlineInformationResponse" location="../../../BusinessServices/VisionPlusHN/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:onlineInformationResponse" location="../xsd/onlineInformationTypes.xsd" ::)

declare namespace ns1 = "http://www.procesa.com/fdcs/ot";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/onlineInformationTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OnlineInformation/xq/onlineInformationOut/";

declare function xf:onlineInformationOut($onlineInformationResponse as element(ns1:OnlineInformationResponse))
    as element(ns0:onlineInformationResponse) {
        <ns0:onlineInformationResponse>
            <ReasonActionCode>{ data($onlineInformationResponse/ReasonActionCode) }</ReasonActionCode>
            <ActionDescription>{ data($onlineInformationResponse/ActionDescription) }</ActionDescription>
            <AvailableCredit>{ data($onlineInformationResponse/AvailableCredit) }</AvailableCredit>
            <AmountMemoCredit>{ data($onlineInformationResponse/AmountMemoCredit) }</AmountMemoCredit>
            <AccountCurrentBalance>{ data($onlineInformationResponse/AccountCurrentBalance) }</AccountCurrentBalance>
            <AmountMemoDebit>{ data($onlineInformationResponse/AmountMemoDebit) }</AmountMemoDebit>
        </ns0:onlineInformationResponse>
};

declare variable $onlineInformationResponse as element(ns1:OnlineInformationResponse) external;

xf:onlineInformationOut($onlineInformationResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlusHN/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlusHN/onlineTransactions_v4/wsdl/OnlineTransactions_v4"/>
    </con:dependency>
    <con:dependency location="../xsd/onlineInformationTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OnlineInformation/xsd/onlineInformationTypes"/>
    </con:dependency>
</con:xqueryEntry>