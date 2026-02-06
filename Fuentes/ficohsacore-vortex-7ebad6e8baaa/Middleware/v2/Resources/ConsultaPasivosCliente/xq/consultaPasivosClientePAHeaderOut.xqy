xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/ABKPA/consultaPasivosCliente/xsd/consultaPasivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatosTarjetaCliente/xsd/conDatosTarjetaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetaCliente";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaPrestamos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClientePAHeaderOut/";

declare function xf:consultaPasivosClientePAHeaderOut($outputParameters1 as element(ns2:OutputParameters),
    $outputParameters2 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>{ 
                let $successIndPtmo := fn:string($outputParameters1/ns2:ERROR_CODE/text())
                let $successIndTarj := fn:string($outputParameters2/ns0:CodigoError/text())
                let $successInd := 
                	if ($successIndPtmo = "ERROR" and
                		$successIndTarj != "-1") then (
                		"ERROR"
                	) else if ($successIndPtmo = "NO RECORDS" and
                			   $successIndTarj = "NO RECORDS") then (
                		"NO RECORDS"
                	) else if ($successIndPtmo = "ERROR" and
                			   $successIndTarj = "NO RECORDS") then (
                		"ERROR"
                	) else if ($successIndPtmo = "NO RECORDS" and
                			   $successIndTarj != "-1") then (
                		"ERROR"	
                	) else (
                		"SUCCESS"
                	)
                return
                (
                    <successIndicator>{ $successInd }</successIndicator>,
                    if ($successInd != "SUCCESS" and $successInd != "NO RECORDS") then (
                    	<messages>ERROR OBTENIENDO PRODUCTOS DE CLIENTE</messages>
                    ) else (
                    )
                )
            }</ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns2:OutputParameters) external;
declare variable $outputParameters2 as element(ns0:OutputParameters) external;

xf:consultaPasivosClientePAHeaderOut($outputParameters1,
    $outputParameters2)