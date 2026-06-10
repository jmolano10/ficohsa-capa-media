<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validateUserByUserNameMessageOut" element="ns1:ValidateUserByUserNameMessageOut" location="../../../BusinessServices/ICB/usersValidationCustomService/wsdl/UsersValidationCustomService.svc.singleWsdl.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "urn:tailored.icbanking.services.administration.users";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuariosSistema/xq/validateUserByUserNameHedaerOut/";

declare function getSuccessIndicator($result as xs:string) as xs:string {
	if ($result != "") then "Success"
	else "NO RECORDS"
};

declare function getMessages($result as xs:string) as xs:string {
	if ($result != "") then ""
	else "0 records returned"
};


declare function xf:validateUserByUserNameHedaerOut($validateUserByUserNameMessageOut as element(ns1:ValidateUserByUserNameMessageOut))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ getSuccessIndicator(data($validateUserByUserNameMessageOut/ns1:DocumentNumber)) }</successIndicator>
            <messages>{ getMessages(data($validateUserByUserNameMessageOut/ns1:DocumentNumber)) }</messages>
        </ns0:ResponseHeader>
};

declare variable $validateUserByUserNameMessageOut as element(ns1:ValidateUserByUserNameMessageOut) external;

xf:validateUserByUserNameHedaerOut($validateUserByUserNameMessageOut)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ICB/usersValidationCustomService/wsdl/UsersValidationCustomService.svc.singleWsdl.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ICB/usersValidationCustomService/wsdl/UsersValidationCustomService.svc.singleWsdl"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>