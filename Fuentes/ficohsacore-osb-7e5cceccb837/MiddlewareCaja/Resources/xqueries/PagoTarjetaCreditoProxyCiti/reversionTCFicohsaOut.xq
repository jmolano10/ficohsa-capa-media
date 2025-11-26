(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../xsds/RegistrarPagoTcProxyCiti/registraPagoTcProxyCiti_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ecsResponse" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTcProxyCiti";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoProxyCiti/reversionTCFicohsaOut/";

declare function xf:reversionTCFicohsaOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ecsResponse) {
        <ns0:ecsResponse>
            {
                let $PV_CODIGOERROR := fn:string($outputParameters1/ns1:PV_CODIGOERROR/text())
                return
                    if ($PV_CODIGOERROR = "SUCCESS") then (
		    			<ns0:out_referencia>{ fn:string($outputParameters1/ns1:PV_MENSAJEERROR/text()) }</ns0:out_referencia>,
        		        <ns0:out_autorizacion>{ fn:string($outputParameters1/ns1:PV_MENSAJEERROR/text()) }</ns0:out_autorizacion>,
		                <ns0:out_nombre>REVERSION EXITOSA</ns0:out_nombre>,
                    	<ns0:sError>00</ns0:sError>
                    ) else (
    					<ns0:out_referencia>0</ns0:out_referencia>,
		                <ns0:out_autorizacion>0</ns0:out_autorizacion>,
                    	<ns0:out_nombre>{ fn:string($outputParameters1/ns1:PV_MENSAJEERROR/text()) }</ns0:out_nombre>,
                    	<ns0:sError>10</ns0:sError>                    
                    )
            }
        </ns0:ecsResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:reversionTCFicohsaOut($outputParameters1)