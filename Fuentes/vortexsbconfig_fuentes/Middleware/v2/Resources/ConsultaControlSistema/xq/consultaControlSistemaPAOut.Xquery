<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataREG/validaMasterData/xsd/consultaValidaMasterData_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaControlSistemaResponse" location="../../AlertasProductos/xsd/alertasProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/alertasProductosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaValidaMasterData";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaControlSistema/xq/consultaControlSistemaHNOut/";

declare function obtenerXMLPaises()
    as element(*){
    	<COUNTRY_CODES>
		 	<COUNTRY_CODE osb="GT01">GTM</COUNTRY_CODE>
		    <COUNTRY_CODE osb="HN01">HND</COUNTRY_CODE>
		    <COUNTRY_CODE osb="NI01">NIC</COUNTRY_CODE>
		    <COUNTRY_CODE osb="PA01">PAN</COUNTRY_CODE>
		</COUNTRY_CODES>
    };

declare function xf:consultaControlSistemaHNOut($outputParameters as element(ns1:OutputParameters),$flag as xs:string)
    as element(ns0:consultaControlSistemaResponse) {
        <ns0:consultaControlSistemaResponse>
            <APPLICATIONS>
            	{
                    for $i in (1 to count($outputParameters/ns1:RowSet/ns1:Row))
                    return
                    	<APPLICATION>
                    		<REGION>{ string(obtenerXMLPaises()/COUNTRY_CODE[ text()=data($outputParameters/ns1:RowSet/ns1:Row[$i]//ns1:Column[@name='Pais']) ]/@osb) }</REGION>
                    		<AVAILABLE_QUERY>{ data($outputParameters/ns1:RowSet/ns1:Row[$i]//ns1:Column[@name='FLAG']) }</AVAILABLE_QUERY>
                		</APPLICATION>
                }
                {
                	if(string($flag) = '1')then(
                        <APPLICATION>
							<REGION>HN01</REGION>
							<AVAILABLE_QUERY>YES</AVAILABLE_QUERY>
						</APPLICATION>
                    )else()
                }
            </APPLICATIONS>
        </ns0:consultaControlSistemaResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $flag as xs:string external;

xf:consultaControlSistemaHNOut($outputParameters,$flag)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterDataREG/validaMasterData/xsd/consultaValidaMasterData_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataREG/validaMasterData/xsd/consultaValidaMasterData_sp"/>
    </con:dependency>
    <con:dependency location="../../AlertasProductos/xsd/alertasProductosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/AlertasProductos/xsd/alertasProductosTypes"/>
    </con:dependency>
</con:xqueryEntry>