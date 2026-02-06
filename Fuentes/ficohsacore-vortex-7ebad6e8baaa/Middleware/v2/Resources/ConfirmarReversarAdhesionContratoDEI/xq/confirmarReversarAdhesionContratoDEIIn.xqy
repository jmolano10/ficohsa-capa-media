xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$confirmarReversarAdhesionContratoRequest" element="ns0:confirmarReversarAdhesionContratoRequest" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/confirmarReversarAdhesionContrato/xsd/confirmarReversarAdhesionContrato_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/confirmarReversarAdhesionContrato";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmarReversarAdhesionContratoDEI/xq/confirmarReversarAdhesionContratoDEIIn/";

declare function xf:confirmarReversarAdhesionContratoDEIIn($confirmarReversarAdhesionContratoRequest as element(ns0:confirmarReversarAdhesionContratoRequest),
	$requestHeader as element(ns2:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_AUDITORIA>
                <ns1:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns1:USUARIO_SERVICIO>
                <ns1:PROCESO_ORIGEN_ERROR>TributosDEI.confirmarReversarAdhesionContrato</ns1:PROCESO_ORIGEN_ERROR>
            </ns1:PT_AUDITORIA>
            <ns1:PV_IDPROCESO>{ data($confirmarReversarAdhesionContratoRequest/PROCESS_ID) }</ns1:PV_IDPROCESO>
            
            {
            	let $Confirmacion := fn:string($confirmarReversarAdhesionContratoRequest/CONFIRM/text())
            	return
            	
            	if ($Confirmacion="YES") then(
            		<ns1:PN_CONFIRMACION>1</ns1:PN_CONFIRMACION>
            	)else(
            		<ns1:PN_CONFIRMACION>0</ns1:PN_CONFIRMACION>
            	)
            }
        </ns1:InputParameters>
};

declare variable $confirmarReversarAdhesionContratoRequest as element(ns0:confirmarReversarAdhesionContratoRequest) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:confirmarReversarAdhesionContratoDEIIn($confirmarReversarAdhesionContratoRequest, $requestHeader)