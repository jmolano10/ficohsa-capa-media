<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadechequesenreservaResponse1" element="ns0:ConsultadechequesenreservaResponse" location="../Resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaHeaderOut/";

declare function xf:consultaChequesReservaHeaderOut($consultadechequesenreservaResponse1 as element(ns0:ConsultadechequesenreservaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>{ data($consultadechequesenreservaResponse1/Status/successIndicator) }</successIndicator>
            {
            	if (empty($consultadechequesenreservaResponse1/WSCHQCOLLDETAILSType[1]/ZERORECORDS/text())) then (
            		<messages>{ data($consultadechequesenreservaResponse1/Status/messages) }</messages>
            	) else (
            		<messages>{ data($consultadechequesenreservaResponse1/WSCHQCOLLDETAILSType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadechequesenreservaResponse1 as element(ns0:ConsultadechequesenreservaResponse) external;

xf:consultaChequesReservaHeaderOut($consultadechequesenreservaResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_1569843523.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCheque/Resources/XMLSchema_1569843523"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>