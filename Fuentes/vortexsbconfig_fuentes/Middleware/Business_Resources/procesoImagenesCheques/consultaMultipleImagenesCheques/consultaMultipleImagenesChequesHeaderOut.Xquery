<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarImagenesChequesResponse1" element="ns0:consultarImagenesChequesResponse" location="../Resources/XMLSchema_-753785776.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://services.com/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/consultaMultipleImagenesCheques/consultaMultipleImagenesChequesHeaderOut/";

declare function xf:obtener-success-indicator($indicator as xs:string, $numRegistros as xs:string) as xs:string {
	if ($indicator = "true" or $indicator = "TRUE") then (
		"Success"
	) else (
		if ($numRegistros = '0') then
		( "NO RECORDS")
		else
		("Error")
	)
};

declare function xf:consultaMultipleImagenesChequesHeaderOut($consultarImagenesChequesResponse1 as element(ns0:consultarImagenesChequesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>{ xf:obtener-success-indicator(data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/resultadoOperacion),data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/totalChequesEncontrados)) }</successIndicator>
            {
                for $mensajeError in $consultarImagenesChequesResponse1/consultaImagenesChequesResponse/mensajeError
                return
                    <messages>{ data($mensajeError) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultarImagenesChequesResponse1 as element(ns0:consultarImagenesChequesResponse) external;

xf:consultaMultipleImagenesChequesHeaderOut($consultarImagenesChequesResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-753785776.xsd">
        <con:schema ref="Middleware/Business_Resources/procesoImagenesCheques/Resources/XMLSchema_-753785776"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>