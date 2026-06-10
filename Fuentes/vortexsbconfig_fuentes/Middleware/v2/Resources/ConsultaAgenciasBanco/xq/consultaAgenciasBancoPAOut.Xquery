<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaAgenciasBanco/xsd/consultaAgenciasBanco_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAgenciasBancoResponse" location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAgenciasBanco";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAgenciasBanco/xq/consultaAgenciasBancoPAOut/";

declare function xf:consultaAgenciasBancoPAOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaAgenciasBancoResponse) {
        <ns0:consultaAgenciasBancoResponse>
            <ns0:consultaAgenciasBancoResponseType>
            {
            	let $codes := $outputParameters/ns1:BRANCH_CODES/ns1:ITEM
            	let $names := $outputParameters/ns1:BRANCH_NAME/ns1:ITEM
            	return
	            	for $i in (1 to count($codes))
	                return
                 	<ns0:consultaAgenciasBancoResponseRecordType>
                        <BRANCH_CODE>{ data($codes[$i]) }</BRANCH_CODE>
                        <BRANCH_NAME>{ data($names[$i]) }</BRANCH_NAME>
                        <BRANCH_TYPE></BRANCH_TYPE>
                    	<GEOGRAPHIC_ZONE></GEOGRAPHIC_ZONE>
                    	<SERVICES_AVAILABLE>
                        	<SERVICE>
                            	<NAME>ALLOWSCHQBKPRINT</NAME>
                                <VALUE>NONE</VALUE>	
                        	</SERVICE>
                        	<SERVICE>
                            	<NAME>ALLOWSCASHIERCHQPRINT</NAME>
                                <VALUE>NONE</VALUE>	
                        	</SERVICE>
                        	<SERVICE>
                            	<NAME>CHQPRINTZONE</NAME>
                                <VALUE>NONE</VALUE>	
                        	</SERVICE>                        	
                    	</SERVICES_AVAILABLE>
                    </ns0:consultaAgenciasBancoResponseRecordType>
             }
            </ns0:consultaAgenciasBancoResponseType>
        </ns0:consultaAgenciasBancoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaAgenciasBancoPAOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaAgenciasBanco/xsd/consultaAgenciasBanco_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaAgenciasBanco/xsd/consultaAgenciasBanco_sp"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes"/>
    </con:dependency>
</con:xqueryEntry>