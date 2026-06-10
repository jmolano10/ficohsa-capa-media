<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadebloqueosporTDResponse1" element="ns0:ConsultadebloqueosporTDResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleSaldosPignorados/xq/consultaDetalleSaldosPignoradosHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:consultaDetalleSaldosPignoradosHeaderOut($consultadebloqueosporTDResponse1 as element(ns0:ConsultadebloqueosporTDResponse))
    as element(ns1:ResponseHeader) {
         <ns1:ResponseHeader>
		{
			if (empty($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ZERORECORDS/text())) then (
				<successIndicator>{ data($consultadebloqueosporTDResponse1/Status/successIndicator) }</successIndicator>,
				<messages>{ data($consultadebloqueosporTDResponse1/Status/messages) }</messages>
			) else (
				<successIndicator>NO RECORDS</successIndicator>,
				<messages>{ data($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ZERORECORDS) }</messages>
			)
		}
        </ns1:ResponseHeader>
};

declare variable $consultadebloqueosporTDResponse1 as element(ns0:ConsultadebloqueosporTDResponse) external;

xf:consultaDetalleSaldosPignoradosHeaderOut($consultadebloqueosporTDResponse1)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>