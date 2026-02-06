xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/actualizaRelDesembolso/xsd/actualizaRelDesembolso_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaRelDesembolso";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaFinanciamientoTC/xq/actualizaRelDesembolsoIn/";

declare function xf:actualizaRelDesembolsoIn($Usuario as xs:string,
    $SecuenciaCanal as xs:string,
    $SecuenciaConfirmacion as xs:string,
    $TipoProceso as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USUARIO>{ $Usuario }</ns0:PV_USUARIO>
            <ns0:PV_SECUENCIACANAL>{ $SecuenciaCanal }</ns0:PV_SECUENCIACANAL>
            <ns0:PV_SECUENCIACONFIRMACION>{ $SecuenciaConfirmacion }</ns0:PV_SECUENCIACONFIRMACION>
            <ns0:PV_ESTADO>
            { 
            	if(upper-case($TipoProceso) = 'IMMEDIATE') then(
            		'C'
            	) else(
            		'P'
            	)
            }
            </ns0:PV_ESTADO>
        </ns0:InputParameters>
};

declare variable $Usuario as xs:string external;
declare variable $SecuenciaCanal as xs:string external;
declare variable $SecuenciaConfirmacion as xs:string external;
declare variable $TipoProceso as xs:string external;

xf:actualizaRelDesembolsoIn($Usuario,
    $SecuenciaCanal,
    $SecuenciaConfirmacion,
    $TipoProceso)