<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadechequeconfirmadoResponse1" element="ns0:ConsultadechequeconfirmadoResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequeConfirmado/consultaChequeConfirmadoHeaderOut/";

declare function xf:consultaChequeConfirmadoHeaderOut($consultadechequeconfirmadoResponse1 as element(ns0:ConsultadechequeconfirmadoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>{ data($consultadechequeconfirmadoResponse1/Status/successIndicator) }</successIndicator>
        	{
            	if (empty($consultadechequeconfirmadoResponse1/WSLATAMAGCHEQUECONFIRMBROWENQType[1]/ZERORECORDS/text())) then (
            		<messages>{ data($consultadechequeconfirmadoResponse1/Status/messages) }</messages>
            	) else (
            		<messages>{ data($consultadechequeconfirmadoResponse1/WSLATAMAGCHEQUECONFIRMBROWENQType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadechequeconfirmadoResponse1 as element(ns0:ConsultadechequeconfirmadoResponse) external;

xf:consultaChequeConfirmadoHeaderOut($consultadechequeconfirmadoResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-1265051491.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCheque/Resources/XMLSchema_-1265051491"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>