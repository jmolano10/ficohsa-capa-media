xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaGestionCancelacionCuentaResponse1" element="ns1:CreaGestionCancelacionCuentaResponse" location="../../../../External/Outgoing/BusinessServices/Salesforce/gestionaCancelacionTarjetaCredito/wsdl/gestionaCancelacionTarjetaCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:cancelarTarjetaCreditoResponse" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarTarjetaCredito/xq/cancelarTarjetaCreditoOut/";

declare function xf:cancelarTarjetaCreditoOut($creaGestionCancelacionCuentaResponse1 as element(ns1:CreaGestionCancelacionCuentaResponse))
    as element(ns0:cancelarTarjetaCreditoResponse) {
        <ns0:cancelarTarjetaCreditoResponse>
            <CASE_DETAILS>
                {
                    for $IdGestion in $creaGestionCancelacionCuentaResponse1/ns1:result/ns1:IdGestion
                    return
                        <REFERENCE>{ data($IdGestion) }</REFERENCE>
                }
                {
                    for $estadoGestion in $creaGestionCancelacionCuentaResponse1/ns1:result/ns1:estadoGestion
                    return
                        <STATUS>{ data($estadoGestion) }</STATUS>
                }
            </CASE_DETAILS>
        </ns0:cancelarTarjetaCreditoResponse>
};

declare variable $creaGestionCancelacionCuentaResponse1 as element(ns1:CreaGestionCancelacionCuentaResponse) external;

xf:cancelarTarjetaCreditoOut($creaGestionCancelacionCuentaResponse1)