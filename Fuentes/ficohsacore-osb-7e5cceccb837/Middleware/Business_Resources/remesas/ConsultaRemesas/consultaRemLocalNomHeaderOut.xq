(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../Resoruces/ConsultarRemLocalNombre/consultarRemLocalNombre_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalNombre";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalNomHeaderOut/";

declare function xf:consultaRemLocalNomHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
        	if ( fn:string($outputParameters1/ns0:PN_ERROR/text()) = "0") then
        	(
        		<successIndicator>SUCCESS</successIndicator>
            ) else (
            	<successIndicator>ERROR</successIndicator>,
            	<messages>{ fn:string($outputParameters1/ns0:PV_ERROR/text()) }</messages>
            )
        }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaRemLocalNomHeaderOut($outputParameters1)